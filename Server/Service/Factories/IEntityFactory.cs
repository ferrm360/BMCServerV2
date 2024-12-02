using DataAccess;
using Service.DTO;

namespace Service.Factories
{
    public interface IEntityFactory
    {
        Player CreatePlayerEntity(PlayerDTO playerDto, string passwordHash);
        Profile CreateProfileEntity(int playerId);
        UserScores CreatePlayerScoresEntity(int playerId);
        FriendRequest CreateFriendRequest(int senderId, int receiverId);
        ChatMessages CreateChatMessage(int senderId, int receiverId, string messageText);
        GameLobby CreateGameLobby(string lobbyName, int hostId, string password = null);
        GuestPlayers CreateGuestPlayer(string username, int statusId);
        PasswordResetRequests CreatePasswordResetRequest(int playerId, string resetCode);
    }
}
