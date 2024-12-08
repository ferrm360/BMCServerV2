using Service.DTO;
using Service.Results;
using Service.Utilities.Results;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

namespace Service.Contracts
{
    /// <summary>
    /// Defines the contract for chat functionalities between friends, including sending messages and retrieving chat history.
    /// </summary>
    [ServiceContract(CallbackContract = typeof(IChatFriendCallback))]
    public interface IChatFriendService
    {
        /// <summary>
        /// Sends a message from one user to another.
        /// </summary>
        /// <param name="senderUsername">The username of the sender.</param>
        /// <param name="receiverUsername">The username of the receiver.</param>
        /// <param name="message">The content of the message to be sent.</param>
        /// <returns>An <see cref="OperationResponse"/> indicating the success or failure of the operation.</returns>
        [OperationContract]
        OperationResponse SendMessageToFriend(string senderUsername, string receiverUsername, string message);

        /// <summary>
        /// Retrieves the chat history between two users.
        /// </summary>
        /// <param name="username1">The username of the first participant in the chat.</param>
        /// <param name="username2">The username of the second participant in the chat.</param>
        /// <returns>A <see cref="ChatFriendResponse"/> containing the chat history between the two users.</returns>
        [OperationContract]
        ChatFriendResponse GetChatHistory(string username1, string username2);
    }

    /// <summary>
    /// Defines the callback contract for receiving real-time messages in a chat between friends.
    /// </summary>
    public interface IChatFriendCallback
    {
        /// <summary>
        /// Notifies the client when a new message is received.
        /// </summary>
        /// <param name="sender">The username of the sender.</param>
        /// <param name="receiver">The username of the receiver.</param>
        /// <param name="message">The content of the received message.</param>
        [OperationContract(IsOneWay = true)]
        void ReceiveMessage(string sender, string receiver, string message);
    }
}
