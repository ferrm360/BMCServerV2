using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Repositories
{
    public interface IPlayerRepository
    {
        Player GetByUsername(string username);
        Player GetByEmail(string email);
        void Add(Player player);
        void UpdatePasswordHash(string username,  string passwordHash);
    }
}
