using Service.Contracts;
using Service.Utilities;
using System;
using System.Collections.Concurrent;
using System.ServiceModel;

namespace Service.Implements
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerSession, ConcurrencyMode = ConcurrencyMode.Multiple)]
    public class ChatLobbyService : IChatLobbyService
    {
        private static readonly ConcurrentDictionary<string, ConcurrentDictionary<string, IChatLobbyCallback>> _lobbyUsers = new ConcurrentDictionary<string, ConcurrentDictionary<string, IChatLobbyCallback>>();

        public void RegisterUser(string username, string lobbyId)
        {
            var callback = OperationContext.Current.GetCallbackChannel<IChatLobbyCallback>();

            if (!_lobbyUsers.ContainsKey(lobbyId))
            {
                _lobbyUsers[lobbyId] = new ConcurrentDictionary<string, IChatLobbyCallback>();
            }

            _lobbyUsers[lobbyId][username] = callback;
        }

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
                catch (Exception ex)
                {
                    CustomLogger.Warn(ex.Message);
                    Console.WriteLine($"Error sending message to {username}: {ex.Message}");
                }
            }
        }
    }
}
