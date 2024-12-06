using DataAccess.Repositories;
using Service.Results;
using Service.Utilities.Constans;

namespace Service.Utilities.Validators.FriendshipService
{
    public class ValidationFriendshipService : IValidationFriendshipService
    {
        private readonly IPlayerRepository _playerRepository;
        private readonly IFriendRequestRepository _friendRequestRepository;

        public ValidationFriendshipService(IPlayerRepository playerRepository, IFriendRequestRepository friendRequestRepository)
        {
            _playerRepository = playerRepository;
            _friendRequestRepository = friendRequestRepository;
        }

        public OperationResponse ValidateFriendRequestDoesNotExist(int senderPlayerId, int receiverPlayerId)
        {
            if (_friendRequestRepository.IsFriendRequestPending(senderPlayerId, receiverPlayerId))
            {
                return OperationResponse.Failure("A friend request is already pending between these users.");
            }
            return OperationResponse.SuccessResult();
        }

        public OperationResponse ValidateUserExists(string username)
        {
            var player = _playerRepository.GetByUsername(username);
            if (player == null)
            {
                return OperationResponse.Failure(ErrorMessages.UserNotFound);
            }
            return OperationResponse.SuccessResult();
        }

        public OperationResponse ValidateFriendRequestExists(int requestId)
        {
            var receivedRequests = _friendRequestRepository.GetReceivedRequests(requestId);
            var sentRequests = _friendRequestRepository.GetSentRequests(requestId);

            if (receivedRequests == null && sentRequests == null)
            {
                return OperationResponse.Failure("Friend request not found.");
            }
            return OperationResponse.SuccessResult();
        }
    }
}
