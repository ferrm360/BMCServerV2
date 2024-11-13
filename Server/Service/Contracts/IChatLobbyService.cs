using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

namespace Service.Contracts
{
    [ServiceContract(CallbackContract = typeof(IChatLobbyCallback))]
    public interface IChatLobbyService
    {
        [OperationContract]
        void RegisterUser(string username, string lobbyId);

        [OperationContract(IsOneWay = true)]
        void SendMessage(string lobbyId, string username, string message);
    }

    public interface IChatLobbyCallback
    {
        [OperationContract(IsOneWay = true)]
        void ReceiveMessage(string username, string message);
    }
}
