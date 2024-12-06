using Service.Contracts;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service.Connection.Lobby
{
    public class LobbyConnectionManager
    {
        private readonly ConcurrentDictionary<string, ILobbyCallback> _connectedInLobbyPlayers = new ConcurrentDictionary<string, ILobbyCallback>();

        public bool RegisterPlayer(string username, ILobbyCallback callback)
        {
            return _connectedInLobbyPlayers.TryAdd(username, callback);
        }

        public bool UnregisterPlayer(string username)
        {
            return _connectedInLobbyPlayers.TryRemove(username, out _);
        }

        public bool TryGetCallback(string username, out ILobbyCallback callback)
        {
            return _connectedInLobbyPlayers.TryGetValue(username, out callback);
        }

        public IReadOnlyDictionary<string, ILobbyCallback> GetConnectedPlayers()
        {
            return _connectedInLobbyPlayers;
        }

    }
}
