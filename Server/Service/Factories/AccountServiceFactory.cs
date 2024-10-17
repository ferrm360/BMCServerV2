using DataAccess.Repositories;
using DataAccess;
using Service.Implements;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service.Factories
{
    public static class AccountServiceFactory
    {
        public static AccountService CreateAccountService()
        {
            var context = new BMCEntities();
            var playerRepository = new PlayerRepository(context);

            return new AccountService(playerRepository);
        }
    }
}
