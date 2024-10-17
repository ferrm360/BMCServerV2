using DataAccess.Utilities;
using System;
using System.Data.Entity.Infrastructure;
using System.Data.Entity.Validation;
using System.Data.SqlClient;
using System.Linq;

namespace DataAccess.Repositories
{
    // TODO recordar que cuando se crea un player en player profile se pone la fecha en la que se unio.
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

        public void Add(Player player)
        {
            if (player == null)
            {
                throw new ArgumentNullException(nameof(player), "Player entity cannot be null.");
            }

            try
            {
                _context.Player.Add(player);
                _context.SaveChanges();
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
    }
}
