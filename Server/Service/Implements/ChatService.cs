using Service.Contracts;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using Service.DTO;
using DataAccess;

namespace Service.Implements
{
    /// <summary>
    /// Provides chat functionality for real-time communication between users.
    /// </summary>
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.Single)]
    public class ChatService : IChatService
    {
        /// <summary>
        /// Stores the list of connected users and their corresponding callback channels.
        /// </summary>
        private readonly Dictionary<string, IChatServiceCallback> _connectedUsers = new Dictionary<string, IChatServiceCallback>();

        /// <summary>
        /// Registers a user for the chat service and notifies other users of their arrival.
        /// </summary>
        /// <param name="username">The username of the user to register.</param>
        public void RegisterUser(string username)
        {
            var callback = OperationContext.Current.GetCallbackChannel<IChatServiceCallback>();

            if (!_connectedUsers.ContainsKey(username))
            {
                _connectedUsers.Add(username, callback);

                SendMessage("System", $"{username} has joined the chat.");
                IContextChannel contextChannel = (IContextChannel)callback;
                contextChannel.Closed += (sender, args) => DisconnectUser(username);
                contextChannel.Faulted += (sender, args) => DisconnectUser(username);
            }
        }

        /// <summary>
        /// Disconnects a user from the chat service and notifies other users of their departure.
        /// </summary>
        /// <param name="username">The username of the user to disconnect.</param>
        public void DisconnectUser(string username)
        {
            if (_connectedUsers.ContainsKey(username))
            {
                _connectedUsers.Remove(username);

                SendMessage("System", $"{username} has left the chat.");
            }
        }

        /// <summary>
        /// Sends a message from one user to all other connected users.
        /// </summary>
        /// <param name="username">The username of the sender.</param>
        /// <param name="message">The message content.</param>
        public void SendMessage(string username, string message)
        {
            string fullMessage = $"{username}: {message}";

            foreach (var userCallback in _connectedUsers)
            {

                try
                {
                    if (userCallback.Key != username)
                    {


                        userCallback.Value.ReceiveMessage(fullMessage);
                    }
                }
                catch (CommunicationException ex)
                {
                    Console.WriteLine($"Communication error sending message to {userCallback.Key}: {ex.Message}");
                }
                catch (TimeoutException ex)
                {
                    Console.WriteLine($"Timeout error sending message to {userCallback.Key}: {ex.Message}");
                }
                catch (ObjectDisposedException ex)
                {
                    Console.WriteLine($"Channel disposed for {userCallback.Key}: {ex.Message}");
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Unexpected error sending message to {userCallback.Key}: {ex.Message}");
                }
            }
        }
    }
}

