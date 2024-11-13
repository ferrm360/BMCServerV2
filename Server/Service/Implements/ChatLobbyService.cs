using Service.Contracts;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

namespace Service.Implements
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerSession, ConcurrencyMode = ConcurrencyMode.Multiple)]
    public class ChatLobbyService : IChatLobbyService
    {
        private static readonly ConcurrentDictionary<string, ConcurrentDictionary<string, IChatLobbyCallback>> _lobbyUsers
           = new ConcurrentDictionary<string, ConcurrentDictionary<string, IChatLobbyCallback>>();

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
                return;

            foreach (var userCallback in usersInLobby.Values)
            {
                try
                {
                    userCallback.ReceiveMessage(username, message);
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Error sending message to {username}: {ex.Message}");
                }
            }
        }
    }
}
