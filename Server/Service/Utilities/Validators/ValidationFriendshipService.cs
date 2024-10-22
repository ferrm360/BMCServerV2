﻿using DataAccess.Repositories;
using Service.Results;
using Service.Utilities.Constans;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service.Utilities.Validators
{
    public class ValidationFriendshipService
    {
        private readonly IPlayerRepository _playerRepository;
        private readonly IFriendRequestRepository _friendRequestRepository;

        public ValidationFriendshipService(IPlayerRepository playerRepository, IFriendRequestRepository friendRequestRepository)
        {
            _playerRepository = playerRepository;
            _friendRequestRepository = friendRequestRepository;
        }

        public OperationResult ValidateFriendRequestDoesNotExist(int senderPlayerId, int receiverPlayerId)
        {
            if (_friendRequestRepository.IsFriendRequestPending(senderPlayerId, receiverPlayerId))
            {
                return OperationResult.Failure("A friend request is already pending between these users.");
            }

            return OperationResult.SuccessResult();
        }

        public OperationResult ValidateFriendRequestExists(int requestId)
        {
            var receivedRequests = _friendRequestRepository.GetReceivedRequests(requestId);
            var sentRequests = _friendRequestRepository.GetSentRequests(requestId);

            if (receivedRequests == null && sentRequests == null)
            {
                return OperationResult.Failure("Friend request not found.");
            }

            return OperationResult.SuccessResult();
        }


    }
}
