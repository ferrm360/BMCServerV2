using Service.Contracts;
using Service.DTO;
using Service.Entities;
using Service.Utilities;
using Service.Utilities.Constans;
using Service.Utilities.Results;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;

namespace Service.Implements
{
    // TODO ver si se va el host que pasa.
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.Single)]
    public class LobbyService : ILobbyService
    {
        private readonly Dictionary<string, Lobby> _activeLobbies = new Dictionary<string, Lobby>();
        private readonly ConcurrentDictionary<string, ILobbyCallback> _callbacks = new ConcurrentDictionary<string, ILobbyCallback>();


        public LobbyResponse CreateLobby(CreateLobbyRequestDTO request)
        {
            if (_activeLobbies.Values.Any(l => l.Name == request.Name))
            {
                return LobbyResponse.Failure(ErrorMessages.DuplicateLobbyName);
            }

            var lobby = new Lobby
            {
                Name = request.Name,
                IsPrivate = request.IsPrivate,
                Password = request.IsPrivate ? request.Password : null,
                Host = request.Username
            };

            // Registrar el canal de callback del jugador que crea la lobby (el host)
            var callback = OperationContext.Current.GetCallbackChannel<ILobbyCallback>();
            if (!_callbacks.ContainsKey(request.Username))
            {
                _callbacks.TryAdd(request.Username, callback);
                Console.WriteLine($"Callback registrado para el host de la lobby: {request.Username}");
            }

            lobby.AddPlayer(request.Username);
            _activeLobbies[lobby.LobbyId] = lobby;

            var lobbyDto = new LobbyDTO
            {
                LobbyId = lobby.LobbyId,
                Name = lobby.Name,
                IsPrivate = lobby.IsPrivate,
                CurrentPlayers = lobby.Players.Count,
                MaxPlayers = lobby.MaxPlayers,
                Host = lobby.Host,
                Players = new List<string>(lobby.Players)
            };

            return LobbyResponse.SuccessResult(lobbyDto);
        }



        public LobbyResponse JoinLobby(JoinLobbyRequestDTO request)
        {
            if (!_activeLobbies.TryGetValue(request.LobbyId, out var lobby))
            {
                return LobbyResponse.Failure(ErrorMessages.LobbyNotFound);
            }

            if (lobby.IsPrivate && lobby.Password != request.Password)
            {
                return LobbyResponse.Failure(ErrorMessages.InvalidLobbyPassword);
            }

            if (!lobby.CanJoin(request.Username, request.Password))
            {
                return LobbyResponse.Failure(ErrorMessages.LobbyFull);
            }

            lobby.AddPlayer(request.Username);

            // Capturar el canal de callback actual y registrarlo
            var callback = OperationContext.Current.GetCallbackChannel<ILobbyCallback>();
            _callbacks.TryAdd(request.Username, callback);

            // Notificar a todos los jugadores de la lobby que un nuevo jugador se ha unido
            foreach (var player in lobby.Players)
            {
                // Evitar enviar la notificación al jugador que se acaba de unir
                if (player != request.Username)
                {
                    try
                    {
                        Console.WriteLine("Intentando notificar a: " + player);
                        // Verificar si el callback está disponible para el jugador
                        if (_callbacks.TryGetValue(player, out var playerCallback))
                        {
                            playerCallback.NotifyPlayerJoined(request.Username, request.LobbyId);
                            Console.WriteLine("Notificación enviada a: " + player);
                            CustomLogger.Info($"Player '{request.Username}' successfully joined the lobby '{request.LobbyId}' and notification sent.");
                        }
                        else
                        {
                            Console.WriteLine($"No se encontró callback para el jugador: {player}");
                            CustomLogger.Warn($"No callback found for player '{player}' to notify join.");
                        }
                    }
                    catch (CommunicationException ex)
                    {
                        CustomLogger.Error($"Error notifying player '{player}' about join to the lobby '{request.LobbyId}': {ex.Message}");
                        _callbacks.TryRemove(player, out _);
                    }
                }
            }

            return LobbyResponse.SuccessResult(new LobbyDTO
            {
                LobbyId = lobby.LobbyId,
                Name = lobby.Name,
                IsPrivate = lobby.IsPrivate,
                CurrentPlayers = lobby.Players.Count,
                MaxPlayers = lobby.MaxPlayers,
                Host = lobby.Host,
                Players = new List<string>(lobby.Players)
            });
        }



        public LobbyResponse LeaveLobby(string lobbyId, string username)
        {
            if (!_activeLobbies.TryGetValue(lobbyId, out var lobby))
            {
                return LobbyResponse.Failure(ErrorMessages.LobbyNotFound);
            }

            lobby.RemovePlayer(username);

            if (lobby.IsEmpty())
            {
                _activeLobbies.Remove(lobbyId);
            }

            var lobbyDto = new LobbyDTO
            {
                LobbyId = lobby.LobbyId,
                Name = lobby.Name,
                IsPrivate = lobby.IsPrivate,
                CurrentPlayers = lobby.Players.Count,
                MaxPlayers = lobby.MaxPlayers,
                Host = lobby.Host,
                Players = new List<string>(lobby.Players)
            };

            return LobbyResponse.SuccessResult(lobbyDto);
        }


        public LobbyResponse KickPlayer(string lobbyId, string hostUsername, string targetUsername)
        {
            if (!_activeLobbies.TryGetValue(lobbyId, out var lobby))
            {
                return LobbyResponse.Failure(ErrorMessages.LobbyNotFound);
            }

            if (lobby.Host != hostUsername)
            {
                return LobbyResponse.Failure(ErrorMessages.NotLobbyHost);
            }

            if (!lobby.Players.Contains(targetUsername))
            {
                return LobbyResponse.Failure(ErrorMessages.PlayerNotInLobby);
            }

            lobby.RemovePlayer(targetUsername);

            var lobbyDto = new LobbyDTO
            {
                LobbyId = lobby.LobbyId,
                Name = lobby.Name,
                IsPrivate = lobby.IsPrivate,
                CurrentPlayers = lobby.Players.Count,
                MaxPlayers = lobby.MaxPlayers,
                Host = lobby.Host,
                Players = new List<string>(lobby.Players)
            };

            return LobbyResponse.SuccessResult(lobbyDto);
        }

        public List<LobbyDTO> GetAllLobbies()
        {
            return _activeLobbies.Values.Select(lobby => new LobbyDTO
            {
                LobbyId = lobby.LobbyId,
                Name = lobby.Name,
                IsPrivate = lobby.IsPrivate,
                CurrentPlayers = lobby.Players.Count,
                MaxPlayers = lobby.MaxPlayers,
                Host = lobby.Host,
                Players = new List<string>(lobby.Players)
            }).ToList();
        }
    }
}
