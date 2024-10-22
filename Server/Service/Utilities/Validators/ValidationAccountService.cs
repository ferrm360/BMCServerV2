using DataAccess.Repositories;
using Service.DTO;
using Service.Results;
using Service.Utilities.Constans;
using Service.Utilities.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service.Utilities.Validators
{
    public class ValidationAccountService
    {
        private readonly IPlayerRepository _playerRepository;

        public ValidationAccountService(IPlayerRepository playerRepository)
        {
            _playerRepository = playerRepository;
        }

        public OperationResult ValidatePlayerRegistration(PlayerDTO player)
        {
            if (_playerRepository.GetByUsername(player.Username) != null)
            {
                return OperationResult.Failure(ErrorMessages.DuplicateUsername);
            }

            if (_playerRepository.GetByEmail(player.Email) != null)
            {
                return OperationResult.Failure(ErrorMessages.DuplicateEmail);
            }

            return OperationResult.SuccessResult();
        }

        public OperationResult ValidatePlayerLogin(string username, string password)
        {
            var player = _playerRepository.GetByUsername(username);

            if (player == null)
            {
                return OperationResult.Failure(ErrorMessages.UserNotFound);
            }

            if (!PasswordHelper.VerifyPassword(password, player.PasswordHash))
            {
                return OperationResult.Failure(ErrorMessages.InvalidPassword);
            }

            return OperationResult.SuccessResult(player);
        }
    }
}
