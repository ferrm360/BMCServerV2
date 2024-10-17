using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.Entity;
using System.Data.SqlClient;
using DataAccess.Utilities;

namespace DataAccess.Repositories
{
    public class LobbyPlayersRepository : ILobbyPlayersRepository
    {
        private readonly BMCEntities _context;

        public LobbyPlayersRepository(BMCEntities context)
        {
            _context = context;
        }

        public void AddPlayerToLobby(int lobbyId, int playerId)
        {
            if (IsLobbyFull(lobbyId))
            {
                throw new InvalidOperationException("Lobby is full. Cannot add more players.");
            }

            var lobbyPlayer = new LobbyPlayers
            {
                LobbyID = lobbyId,
                PlayerID = playerId,
                PlayerStatus = "Not Ready"
            };

            try
            {
                _context.LobbyPlayers.Add(lobbyPlayer);
                _context.SaveChanges();
            }
            catch (SqlException)
            {
                throw;
            }
            catch (Exception ex)
            {
                throw new DataAccessException("An unexpected error occurred while adding the player to the lobby.", ex);
            }
        }

        public void RemovePlayerFromLobby(int lobbyId, int playerId)
        {
            var lobbyPlayer = _context.LobbyPlayers
                .FirstOrDefault(lp => lp.LobbyID == lobbyId && lp.PlayerID == playerId);

            if (lobbyPlayer != null)
            {
                try
                {
                    _context.LobbyPlayers.Remove(lobbyPlayer);
                    _context.SaveChanges();
                }
                catch (SqlException)
                {
                    throw;
                }
                catch (Exception ex)
                {
                    throw new DataAccessException("An unexpected error occurred while removing the player from the lobby.", ex);
                }
            }
        }

        public IEnumerable<LobbyPlayers> GetPlayersInLobby(int lobbyId)
        {
            try
            {
                return _context.LobbyPlayers
                    .Where(lp => lp.LobbyID == lobbyId)
                    .Include(lp => lp.Player)
                    .ToList();
            }
            catch (SqlException)
            {
                throw;
            }
            catch (Exception ex)
            {
                throw new DataAccessException("An unexpected error occurred while fetching players in the lobby.", ex);
            }
        }

        public bool IsPlayerInLobby(int lobbyId, int playerId)
        {
            try
            {
                return _context.LobbyPlayers
                    .Any(lp => lp.LobbyID == lobbyId && lp.PlayerID == playerId);
            }
            catch (SqlException)
            {
                throw;
            }
            catch (Exception ex)
            {
                throw new DataAccessException("An unexpected error occurred while checking if player is in the lobby.", ex);
            }
        }

        public bool IsLobbyFull(int lobbyId)
        {
            try
            {
                return _context.LobbyPlayers
                    .Count(lp => lp.LobbyID == lobbyId) >= 2;
            }
            catch (SqlException)
            {
                throw;
            }
            catch (Exception ex)
            {
                throw new DataAccessException("An unexpected error occurred while checking if the lobby is full.", ex);
            }
        }

        public int GetNumberOfPlayersInLobby(int lobbyId)
        {
            try
            {
                return _context.LobbyPlayers.Count(lp => lp.LobbyID == lobbyId);
            }
            catch (SqlException)
            {
                throw;
            }
            catch (Exception ex)
            {
                throw new DataAccessException("An unexpected error occurred while getting the number of players in the lobby.", ex);
            }
        }

        public void UpdatePlayerStatus(int lobbyId, int playerId, string status)
        {
            var lobbyPlayer = _context.LobbyPlayers
                .FirstOrDefault(lp => lp.LobbyID == lobbyId && lp.PlayerID == playerId);

            if (lobbyPlayer != null)
            {
                try
                {
                    lobbyPlayer.PlayerStatus = status;
                    _context.SaveChanges();
                }
                catch (SqlException)
                {
                    throw;
                }
                catch (Exception ex)
                {
                    throw new DataAccessException("An unexpected error occurred while updating player status.", ex);
                }
            }
        }
    }
}
