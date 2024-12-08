using Service.Contracts;
using Service.Utilities;
using System;
using System.Collections.Concurrent;
using System.ServiceModel;

namespace Service.Implements
{
    /// <summary>
    /// Provides services for managing chat functionality within lobbies.
    /// </summary>
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerSession, ConcurrencyMode = ConcurrencyMode.Multiple)]
    public class ChatLobbyService : IChatLobbyService
    {
        /// <summary>
        /// Stores the users in each lobby along with their callback channels for communication.
        /// </summary>
        private static readonly ConcurrentDictionary<string, ConcurrentDictionary<string, IChatLobbyCallback>> _lobbyUsers = new ConcurrentDictionary<string, ConcurrentDictionary<string, IChatLobbyCallback>>();

        /// <summary>
        /// Registers a user to a specific lobby.
        /// </summary>
        /// <param name="username">The username of the user.</param>
        /// <param name="lobbyId">The unique identifier of the lobby.</param>
        public void RegisterUser(string username, string lobbyId)
        {
            var callback = OperationContext.Current.GetCallbackChannel<IChatLobbyCallback>();

            if (!_lobbyUsers.ContainsKey(lobbyId))
            {
                _lobbyUsers[lobbyId] = new ConcurrentDictionary<string, IChatLobbyCallback>();
            }

            _lobbyUsers[lobbyId][username] = callback;
        }

        /// <summary>
        /// Sends a message to all users in a specific lobby.
        /// </summary>
        /// <param name="lobbyId">The unique identifier of the lobby.</param>
        /// <param name="username">The username of the sender.</param>
        /// <param name="message">The content of the message.</param>
        public void SendMessage(string lobbyId, string username, string message)
        {
            if (!_lobbyUsers.TryGetValue(lobbyId, out var usersInLobby))
            {
                return;
            }

            foreach (var userCallback in usersInLobby.Values)
            {
                try
                {
                    userCallback.ReceiveMessage(username, message);
                }
                catch (CommunicationException ex)
                {
                    CustomLogger.Warn($"Communication error with {username}: {ex.Message}");
                }
                catch (TimeoutException ex)
                {
                    CustomLogger.Warn($"Timeout sending message to {username}: {ex.Message}");
                }
                catch (ObjectDisposedException ex)
                {
                    CustomLogger.Warn($"Channel disposed for {username}: {ex.Message}");
                }
                catch (Exception ex)
                {
                    CustomLogger.Error($"Unexpected error sending message to {username}: {ex.Message}");
                }
            }
        }
    }
}
