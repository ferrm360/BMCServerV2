using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

namespace Service.Contracts
{
    /// <summary>
    /// Defines the contract for chat functionalities within a lobby, including user registration and message broadcasting.
    /// </summary>
    [ServiceContract(CallbackContract = typeof(IChatLobbyCallback))]
    public interface IChatLobbyService
    {
        /// <summary>
        /// Registers a user in a specific chat lobby.
        /// </summary>
        /// <param name="username">The username of the user to register.</param>
        /// <param name="lobbyId">The unique identifier of the lobby.</param>
        [OperationContract]
        void RegisterUser(string username, string lobbyId);

        /// <summary>
        /// Sends a message to all users in a specific lobby.
        /// </summary>
        /// <param name="lobbyId">The unique identifier of the lobby.</param>
        /// <param name="username">The username of the sender.</param>
        /// <param name="message">The content of the message to be broadcasted.</param>
        [OperationContract(IsOneWay = true)]
        void SendMessage(string lobbyId, string username, string message);
    }

    /// <summary>
    /// Defines the callback contract for receiving messages in a chat lobby.
    /// </summary>
    public interface IChatLobbyCallback
    {
        /// <summary>
        /// Notifies the client when a new message is received in the lobby.
        /// </summary>
        /// <param name="username">The username of the sender.</param>
        /// <param name="message">The content of the received message.</param>
        [OperationContract(IsOneWay = true)]
        void ReceiveMessage(string username, string message);
    }
}
