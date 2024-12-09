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
using Service.Utilities.Validators.FriendshipService;
using System.Data.Entity.Infrastructure;

namespace Service.Implements
{
    /// <summary>
    /// Service for managing friendship-related operations such as sending friend requests,
    /// retrieving friend lists, and managing friend requests.
    /// </summary>
    public class FriendshipService : IFriendshipService
    {
        private readonly IPlayerRepository _playerRepository;
        private readonly IFriendRequestRepository _friendRequestRepository;
        private readonly IValidationFriendshipService _validationService;
        private readonly IProfileRepository _profileRepository;

        /// <summary>
        /// Initializes a new instance of the <see cref="FriendshipService"/> class.
        /// </summary>
        public FriendshipService(IPlayerRepository playerRepository, IFriendRequestRepository friendRequestRepository, IValidationFriendshipService validationService, IProfileRepository profileRepository)
        {
            _playerRepository = playerRepository;
            _friendRequestRepository = friendRequestRepository;
            _validationService = validationService;
            _profileRepository = profileRepository;
        }

        /// Accepts a friend request by its identifier.
        /// </summary>
        /// <param name="idRequest">The ID of the friend request to accept.</param>
        /// <returns>An <see cref="OperationResponse"/> indicating the result of the operation.</returns>
        public OperationResponse AcceptFriendRequest(int idRequest)
        {
            try
            {
                _friendRequestRepository.AcceptRequest(idRequest);
                _friendRequestRepository.Save();

                return OperationResponse.SuccessResult();
            }
            catch (InvalidOperationException ex)
            {
                CustomLogger.Error("Invalid operation in AcceptFriendRequest", ex);
                return OperationResponse.Failure(ErrorMessages.RequestNotFound);
            }
            catch (DbUpdateException ex)
            {
                CustomLogger.Error("Database update failed in AcceptFriendRequest", ex);
                return OperationResponse.Failure(ErrorMessages.DatabaseError);
            }
            catch (Exception ex)
            {
                CustomLogger.Error("Unexpected error in AcceptFriendRequest", ex);
                return OperationResponse.Failure(ErrorMessages.GeneralException);
            }
        }

        /// <summary>
        /// Retrieves a list of friends for a given username.
        /// </summary>
        /// <param name="username">The username whose friends are to be retrieved.</param>
        /// <returns>A <see cref="FriendListResponse"/> containing the friend list or an error message.</returns>
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

        /// <summary>
        /// Retrieves the list of received friend requests for a given username.
        /// </summary>
        /// <param name="username">The username for which to retrieve friend requests.</param>
        /// <returns>A <see cref="FriendRequestListReponse"/> with the friend requests or an error message.</returns>
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

        /// <summary>
        /// Rejects a friend request by its identifier.
        /// </summary>
        /// <param name="idResponse">The ID of the friend request to reject.</param>
        /// <returns>An <see cref="OperationResponse"/> indicating the result of the operation.</returns>
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

        /// <summary>
        /// Sends a friend request from one user to another.
        /// </summary>
        /// <param name="senderUsername">The username of the sender.</param>
        /// <param name="receiverUsername">The username of the receiver.</param>
        /// <returns>An <see cref="OperationResponse"/> indicating the result of the operation.</returns>
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
            if (sender == null || receiver == null)
            {
                return OperationResponse.Failure(ErrorMessages.InvalidUsername);
            }
            

            var requestValidation = _validationService.ValidateFriendRequestDoesNotExist(sender.PlayerID, receiver.PlayerID);
            if (!requestValidation.IsSuccess) 
            { 
                return requestValidation; 
            }

            try
            {
                if (!_friendRequestRepository.AreFriends(sender.PlayerID, receiver.PlayerID))

                {
                    _friendRequestRepository.SendFriendRequest(sender.PlayerID, receiver.PlayerID);
                    _friendRequestRepository.Save();
                    return OperationResponse.SuccessResult();
                }
                else
                {
                    return OperationResponse.Failure(ErrorMessages.FriendsAlready);
                }

            }
            catch (Exception ex)
            {
                CustomLogger.Error("Failed to send friend request.", ex);
                return OperationResponse.Failure(ErrorMessages.GeneralException);
            }




        }
            
                
            
       

        /// <summary>
        /// Retrieves a list of players by their username and the username of the requester.
        /// </summary>
        /// <param name="playerUsername">The username of the player to search for.</param>
        /// <param name="loggedUsername">The username of the requester.</param>
        /// <returns>A PlayerProfileResponse containing the players and their profiles.</returns>
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

                        var profileDto = new PlayerProfileDTO
                        {
                            FullName = profile.FullName ?? "Anonymous",
                            Bio = profile.Bio ?? "No bio available",
                            JoinDate = profile.JoinDate ?? DateTime.MinValue,
                            SingUpDate = profile.SignUpDate ?? DateTime.MinValue,
                            LastVisit = profile.LastVisit ?? DateTime.MinValue,
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

        /// <summary>
        /// Retrieves a list of all players except the specified user.
        /// </summary>
        /// <param name="username">The username of the user to exclude.</param>
        /// <returns>A FriendListResponse containing the list of players.</returns>
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

        /// <summary>
        /// Converts an image URL to a byte array.
        /// </summary>
        /// <param name="imageUrl">The URL of the image to convert.</param>
        /// <returns>A byte array containing the image data.</returns>
        /// <exception cref="FileNotFoundException">Thrown when the specified file is not found.</exception>
        /// <exception cref="UnauthorizedAccessException">Thrown when access to the file is denied.</exception>
        /// <exception cref="IOException">Thrown when an I/O error occurs while reading the file.</exception>
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
            catch (FileNotFoundException ex)
            {
                CustomLogger.Warn($"File not found in ConvertImageUrlToBytes: {ex.Message}");
                throw;
            }
            catch (UnauthorizedAccessException ex)
            {
                CustomLogger.Error($"Access denied in ConvertImageUrlToBytes: {ex.Message}");
                throw new Exception("Unauthorized access while reading the image.");
            }
            catch (IOException ex)
            {
                CustomLogger.Error($"I/O error in ConvertImageUrlToBytes: {ex.Message}");
                throw new Exception("I/O error while reading the image.");
            }
            catch (Exception ex)
            {
                CustomLogger.Fatal("Unexpected error in ConvertImageUrlToBytes", ex);
                throw;
            }
        }

        public OperationResponse DeleteFriend(string currentUsername, string friendUsername)
        {

            try
            {
                var player = _playerRepository.GetByUsername(currentUsername);
                var friend = _playerRepository.GetByUsername(friendUsername);
                if (player == null || friend == null)
                {
                    return OperationResponse.Failure("UserNotFound");
                }
                _friendRequestRepository.DeleteFriend(player.PlayerID, friend.PlayerID);
                _friendRequestRepository.Save();

                return OperationResponse.SuccessResult();
            }
            catch (Exception ex)
            {
                CustomLogger.Error("DeleteFriend", ex);
                return OperationResponse.Failure(ErrorMessages.GeneralException);
            }
        }
    }
}
