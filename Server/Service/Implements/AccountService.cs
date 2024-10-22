using System;
using System.Data.SqlClient;
using DataAccess;
using DataAccess.Repositories;
using Service.Contracts;
using Service.DTO;
using Service.Results;
using Service.Utilities.Helpers;
using Service.Utilities.Mapper;
using Service.Utilities;
using System.Web.UI.WebControls;
using Service.Utilities.Constans;

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
        }

        public AccountService(IPlayerRepository playerRepository)
        {
            _playerRepository = playerRepository;
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
                var playerEntity = PlayerMapper.ToEntity(player, passwordHash);
                _playerRepository.Add(playerEntity);

                return OperationResult.SuccessResult();
            }
            catch (SqlException ex)
            {
                string errorMessage = SqlErrorHandler.GetErrorMessage(ex);
                return OperationResult.Failure(errorMessage);
            }
            catch (Exception ex)
            {
                Logger.Fatal("Unexpected error during login", ex);
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
