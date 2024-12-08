using System.ServiceModel;

namespace Service.Contracts
{
    /// <summary>
    /// Defines the contract for chat functionalities, including message sending, user registration, and disconnection handling.
    /// </summary>
    [ServiceContract(CallbackContract = typeof(IChatServiceCallback))]
    public interface IChatService
    {
        /// <summary>
        /// Sends a message to all connected users.
        /// </summary>
        /// <param name="username">The username of the sender.</param>
        /// <param name="message">The content of the message to send.</param>
        [OperationContract(IsOneWay = true)]
        void SendMessage(string username, string message);

        /// <summary>
        /// Registers a new user in the chat service.
        /// </summary>
        /// <param name="username">The username of the user to register.</param>
        [OperationContract(IsOneWay = true)]
        void RegisterUser(string username);

        /// <summary>
        /// Disconnects a user from the chat service.
        /// </summary>
        /// <param name="username">The username of the user to disconnect.</param>
        [OperationContract(IsOneWay = true)]
        void DisconnectUser(string username);
    }

    /// <summary>
    /// Defines the callback contract for receiving messages in the chat service.
    /// </summary>
    [ServiceContract]
    public interface IChatServiceCallback
    {
        /// <summary>
        /// Notifies the client when a new message is received.
        /// </summary>
        /// <param name="message">The content of the received message.</param>
        [OperationContract(IsOneWay = true)]
        void ReceiveMessage(string message);
    }
}
    