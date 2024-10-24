using Service.DTO;
using Service.Results;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

namespace Service.Contracts
{
    [ServiceContract]
    public interface IFriendshipService
    {
        [OperationContract]
        OperationResult SendFriendRequest(string senderUsername, string reciveUsername);
        [OperationContract]
        OperationResult AcceptFriendRequest(int idRequest);
        [OperationContract]
        OperationResult RejectFriendResponse(int idResponse);
        [OperationContract]
        List<PlayerDTO> GetFriendList (string username);
        [OperationContract]
        OperationResult GetFriendRequestList(string username);
        [OperationContract]
        string TestConnection();
    }
}
