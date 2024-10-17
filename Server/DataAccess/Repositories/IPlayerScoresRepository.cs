using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Repositories
{
    public interface IPlayerScoresRepository
    {
        IEnumerable<PlayerScores> GetTopScores(int top);
        PlayerScores GetScoresByPlayerId(int playerId);
        void IncrementWins(int playerId);
        void IncrementLosses(int playerId);
        void AddPlayerScores(PlayerScores playerScores);

    }
}
