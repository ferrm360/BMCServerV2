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

namespace Service.Implements
{
    public class AccountService : IAccountService
    {
        private readonly IPlayerRepository _playerRepository;
        private readonly IProfileRepository _profileRepository;
        private readonly IPlayerScoresRepository _scoreRepository;
        private readonly IEntityFactory _entityFactory;
        private readonly ValidationAccountService _validationService;

        public AccountService(IPlayerRepository playerRepository,
                              IProfileRepository profileRepository,
                              IPlayerScoresRepository scoreRepository,
        IEntityFactory entityFactory,
                              ValidationAccountService validationService)
        {
            _playerRepository = playerRepository;
            _profileRepository = profileRepository;
            _scoreRepository = scoreRepository;
            _entityFactory = entityFactory;
            _validationService = validationService;
        }

        public OperationResult Register(PlayerDTO player)
        {
            try
            {
                var validationResult = _validationService.ValidatePlayerRegistration(player);
                if (!validationResult.IsSuccess)
                {
                    return validationResult;
                }

                string passwordHash = PasswordHelper.HashPassword(player.Password);

                var playerEntity = _entityFactory.CreatePlayerEntity(player, passwordHash);

                var profileEntity = _entityFactory.CreateProfileEntity(playerEntity.PlayerID);
                var playerScoresEntity = _entityFactory.CreatePlayerScoresEntity(playerEntity.PlayerID);

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
                Logger.Error("", ex);
                return OperationResult.Failure(ErrorMessages.GeneralException);
            }
        }

        public OperationResult Login(string username, string password)
        {
            try
            {
                var validationResult = _validationService.ValidatePlayerLogin(username, password);
                if (!validationResult.IsSuccess)
                {
                    return validationResult;
                }

                var player = validationResult.Data as Player;
                var playerDTO = new PlayerDTO
                {
                    PlayerID = player.PlayerID,
                    Username = player.Username,
                    Email = player.Email
                };

                return OperationResult.SuccessResult(playerDTO);
            }
            catch (SqlException ex)
            {
                Logger.Error("SQL error during login", ex);
                string errorMessage = SqlErrorHandler.GetErrorMessage(ex);
                return OperationResult.Failure(errorMessage);
            }
            catch (Exception ex)
            {
                Logger.Error("Unexpected error during login", ex);
                return OperationResult.Failure(ErrorMessages.GeneralException);
            }
        }
    }
}
