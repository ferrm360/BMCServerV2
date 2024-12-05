using System;
using System.Data.SqlClient;
using DataAccess.Repositories;
using Service.Contracts;
using Service.DTO;
using Service.Results;
using Service.Utilities.Helpers;
using Service.Utilities;
using Service.Utilities.Constans;
using Service.Factories;
using Service.Connection.Managers;
using System.ServiceModel;

namespace Service.Implements
{
    public class AccountService : IAccountService
    {
        private readonly IPlayerRepository _playerRepository;
        private readonly IProfileRepository _profileRepository;
        private readonly IPlayerScoresRepository _scoreRepository;
        private readonly ConnectionManager _connectionManager;
        private readonly ConnectionEventHandler _connectionEventHandler;

        public AccountService(
            IPlayerRepository playerRepository,
            IProfileRepository profileRepository,
            IPlayerScoresRepository scoreRepository,
            ConnectionManager connectionManager,
            ConnectionEventHandler connectionEventHandler)
        {
            _playerRepository = playerRepository;
            _profileRepository = profileRepository;
            _scoreRepository = scoreRepository;
            _connectionManager = connectionManager;
            _connectionEventHandler = connectionEventHandler;
        }

        public OperationResponse Register(PlayerDTO player)
        {
            if (string.IsNullOrWhiteSpace(player.Username))
            {
                return OperationResponse.Failure(ErrorMessages.InvalidUsername);
            }

            if (string.IsNullOrWhiteSpace(player.Email))
            {
                return OperationResponse.Failure(ErrorMessages.InvalidEmail);
            }

            if (string.IsNullOrWhiteSpace(player.Password))
            {
                return OperationResponse.Failure(ErrorMessages.InvalidPassword);
            }
            try
            {
                if (_playerRepository.GetByUsername(player.Username) != null)
                {
                    return OperationResponse.Failure(ErrorMessages.DuplicateUsername);
                }

                if (_playerRepository.GetByEmail(player.Email) != null)
                {
                    return OperationResponse.Failure(ErrorMessages.DuplicateEmail);
                }

                string passwordHash = PasswordHelper.HashPassword(player.Password);

                var playerEntity = EntityFactory.CreatePlayerEntity(player, passwordHash);
                var profileEntity = EntityFactory.CreateProfileEntity(playerEntity.PlayerID);
                var playerScoresEntity = EntityFactory.CreatePlayerScoresEntity(playerEntity.PlayerID);

                _playerRepository.Add(playerEntity);
                _profileRepository.Add(profileEntity);
                _scoreRepository.Add(playerScoresEntity);

                _playerRepository.Save();
                _profileRepository.Save();
                _scoreRepository.Save();

                return OperationResponse.SuccessResult();
            }
            catch (SqlException ex)
            {
                string errorMessage = SqlErrorHandler.GetErrorMessage(ex);
                return OperationResponse.Failure(errorMessage);
            }
            catch (Exception ex)
            {
                CustomLogger.Fatal("Unexpected error during registration", ex);
                return OperationResponse.Failure(ErrorMessages.GeneralException);
            }
        }

        public OperationResponse Login(string username, string password)
        {
            if (string.IsNullOrWhiteSpace(username))
            {
                return OperationResponse.Failure(ErrorMessages.InvalidUsername);
            }

            if (string.IsNullOrWhiteSpace(password))
            {
                return OperationResponse.Failure(ErrorMessages.InvalidPassword);
            }

            if (_connectionManager.IsUserRegistered(username))
            {
                return OperationResponse.Failure(ErrorMessages.UserAlreadyConnected);
            }
            try
            {
                var player = _playerRepository.GetByUsername(username);
                if (player == null)
                {
                    return OperationResponse.Failure(ErrorMessages.UserNotFound);
                }

                bool isPasswordValid = PasswordHelper.VerifyPassword(password, player.PasswordHash);

                if (!isPasswordValid)
                {
                    return OperationResponse.Failure(ErrorMessages.InvalidPassword);
                }

                if (OperationContext.Current?.Channel is IContextChannel channel)
                {
                    bool registered = _connectionManager.RegisterUser(username, channel);
                    if (!registered)
                    {
                        return OperationResponse.Failure(ErrorMessages.UserAlreadyConnected);
                    }

                    _connectionEventHandler.RegisterChannelEvents(username, channel);
                }

                return OperationResponse.SuccessResult();
            }
            catch (SqlException ex)
            {
                CustomLogger.Error("SQL error during login", ex);
                string errorMessage = SqlErrorHandler.GetErrorMessage(ex);
                return OperationResponse.Failure(errorMessage);
            }
            catch (Exception ex)
            {
                CustomLogger.Error("Unexpected error during login", ex);
                return OperationResponse.Failure(ErrorMessages.GeneralException);
            }
        }

        public OperationResponse Logout(string username)
        {
            if (_connectionManager.IsUserRegistered(username))
            {
                _connectionEventHandler.HandleDisconnection(username);
                _connectionManager.UnregisterUser(username);
                return OperationResponse.SuccessResult();
            }
            else
            {
                return OperationResponse.Failure(ErrorMessages.UserNotConnected);
            }
        }
    }
}