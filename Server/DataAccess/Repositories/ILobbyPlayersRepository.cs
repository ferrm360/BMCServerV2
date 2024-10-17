using System.Collections.Generic;

namespace DataAccess.Repositories
{
    public interface ILobbyPlayersRepository
    {
        void AddPlayerToLobby(int lobbyId, int playerId);
        void RemovePlayerFromLobby(int lobbyId, int playerId);
        IEnumerable<LobbyPlayers> GetPlayersInLobby(int lobbyId);
        bool IsPlayerInLobby(int lobbyId, int playerId);
        bool IsLobbyFull(int lobbyId);
        int GetNumberOfPlayersInLobby(int lobbyId);
        void UpdatePlayerStatus(int lobbyId, int playerId, string status);
    }
}