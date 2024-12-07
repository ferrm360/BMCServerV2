using Service.Results;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service.Utilities.Validators.FriendshipService
{
    public interface IValidationFriendshipService
    {
        OperationResponse ValidateFriendRequestDoesNotExist(int senderPlayerId, int receiverPlayerId);
        OperationResponse ValidateUserExists(string username);
        OperationResponse ValidateFriendRequestExists(int requestId);
    }
}
