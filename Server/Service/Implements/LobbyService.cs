using Service.Contracts;
using Service.DTO;
using Service.Entities;
using Service.Results;
using Service.Utilities;
using Service.Utilities.Constans;
using Service.Utilities.Results;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Threading.Tasks;

namespace Service.Implements
{
    /// <summary>
    /// Manages operations related to multiplayer game lobbies.
    /// </summary>
    /// <remarks>
    /// This service supports creating, joining, and leaving lobbies, as well as managing players,
    /// starting games, and broadcasting notifications to connected players.
    /// </remarks>
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerSession, ConcurrencyMode = ConcurrencyMode.Multiple)]
    public class LobbyService : ILobbyService
    {
        /// <summary>
        /// Stores the active game lobbies.
        /// </summary>
        /// <remarks>
        /// The key is the unique lobby ID, and the value is the <see cref="Lobby"/> object representing the lobby.
        /// </remarks>
        private static readonly Dictionary<string, Lobby> _activeLobbies = new Dictionary<string, Lobby>();

        /// <summary>
        /// Stores the connected players in all lobbies along with their callback channels.
        /// </summary>
        /// <remarks>
        /// The key is the username, and the value is the callback channel (<see cref="ILobbyCallback"/>) 
        /// used to notify the player of events in their lobby.
        /// </remarks>
        private static readonly ConcurrentDictionary<string, ILobbyCallback> _connectedPlayersInLobby = new ConcurrentDictionary<string, ILobbyCallback>();

        /// <summary>
        /// Creates a new game lobby.
        /// </summary>
        /// <param name="request">The details of the lobby to be created, including name, privacy settings, and host username.</param>
        /// <returns>A <see cref="LobbyResponse"/> containing the created lobby's details or an error message.</returns>
        public LobbyResponse CreateLobby(CreateLobbyRequestDTO request)
        {
            if (string.IsNullOrWhiteSpace(request.Name))
            {
                return LobbyResponse.Failure(ErrorMessages.LobbyNameNull);
            }

            if (request.Name.Length > 15 || request.Name.Length < 3)
            {
                return LobbyResponse.Failure(ErrorMessages.LobbyInvalidName);
            }

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

        /// <summary>
        /// Allows a player to join an existing lobby.
        /// </summary>
        /// <param name="request">The details of the lobby to join, including the lobby ID, username, and optional password.</param>
        /// <returns>A <see cref="LobbyResponse"/> containing the updated lobby's details or an error message.</returns>
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

        /// <summary>
        /// Allows a player to leave a lobby they are part of.
        /// </summary>
        /// <param name="lobbyId">The unique identifier of the lobby.</param>
        /// <param name="username">The username of the player leaving the lobby.</param>
        /// <returns>A <see cref="LobbyResponse"/> containing the updated lobby's details or an error message.</returns>
        public LobbyResponse LeaveLobby(string lobbyId, string username)
        {
            if (!_activeLobbies.TryGetValue(lobbyId, out var lobby))
            {
                return LobbyResponse.Failure(ErrorMessages.LobbyNotFound);
            }

            lobby.RemovePlayer(username);
            _connectedPlayersInLobby.TryRemove(username, out _);

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

        /// <summary>
        /// Registers a player's callback channel for notifications.
        /// </summary>
        /// <param name="username">The username of the player being registered.</param>
        private void RegisterCallback(string username)
        {
            try
            {
                var callback = OperationContext.Current.GetCallbackChannel<ILobbyCallback>();
                _connectedPlayersInLobby.TryAdd(username, callback);

                var contextChannel = (IContextChannel)callback;
                contextChannel.Closed += (sender, args) => HandleClientDisconnect(username);
                contextChannel.Faulted += (sender, args) => HandleClientDisconnect(username);
            }
            catch (FaultException ex)
            {
                CustomLogger.Error($"FaultException occurred while registering callback for user {username}: {ex.Message}", ex);
                throw new FaultException($"Failed to register callback for user {username}.");
            }
            catch (Exception ex)
            {
                CustomLogger.Error($"Unexpected error in RegisterCallback for user {username}: {ex.Message}", ex);
                throw;
            }

        }

        /// <summary>
        /// Handles client disconnection events and updates the lobby state accordingly.
        /// </summary>
        /// <param name="username">The username of the disconnected player.</param>
        private void HandleClientDisconnect(string username)
        {
            if (_connectedPlayersInLobby.TryRemove(username, out _))
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

        /// <summary>
        /// Sends a notification to all players in the lobby when a new player joins.
        /// </summary>
        /// <param name="lobby">The lobby where the event occurred.</param>
        /// <param name="newPlayer">The username of the player who joined.</param>
        private void NotifyPlayersInLobby(Lobby lobby, string newPlayer)
        {
            string joinMessage = $"{newPlayer} has joined the lobby {lobby.Name}.";
            Console.WriteLine(joinMessage);

            foreach (var player in lobby.Players)
            {
                if (player != newPlayer && _connectedPlayersInLobby.TryGetValue(player, out var callback))
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

        /// <summary>
        /// Sends a notification to all players in the lobby when a player leaves.
        /// </summary>
        /// <param name="lobby">The lobby where the event occurred.</param>
        /// <param name="playerLeft">The username of the player who left.</param>
        private void NotifyPlayerLeft(Lobby lobby, string playerLeft)
        {
            string leaveMessage = $"{playerLeft} has left the lobby {lobby.Name}.";
            Console.WriteLine(leaveMessage);

            foreach (var player in lobby.Players)
            {
                Console.WriteLine(player);
                if (player != playerLeft && _connectedPlayersInLobby.TryGetValue(player, out var callback))
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

        /// <summary>
        /// Retrieves a list of all active lobbies.
        /// </summary>
        /// <returns>A list of <see cref="LobbyDTO"/> objects representing the active lobbies.</returns>
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

        /// <summary>
        /// Kicks a player out of a lobby.
        /// </summary>
        /// <param name="lobbyId">The unique identifier of the lobby.</param>
        /// <param name="hostUsername">The username of the lobby's host.</param>
        /// <param name="targetUsername">The username of the player to be kicked out.</param>
        /// <returns>A <see cref="LobbyResponse"/> containing the updated lobby's details or an error message.</returns>
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

            Task.Run(() =>
            {
                if (TryGetLobbyCallback(targetUsername, out var targetCallback))
                {
                    try
                    {
                        targetCallback.NotifyPlayerKicked();
                        _connectedPlayersInLobby.TryRemove(targetUsername, out _);
                        HandleClientDisconnect(targetUsername);

                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine($"Error notificando al jugador expulsado {targetUsername}: {ex.Message}");
                        HandleClientDisconnect(targetUsername);
                    }
                }
                else
                {
                    Console.WriteLine($"El jugador {targetUsername} ya no está conectado.");
                }
            });

            Task.Run(() =>
            {
                if (TryGetLobbyCallback(hostUsername, out var hostCallback))
                {
                    try
                    {
                        hostCallback.NotifyPlayerLeft(targetUsername, lobbyId);
                        hostCallback.NotifyPlayerLeftMessage($"{targetUsername} has been kicked");

                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine($"Error notificando al host {hostUsername}: {ex.Message}");
                        HandleClientDisconnect(hostUsername);
                    }
                }
            });

            var lobbyDto = new LobbyDTO
            {
                LobbyId = lobby.LobbyId,
                Name = lobby.Name,
                IsPrivate = lobby.IsPrivate,
                CurrentPlayers = lobby.Players.Count,
                MaxPlayers = lobby.MaxPlayers,
                Host = lobby.Host,
                Password = lobby.Password,
                Players = new List<string>(lobby.Players)
            };

            return LobbyResponse.SuccessResult(lobbyDto);
        }

        /// <summary>
        /// Starts a game in the specified lobby if all conditions are met.
        /// </summary>
        /// <param name="lobbyId">The unique identifier of the lobby.</param>
        /// <param name="hostUsername">The username of the lobby's host.</param>
        /// <returns>An <see cref="OperationResponse"/> indicating whether the game was successfully started.</returns>
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

                if (_connectedPlayersInLobby.TryGetValue(player, out var callback))
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

        /// <summary>
        /// Removes a lobby from the active lobby list.
        /// </summary>
        /// <param name="lobbyId">The unique identifier of the lobby to be removed.</param>
        public void RemoveLobby(string lobbyId)
        {
            if (_activeLobbies.ContainsKey(lobbyId))
            {
                _activeLobbies.Remove(lobbyId);
            }
            else
            {
                CustomLogger.Warn($"Lobby {lobbyId} not found.");
            }
        }

        private bool TryGetLobbyCallback(string player, out ILobbyCallback callback)
        {
            return _connectedPlayersInLobby.TryGetValue(player, out callback);
        }

    }
}
