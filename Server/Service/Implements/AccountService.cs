using System;
using System.Data.SqlClient;
using DataAccess;
using DataAccess.Repositories;
using Service.Contracts;
using Service.DTO;
using Service.Results;
using Service.Utilities.Helpers;
using Service.Utilities.Mapper;

namespace Service.Implements
{
    public class AccountService : IAccountService
    {
        private readonly IPlayerRepository _playerRepository;

        public AccountService()
        {
            var context = new BMCEntities();
            _playerRepository = new PlayerRepository(context);
        }

        public AccountService(IPlayerRepository playerRepository)
        {
            _playerRepository = playerRepository;
        }

        public OperationResult<object> Register(PlayerDTO player)
        {
            try
            {
                if (_playerRepository.GetByUsername(player.Username) != null)
                {
                    return OperationResult<object>.Failure("Error.DuplicateUsername");
                }

                if (_playerRepository.GetByEmail(player.Email) != null)
                {
                    return OperationResult<object>.Failure("Error.DuplicateEmail");
                }


                string passwordHash = PasswordHelper.HashPassword(player.Password);
                var playerEntity = PlayerMapper.ToEntity(player, passwordHash);
                _playerRepository.Add(playerEntity);

                return OperationResult<object>.SuccessResult();
            }
            catch (SqlException ex)
            {
                string errorMessage = SqlErrorHandler.GetErrorMessage(ex);
                return OperationResult<object>.Failure(errorMessage);
            }
            catch (Exception ex)
            {
                throw new InvalidOperationException("An unexpected error occurred.", ex);
            }
        }

        public OperationResult<PlayerDTO> Login(string username, string password)
        {
            try
            {
                var player = _playerRepository.GetByUsername(username);
                if (player == null)
                {
                    return OperationResult<PlayerDTO>.Failure("Error.UserNotFound");
                }

                bool isPasswordValid = PasswordHelper.VerifyPassword(password, player.PasswordHash);
                if (!isPasswordValid)
                {
                    return OperationResult<PlayerDTO>.Failure("Error.InvalidPassword");
                }

                var playerDTO = PlayerMapper.ToDTO(player);
                return OperationResult<PlayerDTO>.SuccessResult(playerDTO);
            }
            catch (SqlException ex)
            {
                string errorMessage = SqlErrorHandler.GetErrorMessage(ex);
                return OperationResult<PlayerDTO>.Failure(errorMessage);
            }
            catch (Exception ex)
            {
                throw new InvalidOperationException("An unexpected error occurred.", ex);
            }
        }

        
    }
}
