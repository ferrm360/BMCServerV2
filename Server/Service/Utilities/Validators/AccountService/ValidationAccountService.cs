using DataAccess.Repositories;
using Service.DTO;
using Service.Results;
using Service.Utilities.Constans;
using Service.Utilities.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace Service.Utilities.Validators.AccountService
{
    public class ValidationAccountService : IValidationAccountService
    {
        private const int MaxUsernameLength = 15;
        private const int MaxEmailLength = 255;

        public string ValidateUsername(string username)
        {
            if (string.IsNullOrWhiteSpace(username))
            {
                return ErrorMessages.InvalidUsername;
            }

            if (username.Length > MaxUsernameLength)
            {
                return ErrorMessages.UsernameLengthInvalid;
            }

            if (!Regex.IsMatch(username, @"^[a-zA-Z0-9_\[\]\-\s]+$"))
            {
                return ErrorMessages.UsernameContainsInvalidChars;
            }

            return null;
        }

        public string ValidateEmail(string email)
        {
            if (string.IsNullOrWhiteSpace(email))
            {
                return ErrorMessages.InvalidEmail;
            }

            if (email.Length > MaxEmailLength)
            {
                return ErrorMessages.InvalidEmail;
            }

            var emailRegex = new Regex(@"^[^@]+@[^@]+\.[^@]+$");
            if (!emailRegex.IsMatch(email))
            {
                return ErrorMessages.InvalidEmailFormat;
            }

            return null;
        }

        public string ValidatePassword(string password)
        {
            if (string.IsNullOrWhiteSpace(password))
            {
                return ErrorMessages.InvalidPassword;
            }

            if (password.Length < 8)
            {
                return ErrorMessages.PasswordTooShort;
            }

            return null;
        }

        public string ValidatePlayerExistsByUsername(IPlayerRepository playerRepository, string username)
        {
            if (playerRepository.GetByUsername(username) != null)
            {
                return ErrorMessages.DuplicateUsername;
            }

            return null;
        }

        public string ValidatePlayerExistsByEmail(IPlayerRepository playerRepository, string email)
        {
            if (playerRepository.GetByEmail(email) != null)
            {
                return ErrorMessages.DuplicateEmail;
            }

            return null;
        }
    }
}
