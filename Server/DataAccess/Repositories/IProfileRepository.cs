using System;

namespace DataAccess.Repositories
{
    public interface IProfileRepository
    {
        Profile GetProfileByPlayerId(int playerId);
        void Add(Profile profile);
        void Update(Profile profile);
        void SetLastVisit(int playerId, DateTime lastVisitDate);
        void SetStatus(int playerId, int statusId);
        void Save();
    }
}