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

        public OperationResponse ValidatePlayerRegistration(PlayerDTO player)
        {
            if (_playerRepository.GetByUsername(player.Username) != null)
            {
                return OperationResponse.Failure(ErrorMessages.DuplicateUsername);
            }

            if (_playerRepository.GetByEmail(player.Email) != null)
            {
                return OperationResponse.Failure(ErrorMessages.DuplicateEmail);
            }

            return OperationResponse.SuccessResult();
        }

        public OperationResponse ValidatePlayerLogin(string username, string password)
        {
            var player = _playerRepository.GetByUsername(username);

            if (player == null)
            {
                return OperationResponse.Failure(ErrorMessages.UserNotFound);
            }

            if (!PasswordHelper.VerifyPassword(password, player.PasswordHash))
            {
                return OperationResponse.Failure(ErrorMessages.InvalidPassword);
            }

            return OperationResponse.SuccessResult(player);
        }
    }
}
