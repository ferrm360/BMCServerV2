using System.Collections.Generic;

namespace DataAccess.Repositories
{
    public interface IPlayerScoresRepository
    {
        IEnumerable<PlayerScores> GetTopScores(int top);
        PlayerScores GetScoresByPlayerId(int playerId);
        void IncrementWins(int playerId);
        void IncrementLosses(int playerId);
        void Add(PlayerScores playerScores);
        void Save();
    }
}
