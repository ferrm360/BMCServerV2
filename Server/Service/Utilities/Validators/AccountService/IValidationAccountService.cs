using DataAccess.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service.Utilities.Validators.AccountService
{
    public interface IValidationAccountService
    {
        string ValidateUsername(string username);
        string ValidateEmail(string email);
        string ValidatePassword(string password);
        string ValidatePlayerExistsByUsername(IPlayerRepository playerRepository, string username);
        string ValidatePlayerExistsByEmail(IPlayerRepository playerRepository, string email);
    }
}
