using DataAccess.Utilities;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Data.Entity.Validation;
using System.Data.SqlClient;
using System.Linq;

namespace DataAccess.Repositories
{
    public class PlayerRepository : IPlayerRepository
    {
        private readonly BMCEntities _context;

        public PlayerRepository(BMCEntities context)
        {
            _context = context;
        }

        public Player GetByUsername(string username)
        {
            if (string.IsNullOrEmpty(username))
            {
                throw new ArgumentNullException(nameof(username), "Username cannot be null or empty.");
            }

            try
            {
                return _context.Player.SingleOrDefault(p => p.Username == username);
            }
            catch (SqlException)
            {
                throw;
            }
            catch (InvalidOperationException ex)
            {
                throw new DataAccessException("An invalid operation occurred while retrieving the player by username.", ex);
            }
        }

        public Player GetByEmail(string email)
        {
            if (string.IsNullOrEmpty(email))
            {
                throw new ArgumentNullException(nameof(email), "Email cannot be null or empty.");
            }

            try
            {
                return _context.Player.SingleOrDefault(p => p.Email == email);
            }
            catch (SqlException)
            {
                throw;
            }
            catch (InvalidOperationException ex)
            {
                throw new DataAccessException("An invalid operation occurred while retrieving the player by email.", ex);
            }
        }

        public string GetUsernameById(int playerId)
        {
            if (playerId <= 0)
            {
                throw new ArgumentException("Player ID must be greater than zero.", nameof(playerId));
            }

            try
            {
                var username = _context.Player
                .Where(player => player.PlayerID == playerId)
                .Select(player => player.Username)
                .FirstOrDefault();
                return username;

            } catch (SqlException ex)
            {
                throw new ArgumentException("An error ocurred while trying to retrieve the player usernaem", ex);
            }
        }

        public void Add(Player player)
        {
            if (player == null)
            {
                throw new ArgumentNullException(nameof(player), "Player entity cannot be null.");
            }

            try
            {
                _context.Player.Add(player);
            }
            catch (DbUpdateException ex)
            {
                throw new DataAccessException("An error occurred while updating the database during the player addition.", ex);
            }
            catch (DbEntityValidationException ex)
            {
                throw new DataAccessException("Entity validation failed while adding the player.", ex);
            }
            catch (SqlException)
            {
                throw;
            }
            catch (InvalidOperationException ex)
            {
                throw new DataAccessException("An invalid operation occurred while adding the player.", ex);
            }
        }

        public void UpdatePasswordHash(string username, string passwordHash)
        {
            
         var player = GetByUsername(username);
         if (player != null)
         {
            player.PasswordHash = passwordHash;
            _context.Entry(player).State = EntityState.Modified;
            _context.SaveChanges();
         }
            
        }

        public void Save()
        {
            _context.SaveChanges();
        }

        public void Update(Player player)
        {
            if (player == null)
            {
                throw new ArgumentNullException(nameof(player), "Player entity cannot be null.");
            }

            try
            {
                _context.Entry(player).State = EntityState.Modified;

                _context.SaveChanges();
            }
            catch (DbUpdateException ex)
            {
                throw new DataAccessException("An error occurred while updating the database during the player update.", ex);
            }
            catch (DbEntityValidationException ex)
            {
                throw new DataAccessException("Entity validation failed while updating the player.", ex);
            }
            catch (SqlException)
            {
                throw;
            }
            catch (InvalidOperationException ex)
            {
                throw new DataAccessException("An invalid operation occurred while updating the player.", ex);
            }
        }

        public IEnumerable<Player> GetPlayersByUsername(string username, int playerId)
        {
            if (playerId <= 0)
            {
                throw new ArgumentException("Player ID must be greater than zero.", nameof(playerId));
            }

            try
            {
                var players = _context.Player
                .Where(p => p.Username.Contains(username) && p.PlayerID != playerId)
                .ToList();

                return players;
            }
            catch (SqlException)
            {
                throw;
            }
            catch (InvalidOperationException ex)
            {
                throw new DataAccessException("Invalid operation while retrieving accepted friends.", ex);
            }
            catch (Exception ex)
            {
                throw new DataAccessException("An unexpected error occurred while retrieving accepted friends.", ex);
            }
        }

        public IEnumerable<Player> GetPlayers(string username)
        {
            if (string.IsNullOrEmpty(username))
            {
                throw new ArgumentException("User string cannot be null", username);
            }

            try
            {
                var players = _context.Player
                .Where(p => p.Username != username)  
                .ToList();
                return players;
            } catch (SqlException)
            {
                throw;
            }
            catch (InvalidOperationException ex)
            {
                throw new DataAccessException("Invalid operation while retrieving accepted friends.", ex);
            }
            catch (Exception ex)
            {
                throw new DataAccessException("An unexpected error occurred while retrieving accepted friends.", ex);
            }
        }

    }
}
