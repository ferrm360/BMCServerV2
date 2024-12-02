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
    [ServiceContract(CallbackContract = typeof(IChatFriendCallback))]
    public interface IChatFriendService
    {
        [OperationContract]
        OperationResponse SendMessageToFriend(string senderUsername, string receiverUsername, string message);
        [OperationContract]
        ChatFriendResponse GetChatHistory(string username1, string username2);
    }

    public interface IChatFriendCallback
    {
        [OperationContract(IsOneWay = true)]
        void ReceiveMessage(string sender, string receiver, string message);
    }
}
