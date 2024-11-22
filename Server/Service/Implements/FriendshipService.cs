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
using System.IO;

namespace Service.Implements
{
    //TODO Corregir logger
    public class FriendshipService : IFriendshipService
    {
        private readonly IPlayerRepository _playerRepository;
        private readonly IFriendRequestRepository _friendRequestRepository;
        private readonly ValidationFriendshipService _validationService;
        private readonly IProfileRepository _profileRepository;

        public FriendshipService(IPlayerRepository playerRepository, IFriendRequestRepository friendRequestRepository, ValidationFriendshipService validationService, IProfileRepository profileRepository)
        {
            _playerRepository = playerRepository;
            _friendRequestRepository = friendRequestRepository;
            _validationService = validationService;
            _profileRepository = profileRepository;
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
                CustomLogger.Error("AcceptFriend", ex);
                return OperationResponse.Failure(ErrorMessages.GeneralException);
            }
        }

        public FriendListResponse GetFriendList(string username)
        {
            try
            {
                var player = _playerRepository.GetByUsername(username);
                if (player == null)
                {
                    return FriendListResponse.Failure("UserNotFound");
                }

                var friends = _friendRequestRepository.GetAcceptedFriends(player.PlayerID);

                if (friends == null || !friends.Any())
                {
                    return FriendListResponse.SuccessResult(new List<PlayerDTO>());
                }

                var friendDTOs = friends.Select(friend => new PlayerDTO
                {
                    PlayerID = friend.PlayerID,
                    Username = friend.Username,
                    Email = friend.Email
                }).ToList();

                return FriendListResponse.SuccessResult(friendDTOs);
            }
            catch (Exception ex)
            {
                CustomLogger.Error($"[GetFriendList] Error while retrieving friend list for user '{username}': {ex.Message}", ex);
                return FriendListResponse.Failure(ErrorMessages.GeneralException);
            }
        }



        public FriendRequestListReponse GetFriendRequestList(string username)
        {
            try
            {
                var player = _playerRepository.GetByUsername(username);
                if (player == null)
                {
                    return FriendRequestListReponse.Failure("User not found.");
                }

                var requests = _friendRequestRepository.GetReceivedRequests(player.PlayerID);

                var requestDTOs = requests.Select(request => new FriendRequestDTO
                {
                    RequestID = request.RequestID,
                    SenderUsername = request.Player.Username,
                    ReceiverUsername = request.Player1.Username,
                    Status = request.RequestStatus.ToString()
                }).ToList();

                return FriendRequestListReponse.SuccessResult(requestDTOs);
            }
            catch (Exception ex)
            {
                CustomLogger.Error("", ex);
                return FriendRequestListReponse.Failure(ErrorMessages.GeneralException);
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
            var senderValidation = _validationService.ValidateUserExists(senderUsername);
            if (!senderValidation.IsSuccess) {
                return senderValidation;
            }

            var receiverValidation = _validationService.ValidateUserExists(receiverUsername);
            if (!receiverValidation.IsSuccess) {
                return receiverValidation; 
            }

            var sender = _playerRepository.GetByUsername(senderUsername);
            var receiver = _playerRepository.GetByUsername(receiverUsername);
            var requestValidation = _validationService.ValidateFriendRequestDoesNotExist(sender.PlayerID, receiver.PlayerID);
            if (!requestValidation.IsSuccess) 
            { 
                return requestValidation; 
            }
            try
            {
                _friendRequestRepository.SendFriendRequest(sender.PlayerID, receiver.PlayerID);
                _friendRequestRepository.Save();
                return OperationResponse.SuccessResult();
            }
            catch (Exception ex)
            {
                CustomLogger.Error("Failed to send friend request.", ex);
                return OperationResponse.Failure(ErrorMessages.GeneralException);
            }
        }

        public PlayerProfileResponse GetPlayersListByUsername(string playerUsername, string ownerUsername)
        {
            try
            {
                var player = _playerRepository.GetByUsername(ownerUsername);
                if (player == null)
                {
                    return PlayerProfileResponse.Failure("OwnerNotFound");
                }

                var players = _playerRepository.GetPlayersByUsername(playerUsername, player.PlayerID);

                if (players == null || !players.Any())
                {
                    return PlayerProfileResponse.SuccessResult(new List<PlayerProfileDTO>(), new List<PlayerDTO>());
                }

                var playerDtos = new List<PlayerDTO>();
                var profileDtos = new List<PlayerProfileDTO>();

                foreach (var friend in players)
                {
                    var playerDto = new PlayerDTO
                    {
                        PlayerID = friend.PlayerID,
                        Username = friend.Username,
                        Email = friend.Email
                    };
                    playerDtos.Add(playerDto);

                    var profile = _profileRepository.GetProfileByPlayerId(friend.PlayerID);
                    if (profile != null)
                    {
                        byte[] imageBytes = ConvertImageUrlToBytes(profile.AvatarURL) ?? Array.Empty<byte>();

                        var profileDto = new PlayerProfileDTO
                        {
                            FullName = profile.FullName ?? "Anonymous",
                            Bio = profile.Bio ?? "No bio available",
                            JoinDate = profile.JoinDate ?? DateTime.MinValue,
                            SingUpDate = profile.SignUpDate ?? DateTime.MinValue,
                            LastVisit = profile.LastVisit ?? DateTime.MinValue,
                            ProfileImage = imageBytes
                        };

                        profileDtos.Add(profileDto);
                    }
                }
                return PlayerProfileResponse.SuccessResult(profileDtos, playerDtos);
            }
            catch (Exception ex)
            {
                CustomLogger.Error($"[GetPlayersListByUsername] Error while retrieving players for user '{ownerUsername}': {ex.Message}", ex);
                return PlayerProfileResponse.Failure(ErrorMessages.GeneralException);
            }
        }


        public FriendListResponse GetPlayersList(string username)
        {
            try
            {
                var player = _playerRepository.GetByUsername(username);
                if (player == null)
                {
                    return FriendListResponse.Failure("UserNotFound");
                }

                var players = _playerRepository.GetPlayers(username);

                if (players == null || !players.Any())
                {
                    return FriendListResponse.SuccessResult(new List<PlayerDTO>());
                }

                var playerDtos = players.Select(friend => new PlayerDTO
                {
                    PlayerID = friend.PlayerID,
                    Username = friend.Username,
                    Email = friend.Email
                }).ToList();

                return FriendListResponse.SuccessResult(playerDtos);
            }
            catch (Exception ex)
            {
                CustomLogger.Error($"[GetFriendList] Error while retrieving friend list for user '{username}': {ex.Message}", ex);
                return FriendListResponse.Failure(ErrorMessages.GeneralException);
            }
        }

        public byte[] ConvertImageUrlToBytes(string imageUrl)
        {
            try
            {
                string filePath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, imageUrl);
                if (File.Exists(filePath))
                {
                    return File.ReadAllBytes(filePath);
                }
                else
                {
                    throw new FileNotFoundException("Image file not found.");
                }
            }
            catch (Exception ex)
            {
                CustomLogger.Error("Error converting image to bytes", ex);
                throw new Exception("Error converting image.");
            }
        }
    }
}
