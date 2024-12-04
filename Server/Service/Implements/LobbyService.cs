using Service.Contracts;
using Service.DTO;
using Service.Entities;
using Service.Results;
using Service.Utilities.Constans;
using Service.Utilities.Results;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;

namespace Service.Implements
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerSession, ConcurrencyMode = ConcurrencyMode.Multiple)]
    public class LobbyService : ILobbyService
    {
        private static readonly Dictionary<string, Lobby> _activeLobbies = new Dictionary<string, Lobby>();
        private static readonly ConcurrentDictionary<string, ILobbyCallback> _connectedPlayers = new ConcurrentDictionary<string, ILobbyCallback>();

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

            RegisterCallback(request.Username);

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
            RegisterCallback(request.Username);

            NotifyPlayersInLobby(lobby, request.Username);

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

        public LobbyResponse LeaveLobby(string lobbyId, string username)
        {
            if (!_activeLobbies.TryGetValue(lobbyId, out var lobby))
            {
                return LobbyResponse.Failure(ErrorMessages.LobbyNotFound);
            }

            lobby.RemovePlayer(username);
            _connectedPlayers.TryRemove(username, out _);

            NotifyPlayerLeft(lobby, username);

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

        private void RegisterCallback(string username)
        {
            var callback = OperationContext.Current.GetCallbackChannel<ILobbyCallback>();
            _connectedPlayers.TryAdd(username, callback);

            var contextChannel = (IContextChannel)callback;
            contextChannel.Closed += (sender, args) => HandleClientDisconnect(username);
            contextChannel.Faulted += (sender, args) => HandleClientDisconnect(username);
        }

        private void HandleClientDisconnect(string username)
        {
            if (_connectedPlayers.TryRemove(username, out _))
            {
                var lobby = _activeLobbies.Values.FirstOrDefault(l => l.Players.Contains(username));
                if (lobby != null)
                {
                    lobby.RemovePlayer(username);
                    NotifyPlayerLeft(lobby, username);

                    if (lobby.IsEmpty())
                    {
                        _activeLobbies.Remove(lobby.LobbyId);
                    }
                }
            }
        }

        private void NotifyPlayersInLobby(Lobby lobby, string newPlayer)
        {
            string joinMessage = $"{newPlayer} has joined the lobby {lobby.Name}.";
            Console.WriteLine(joinMessage);

            foreach (var player in lobby.Players)
            {
                if (player != newPlayer && _connectedPlayers.TryGetValue(player, out var callback))
                {
                    try
                    {
                        callback.NotifyPlayerJoined(newPlayer, lobby.LobbyId);
                        callback.NotifyPlayerJoinedMessage(joinMessage);
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine($"Error notifying player {player}: {ex.Message}");
                        HandleClientDisconnect(player);
                    }
                }
            }
        }

        private void NotifyPlayerLeft(Lobby lobby, string playerLeft)
        {
            string leaveMessage = $"{playerLeft} has left the lobby {lobby.Name}.";
            Console.WriteLine(leaveMessage);

            foreach (var player in lobby.Players)
            {
                if (player != playerLeft && _connectedPlayers.TryGetValue(player, out var callback))
                {
                    try
                    {
                        callback.NotifyPlayerLeft(playerLeft, lobby.LobbyId);
                        callback.NotifyPlayerLeftMessage(leaveMessage);
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine($"Error notifying player {player}: {ex.Message}");
                        HandleClientDisconnect(player);
                    }
                }
            }
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
            _connectedPlayers.TryRemove(targetUsername, out _);

            NotifyPlayerLeft(lobby, targetUsername);

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

        public OperationResponse StartGame(string lobbyId, string hostUsername)
        {
            if (!_activeLobbies.TryGetValue(lobbyId, out var lobby))
            {
                return OperationResponse.Failure(LobbyMessages.LobbyNotFound);
            }

            if (lobby.Host != hostUsername)
            {
                return OperationResponse.Failure(LobbyMessages.OnlyHostStart);
            }

            if (lobby.Players.Count < 2)
            {
                return OperationResponse.Failure(LobbyMessages.NotEnoughPlayer);
            }

            if (!NotifyPlayersStartGame(lobby))
            {
                return OperationResponse.Failure(LobbyMessages.NotificationMissing);
            }

            return OperationResponse.SuccessResult(LobbyMessages.GameStarted);
        }

        private bool NotifyPlayersStartGame(Lobby lobby)
        {
            bool allNotificationsSuccessful = true;

            foreach (var player in lobby.Players)
            {
                if (player == lobby.Host) continue;

                if (_connectedPlayers.TryGetValue(player, out var callback))
                {
                    try
                    {
                        callback.StartGameNotification(lobby.LobbyId);
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine($"Error notifying player {player} of game start: {ex.Message}");
                        HandleClientDisconnect(player);
                        allNotificationsSuccessful = false;
                    }
                }
            }
            return allNotificationsSuccessful;
        }

        public void RemoveLobby(string lobbyId)
        {
            if (_activeLobbies.ContainsKey(lobbyId))
            {
                _activeLobbies.Remove(lobbyId);
                Console.WriteLine($"Lobby {lobbyId} eliminada de los lobbies activos.");
            }
            else
            {
                Console.WriteLine($"Lobby {lobbyId} no encontrada.");
            }
        }

    }
}
