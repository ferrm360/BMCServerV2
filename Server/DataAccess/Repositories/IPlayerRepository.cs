﻿namespace DataAccess.Repositories
{
    public interface IPlayerRepository
    {
        Player GetByUsername(string username);
        Player GetByEmail(string email);
        void Add(Player player);
        void Update(Player player);
        void UpdatePasswordHash(string username,  string passwordHash);
        void Save();
    }
}
