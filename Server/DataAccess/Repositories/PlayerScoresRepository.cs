using DataAccess.Utilities;
using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Data.SqlClient;
using System.Linq;

namespace DataAccess.Repositories
{
    public class PlayerScoresRepository : IPlayerScoresRepository
    {
        private readonly BMCEntities _context;

        public PlayerScoresRepository(BMCEntities context)
        {
            _context = context;
        }

        public PlayerScores GetScoresByPlayerId(int playerId)
        {
            if (playerId <= 0)
            {
                throw new ArgumentException("Player ID must be greater than zero.", nameof(playerId));
            }

            try
            {
                return _context.UserScores.FirstOrDefault(us => us.PlayerID == playerId);
            }
            catch (SqlException ex)
            {
                throw new DataAccessException("SQL error occurred while retrieving scores by player ID.", ex);
            }
            catch (Exception ex)
            {
                throw new DataAccessException("An unexpected error occurred while retrieving scores by player ID.", ex);
            }
        }

        public IEnumerable<PlayerScores> GetTopScores(int top)
        {
            if (top <= 0)
            {
                throw new ArgumentException("Top value must be greater than zero.", nameof(top));
            }

            try
            {
                return _context.UserScores.OrderByDescending(us => us.Wins).Take(top).ToList();
            }
            catch (SqlException ex)
            {
                throw new DataAccessException("SQL error occurred while retrieving top scores.", ex);
            }
            catch (Exception ex)
            {
                throw new DataAccessException("An unexpected error occurred while retrieving top scores.", ex);
            }
        }

        public void IncrementWins(int playerId)
        {
            var scores = GetScoresByPlayerId(playerId);
            if (scores == null)
            {
                throw new InvalidOperationException($"No scores found for player with ID {playerId}.");
            }

            try
            {
                scores.Wins++;
                Update(scores);
                Save();
            }
            catch (DbUpdateException ex)
            {
                throw new DataAccessException("Error occurred while updating the database during win increment.", ex);
            }
            catch (SqlException ex)
            {
                throw new DataAccessException("SQL error occurred while incrementing wins.", ex);
            }
            catch (Exception ex)
            {
                throw new DataAccessException("An unexpected error occurred while incrementing wins.", ex);
            }
        }

        public void IncrementLosses(int playerId)
        {
            var scores = GetScoresByPlayerId(playerId);
            if (scores == null)
            {
                throw new InvalidOperationException($"No scores found for player with ID {playerId}.");
            }

            try
            {
                scores.Losses++;
                Update(scores);
                Save();
            }
            catch (DbUpdateException ex)
            {
                throw new DataAccessException("Error occurred while updating the database during loss increment.", ex);
            }
            catch (SqlException ex)
            {
                throw new DataAccessException("SQL error occurred while incrementing losses.", ex);
            }
            catch (Exception ex)
            {
                throw new DataAccessException("An unexpected error occurred while incrementing losses.", ex);
            }
        }

        public void AddPlayerScores(PlayerScores playerScores)
        {
            if (playerScores == null)
            {
                throw new ArgumentNullException(nameof(playerScores), "PlayerScores entity cannot be null.");
            }

            try
            {
                _context.UserScores.Add(playerScores);
                Save();
            }
            catch (DbUpdateException ex)
            {
                throw new DataAccessException("Error occurred while adding player scores to the database.", ex);
            }
            catch (SqlException ex)
            {
                throw new DataAccessException("SQL error occurred while adding player scores.", ex);
            }
            catch (Exception ex)
            {
                throw new DataAccessException("An unexpected error occurred while adding player scores.", ex);
            }
        }

        private void Update(PlayerScores scores)
        {
            _context.Entry(scores).State = System.Data.Entity.EntityState.Modified;
        }

        private void Save()
        {
            _context.SaveChanges();
        }
    }
}
