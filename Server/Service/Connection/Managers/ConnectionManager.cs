using System.Collections.Concurrent;
using System.Collections.Generic;
using System.ServiceModel;

namespace Service.Connection.Managers
{
    public class ConnectionManager
    {
        private readonly ConcurrentDictionary<string, IContextChannel> _activeUsers = new ConcurrentDictionary<string, IContextChannel>();

        public bool RegisterUser(string username, IContextChannel channel)
        {
            return _activeUsers.TryAdd(username, channel);
        }

        public bool IsUserRegistered(string username)
        {
            return _activeUsers.ContainsKey(username);
        }

        public bool UnregisterUser(string username)
        {
            return _activeUsers.TryRemove(username, out _);
        }

        public IReadOnlyDictionary<string, IContextChannel> GetActiveUsers() => _activeUsers;
    }
}