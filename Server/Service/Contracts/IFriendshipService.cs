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
    [ServiceContract]
    public interface IFriendshipService
    {
        [OperationContract]
        OperationResponse SendFriendRequest(string senderUsername, string reciveUsername);
        [OperationContract]
        OperationResponse AcceptFriendRequest(int idRequest);
        [OperationContract]
        OperationResponse RejectFriendResponse(int idResponse);
        [OperationContract]
        FriendListResponse GetFriendList (string username);
        [OperationContract]
        FriendRequestListReponse GetFriendRequestList(string username);
        [OperationContract]
        FriendListResponse GetPlayersList(string username);
        [OperationContract]
        PlayerProfileResponse GetPlayersListByUsername(string playerUsername, string loggedUsername);
        [OperationContract]
        OperationResponse DeleteFriend(string currentPlayer, string friend);
    }
}
