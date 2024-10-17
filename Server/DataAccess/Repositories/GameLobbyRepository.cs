using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.SqlClient;
using DataAccess.Utilities;

namespace DataAccess.Repositories
{
    public class GameLobbyRepository : IGameLobbyRepository
    {
        private readonly BMCEntities _context;

        public GameLobbyRepository(BMCEntities context)
        {
            _context = context;
        }

        public void CreateLobby(GameLobby lobby)
        {
            if (lobby == null)
                throw new ArgumentNullException(nameof(lobby), "Lobby cannot be null.");

            try
            {
                _context.GameLobby.Add(lobby);
                _context.SaveChanges();
            }
            catch (SqlException ex)
            {
                throw new DataAccessException("SQL error occurred while creating the lobby.", ex);
            }
            catch (Exception ex)
            {
                throw new DataAccessException("An unexpected error occurred while creating the lobby.", ex);
            }
        }

        public GameLobby GetByLobbyName(string lobbyName)
        {
            if (string.IsNullOrWhiteSpace(lobbyName))
                throw new ArgumentException("Lobby name cannot be empty.", nameof(lobbyName));

            try
            {
                return _context.GameLobby.SingleOrDefault(l => l.LobbyName == lobbyName);
            }
            catch (SqlException ex)
            {
                throw new DataAccessException("SQL error occurred while retrieving the lobby by name.", ex);
            }
            catch (Exception ex)
            {
                throw new DataAccessException("An unexpected error occurred while retrieving the lobby by name.", ex);
            }
        }

        public GameLobby GetById(int lobbyId)
        {
            if (lobbyId <= 0)
                throw new ArgumentException("Lobby ID must be greater than zero.", nameof(lobbyId));

            try
            {
                return _context.GameLobby.SingleOrDefault(l => l.LobbyID == lobbyId);
            }
            catch (SqlException ex)
            {
                throw new DataAccessException("SQL error occurred while retrieving the lobby by ID.", ex);
            }
            catch (Exception ex)
            {
                throw new DataAccessException("An unexpected error occurred while retrieving the lobby by ID.", ex);
            }
        }

        public bool IsLobbyPrivate(int lobbyId)
        {
            try
            {
                var lobby = GetById(lobbyId);
                return !string.IsNullOrEmpty(lobby?.Password);
            }
            catch (Exception ex)
            {
                throw new DataAccessException("Error occurred while checking if the lobby is private.", ex);
            }
        }

        public bool VerifyLobbyPassword(int lobbyId, string password)
        {
            if (string.IsNullOrWhiteSpace(password))
                throw new ArgumentException("Password cannot be empty.", nameof(password));

            try
            {
                var lobby = GetById(lobbyId);
                if (lobby == null || lobby.Password == null)
                    return false;

                return lobby.Password == password;
            }
            catch (Exception ex)
            {
                throw new DataAccessException("Error occurred while verifying the lobby password.", ex);
            }
        }

        public void DeleteLobby(int lobbyId)
        {
            try
            {
                var lobby = GetById(lobbyId);
                if (lobby != null)
                {
                    _context.GameLobby.Remove(lobby);
                    _context.SaveChanges();
                }
            }
            catch (SqlException ex)
            {
                throw new DataAccessException("SQL error occurred while deleting the lobby.", ex);
            }
            catch (Exception ex)
            {
                throw new DataAccessException("An unexpected error occurred while deleting the lobby.", ex);
            }
        }

        public void UpdateLobby(GameLobby lobby)
        {
            if (lobby == null)
                throw new ArgumentNullException(nameof(lobby), "Lobby cannot be null.");

            try
            {
                var existingLobby = GetById(lobby.LobbyID);
                if (existingLobby != null)
                {
                    existingLobby.LobbyName = lobby.LobbyName;
                    existingLobby.Password = lobby.Password;
                    existingLobby.HostID = lobby.HostID;
                    _context.SaveChanges();
                }
            }
            catch (SqlException ex)
            {
                throw new DataAccessException("SQL error occurred while updating the lobby.", ex);
            }
            catch (Exception ex)
            {
                throw new DataAccessException("An unexpected error occurred while updating the lobby.", ex);
            }
        }

        public IEnumerable<GameLobby> GetAllLobbies()
        {
            try
            {
                return _context.GameLobby.ToList();
            }
            catch (SqlException ex)
            {
                throw new DataAccessException("SQL error occurred while retrieving all lobbies.", ex);
            }
            catch (Exception ex)
            {
                throw new DataAccessException("An unexpected error occurred while retrieving all lobbies.", ex);
            }
        }

        public IEnumerable<GameLobby> GetPublicLobbies()
        {
            try
            {
                return _context.GameLobby.Where(l => string.IsNullOrEmpty(l.Password)).ToList();
            }
            catch (SqlException ex)
            {
                throw new DataAccessException("SQL error occurred while retrieving public lobbies.", ex);
            }
            catch (Exception ex)
            {
                throw new DataAccessException("An unexpected error occurred while retrieving public lobbies.", ex);
            }
        }
    }
}
