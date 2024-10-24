using DataAccess;
using DataAccess.Repositories;
using Service.Contracts;
using Service.DTO;
using Service.Results;
using Service.Utilities.Constans;
using Service.Utilities.Validators;
using System;
using Service.Utilities;
using System.Linq;
using System.Collections.Generic;
using Service.Utilities.Results;

namespace Service.Implements
{
    //TODO Corregir logger
    public class FriendshipService : IFriendshipService
    {
        private readonly IPlayerRepository _playerRepository;
        private readonly IFriendRequestRepository _friendRequestRepository;
        private readonly ValidationFriendshipService _validationService;

        public FriendshipService(IPlayerRepository playerRepository, IFriendRequestRepository friendRequestRepository, ValidationFriendshipService validationService)
        {
            _playerRepository = playerRepository;
            _friendRequestRepository = friendRequestRepository;
            _validationService = validationService;
        }

        public string TestConnection()
        {
            return "Connection successful";
        }

        public OperationResponse AcceptFriendRequest(int idRequest)
        {
            try
            {
                _friendRequestRepository.AcceptRequest(idRequest);
                _friendRequestRepository.Save();

                return OperationResponse.SuccessResult();
            }
            catch (Exception ex)
            {
                CustomLogger.Error("", ex);
                return OperationResponse.Failure(ErrorMessages.GeneralException);
            }
        }

        public FriendListResponse GetFriendList(string username)
        {
            try
            {
                CustomLogger.Info($"[GetFriendList] Starting GetFriendList for user: {username}");

                var player = _playerRepository.GetByUsername(username);
                if (player == null)
                {
                    CustomLogger.Warn($"[GetFriendList] Player with username '{username}' not found.");
                    return FriendListResponse.Failure("UserNotFound");
                }

                CustomLogger.Info($"[GetFriendList] Fetching accepted friends for PlayerID: {player.PlayerID}");
                var friends = _friendRequestRepository.GetAcceptedFriends(player.PlayerID);

                if (friends == null || !friends.Any())
                {
                    CustomLogger.Info($"[GetFriendList] No friends found for user '{username}' (PlayerID: {player.PlayerID}).");
                    return FriendListResponse.SuccessResult(new List<PlayerDTO>());
                }

                var friendDTOs = friends.Select(friend => new PlayerDTO
                {
                    PlayerID = friend.PlayerID,
                    Username = friend.Username,
                    Email = friend.Email
                }).ToList();

                CustomLogger.Info($"[GetFriendList] Found {friendDTOs.Count} friends for user '{username}'.");

                return FriendListResponse.SuccessResult(friendDTOs);
            }
            catch (Exception ex)
            {
                CustomLogger.Error($"[GetFriendList] Error while retrieving friend list for user '{username}': {ex.Message}", ex);
                return FriendListResponse.Failure(ErrorMessages.GeneralException);
            }
        }



        public OperationResponse GetFriendRequestList(string username)
        {
            try
            {
                var player = _playerRepository.GetByUsername(username);
                if (player == null)
                {
                    return OperationResponse.Failure("User not found.");
                }

                var requests = _friendRequestRepository.GetReceivedRequests(player.PlayerID);

                var requestDTOs = requests.Select(request => new FriendRequestDTO
                {
                    RequestID = request.RequestID,
                    SenderUsername = request.Player.Username,
                    ReceiverUsername = request.Player1.Username,
                    Status = request.RequestStatus.ToString()
                }).ToList();

                return OperationResponse.SuccessResult(requestDTOs);
            }
            catch (Exception ex)
            {
                CustomLogger.Error("", ex);
                return OperationResponse.Failure(ErrorMessages.GeneralException);
            }
        }

        public OperationResponse RejectFriendResponse(int idResponse)
        {
            try
            {
                _friendRequestRepository.RejectRequest(idResponse);
                _friendRequestRepository.Save();

                return OperationResponse.SuccessResult();
            }
            catch (Exception ex)
            {
                CustomLogger.Error("", ex);
                return OperationResponse.Failure(ErrorMessages.GeneralException);
            }
        }

        public OperationResponse SendFriendRequest(string senderUsername, string receiverUsername)
        {
            try
            {
                var sender = _playerRepository.GetByUsername(senderUsername);
                var receiver = _playerRepository.GetByUsername(receiverUsername);

                _friendRequestRepository.SendFriendRequest(sender.PlayerID, receiver.PlayerID);
                _friendRequestRepository.Save();

                return OperationResponse.SuccessResult();
            }
            catch (Exception ex)
            {
                CustomLogger.Error("", ex);
                return OperationResponse.Failure(ErrorMessages.GeneralException);
            }
        }
    }
}
