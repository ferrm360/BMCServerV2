using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Repositories
{
    public interface IFriendRequestRepository
    {
        void SendFriendRequest(int senderPlayerId, int receiverPlayerId);
        bool IsFriendRequestPending(int senderPlayerId, int receiverPlayerId);
        IEnumerable<FriendRequest> GetReceivedRequests(int receiverPlayerId);
        IEnumerable<FriendRequest> GetSentRequests(int senderPlayerId);
        void AcceptRequest(int requestId);
        void RejectRequest(int requestId);
        void RemoveFriend(int userId, int friendId);
        IEnumerable<Player> GetAcceptedFriends(int playerId);
    }
}
