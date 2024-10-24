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

namespace Service.Implements
{
    //TODO Corregir logger
    public class FriendshipService : IFriendshipService
    {
        private readonly IPlayerRepository _playerRepository;
        private readonly IFriendRequestRepository _friendRequestRepository;
        private readonly ValidationFriendshipService _validationService;

        public FriendshipService()
        {
            // Crear instancia del contexto de Entity Framework
            var context = new BMCEntities();

            // Inicializar los repositorios directamente
            _playerRepository = new PlayerRepository(context);
            _friendRequestRepository = new FriendRequestRepository(context);
        }

        public OperationResult AcceptFriendRequest(int idRequest)
        {
            try
            {
                _friendRequestRepository.AcceptRequest(idRequest);
                _friendRequestRepository.Save();

                return OperationResult.SuccessResult();
            }
            catch (Exception ex)
            {
                CustomLogger.Error("", ex);
                return OperationResult.Failure(ErrorMessages.GeneralException);
            }
        }

        public List<PlayerDTO> GetFriendList(string username)
        {
            try
            {
                var player = _playerRepository.GetByUsername(username);
                if (player == null)
                {
                    throw new ArgumentException();
                }

                var friends = _friendRequestRepository.GetAcceptedFriends(player.PlayerID);

                var friendDTOs = friends.Select(friend => new PlayerDTO
                {
                    PlayerID = friend.PlayerID,
                    Username = friend.Username,
                    Email = friend.Email
                }).ToList();

                return friendDTOs;
            }
            catch (Exception ex)
            {
                CustomLogger.Error("Error in GetFriendList", ex);
                throw new ArgumentException();
            }
        }

        public OperationResult GetFriendRequestList(string username)
        {
            try
            {
                var player = _playerRepository.GetByUsername(username);
                if (player == null)
                {
                    return OperationResult.Failure("User not found.");
                }

                var requests = _friendRequestRepository.GetReceivedRequests(player.PlayerID);

                var requestDTOs = requests.Select(request => new FriendRequestDTO
                {
                    RequestID = request.RequestID,
                    SenderUsername = request.Player.Username,
                    ReceiverUsername = request.Player1.Username,
                    Status = request.RequestStatus.ToString()
                }).ToList();

                return OperationResult.SuccessResult(requestDTOs);
            }
            catch (Exception ex)
            {
                CustomLogger.Error("", ex);
                return OperationResult.Failure(ErrorMessages.GeneralException);
            }
        }

        public OperationResult RejectFriendResponse(int idResponse)
        {
            try
            {
                _friendRequestRepository.RejectRequest(idResponse);
                _friendRequestRepository.Save();

                return OperationResult.SuccessResult();
            }
            catch (Exception ex)
            {
                CustomLogger.Error("", ex);
                return OperationResult.Failure(ErrorMessages.GeneralException);
            }
        }

        public OperationResult SendFriendRequest(string senderUsername, string receiverUsername)
        {
            try
            {
                var sender = _playerRepository.GetByUsername(senderUsername);
                var receiver = _playerRepository.GetByUsername(receiverUsername);

                _friendRequestRepository.SendFriendRequest(sender.PlayerID, receiver.PlayerID);
                _friendRequestRepository.Save();

                return OperationResult.SuccessResult();
            }
            catch (Exception ex)
            {
                CustomLogger.Error("", ex);
                return OperationResult.Failure(ErrorMessages.GeneralException);
            }
        }
    }
}
