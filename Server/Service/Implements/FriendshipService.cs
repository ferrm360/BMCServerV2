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

        public PlayerProfileResponse GetPlayersListByUsername(string playerUsername, string ownerUsername)
        {
            try
            {
                CustomLogger.Info($"[GetPlayersListByUsername] Starting GetPlayersListByUsername for user: {ownerUsername}");

                // Obtener información del usuario que consulta (propietario)
                var player = _playerRepository.GetByUsername(ownerUsername);
                if (player == null)
                {
                    CustomLogger.Warn($"[GetPlayersListByUsername] Player with username '{ownerUsername}' not found.");
                    return PlayerProfileResponse.Failure("OwnerNotFound");
                }

                // Buscar jugadores cuyo username coincida (usando LIKE, por ejemplo)
                var players = _playerRepository.GetPlayersByUsername(playerUsername, player.PlayerID);

                if (players == null || !players.Any())
                {
                    CustomLogger.Info($"[GetPlayersListByUsername] No players found for user '{ownerUsername}' (PlayerID: {player.PlayerID}).");
                    return PlayerProfileResponse.SuccessResult(new List<PlayerProfileDTO>(), new List<PlayerDTO>());
                }

                // Crear las listas para devolver tanto jugadores como perfiles
                var playerDtos = new List<PlayerDTO>();
                var profileDtos = new List<PlayerProfileDTO>();

                foreach (var friend in players)
                {
                    // Asignar los datos del jugador encontrado
                    var playerDto = new PlayerDTO
                    {
                        PlayerID = friend.PlayerID,
                        Username = friend.Username,
                        Email = friend.Email
                    };
                    playerDtos.Add(playerDto);

                    // Obtener el perfil correspondiente y asignarlo a PlayerProfileDTO
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

                CustomLogger.Info($"[GetPlayersListByUsername] Found {playerDtos.Count} players for user '{ownerUsername}'.");

                // Devuelve ambas listas: los jugadores y sus perfiles
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
                CustomLogger.Info($"[GetFriendList] Starting GetFriendList for user: {username}");

                var player = _playerRepository.GetByUsername(username);
                if (player == null)
                {
                    CustomLogger.Warn($"[GetFriendList] Player with username '{username}' not found.");
                    return FriendListResponse.Failure("UserNotFound");
                }

                CustomLogger.Info($"[GetFriendList] Fetching players by username: {player.PlayerID}");
                var players = _playerRepository.GetPlayers(username);

                if (players == null || !players.Any())
                {
                    CustomLogger.Info($"[GetFriendList] No player found for user '{username}' (PlayerID: {player.PlayerID}).");
                    return FriendListResponse.SuccessResult(new List<PlayerDTO>());
                }

                var playerDtos = players.Select(friend => new PlayerDTO
                {
                    PlayerID = friend.PlayerID,
                    Username = friend.Username,
                    Email = friend.Email
                }).ToList();

                CustomLogger.Info($"[GetFriendList] Found {playerDtos.Count} players for user '{username}'.");

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
