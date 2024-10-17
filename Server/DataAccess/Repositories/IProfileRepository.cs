using System;


namespace DataAccess.Repositories
{
    public interface IProfileRepository
    {
        Profile GetProfileByPlayerId(int playerId);
        void CreateProfile(Profile profile);
        void UpdateProfile(Profile profile);
        void SetLastVisit(int playerId, DateTime lastVisitDate);
        void SetStatus(int playerId, int statusId);
        string GetLanguagePreference(int profileId);
        void UpdateLanguagePreference(int profileId, string language);
    }
}