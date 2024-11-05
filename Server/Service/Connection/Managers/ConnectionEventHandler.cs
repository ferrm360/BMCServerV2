﻿using System.ServiceModel;
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
            Console.WriteLine($"User {username} has been register.");

            channel.Closed += (sender, args) => HandleDisconnection(username);
            channel.Faulted += (sender, args) => HandleDisconnection(username);
        }

        private void HandleDisconnection(string username)
        {
            _connectionManager.UnregisterUser(username);
            Console.WriteLine($"User {username} has been disconnected and unregistered.");
        }
    }
}