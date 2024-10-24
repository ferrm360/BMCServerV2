using System;
using System.Data.SqlClient;
using DataAccess;
using DataAccess.Repositories;
using Service.Contracts;
using Service.DTO;



using Service.Results;
using Service.Utilities.Helpers;
using Service.Utilities;
using Service.Utilities.Constans;
using Service.Factories;
using Service.Utilities.Validators;
using log4net.Repository.Hierarchy;
using Service.Utilities.Mapper;

namespace Service.Implements
{
    public class AccountService : IAccountService
    {
        private readonly IPlayerRepository _playerRepository;
        private readonly IProfileRepository _profileRepository;
        private readonly IPlayerScoresRepository _scoreRepository;

        public AccountService()
        {
            var context = new BMCEntities();
            _playerRepository = new PlayerRepository(context);
            _profileRepository = new ProfileRepository(context);
            _scoreRepository = new PlayerScoresRepository(context);
        }

        public AccountService(IPlayerRepository playerRepository, IProfileRepository profileRepository, IPlayerScoresRepository scoreRepository)
        {
            _playerRepository = playerRepository;
            _profileRepository = profileRepository;
            _scoreRepository = scoreRepository;
        }

        public OperationResult Register(PlayerDTO player)
        {
            try
            {
                if (_playerRepository.GetByUsername(player.Username) != null)
                {
                    return OperationResult.Failure(ErrorMessages.DuplicateUsername);
                }

                if (_playerRepository.GetByEmail(player.Email) != null)
                {
                    return OperationResult.Failure(ErrorMessages.DuplicateEmail);
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

                return OperationResult.SuccessResult();
            }
            catch (SqlException ex)
            {
                string errorMessage = SqlErrorHandler.GetErrorMessage(ex);
                return OperationResult.Failure(errorMessage);
            }
            catch (Exception ex)
            {
                CustomLogger.Fatal("Unexpected error during registration", ex);
                return OperationResult.Failure(ErrorMessages.GeneralException);
            }
        }

        public OperationResult Login(string username, string password)
        {
            try
            {
                var player = _playerRepository.GetByUsername(username);
                if (player == null)
                {
                    return OperationResult.Failure(ErrorMessages.UserNotFound);
                }

                bool isPasswordValid = PasswordHelper.VerifyPassword(password, player.PasswordHash);
                if (!isPasswordValid)
                {
                    return OperationResult.Failure(ErrorMessages.InvalidPassword);
                }

                var playerDTO = PlayerMapper.ToDTO(player);
                return OperationResult.SuccessResult();
            }
            catch (SqlException ex)
            {
                CustomLogger.Error("SQL error during login", ex);
                string errorMessage = SqlErrorHandler.GetErrorMessage(ex);
                return OperationResult.Failure(errorMessage);
            }
            catch (Exception ex)
            {
                CustomLogger.Error("Unexpected error during login", ex);
                return OperationResult.Failure(ErrorMessages.GeneralException);
            }
        }
    }
}