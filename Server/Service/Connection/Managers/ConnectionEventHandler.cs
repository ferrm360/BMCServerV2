using System.ServiceModel;
using System;

namespace Service.Connection.Managers
{
    public class ConnectionEventHandler
    {
        private readonly ConnectionManager _connectionManager;

        public ConnectionEventHandler(ConnectionManager connectionManager)
        {
            _connectionManager = connectionManager;
        }

        public void RegisterChannelEvents(string username, IContextChannel channel)
        {
            if (_connectionManager.IsUserRegistered(username))
            {
                Console.WriteLine($"User {username} is already registered.");
                return;
            }

            Console.WriteLine($"User {username} has been register.");

            channel.Closed += (sender, args) => HandleDisconnection(username);
            channel.Faulted += (sender, args) => HandleDisconnection(username);

            _connectionManager.RegisterUser(username, channel);
        }

        public void HandleDisconnection(string username)
        {
            if (_connectionManager.IsUserRegistered(username))
            {
                _connectionManager.UnregisterUser(username);
                Console.WriteLine($"User {username} has been disconnected and unregistered.");
            }
        }
    }
}