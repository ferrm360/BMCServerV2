using Service.Contracts;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

namespace Service.Connection.Lobby
{
    public class LobbyConnectionEventHandler
    {
        private readonly LobbyConnectionManager _lobbyConnectionManager;

        public LobbyConnectionEventHandler(LobbyConnectionManager lobbyConnectionManager)
        {
            _lobbyConnectionManager = lobbyConnectionManager;
        }

        public void RegisterChannelEvents(string username, ILobbyCallback callback)
        {
            var contextChannel = callback as IContextChannel;
            if (contextChannel != null)
            {
                contextChannel.Closed += (sender, args) => HandlePlayerDisconnection(username);
                contextChannel.Faulted += (sender, args) => HandlePlayerDisconnection(username);
            }
        }

        public void HandlePlayerDisconnection(string username)
        {
            _lobbyConnectionManager.UnregisterPlayer(username);
            Console.WriteLine($"Player {username} has disconnected and been unregistered.");
        }
    }
}
