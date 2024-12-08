using System.Collections.Generic;

namespace DataAccess.Repositories
{
    public interface IPlayerScoresRepository
    {
        IEnumerable<UserScores> GetTopScores(int top);
        UserScores GetScoresByPlayerId(int playerId);
        void IncrementWins(int playerId);
        void IncrementLosses(int playerId);
        void Add(UserScores playerScores);
        void Save();
        List<UserScores> GetAllPlayersScores();
    }
}
