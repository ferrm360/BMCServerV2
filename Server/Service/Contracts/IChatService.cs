using Service.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

namespace Service.Contracts
{
    [ServiceContract(CallbackContract = typeof(IChatServiceCallback))]
    public interface IChatService
    {
        [OperationContract(IsOneWay = true)]
        void SendMessage(string username, string message);

        [OperationContract(IsOneWay = true)]
        void RegisterUser(string username);

        [OperationContract(IsOneWay = true)]
        void DisconnectUser(string username);
    }

    [ServiceContract]
    public interface IChatServiceCallback
    {
        [OperationContract(IsOneWay = true)]
        void ReceiveMessage(string message);
    }
}
    