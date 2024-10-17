using System.Collections.Generic;

namespace DataAccess.Repositories
{
    public interface IGameLobbyRepository
    {
        void CreateLobby(GameLobby lobby);
        GameLobby GetByLobbyName(string lobbyName);
        GameLobby GetById(int lobbyId);
        bool IsLobbyPrivate(int lobbyId);
        bool VerifyLobbyPassword(int lobbyId, string password);
        void DeleteLobby(int lobbyId);
        void UpdateLobby(GameLobby lobby);
        IEnumerable<GameLobby> GetAllLobbies();
        IEnumerable<GameLobby> GetPublicLobbies();
    }
}
