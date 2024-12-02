using DataAccess;
using Service.DTO;
using System;


namespace Service.Factories
{
    public static class EntityFactory
    {
        public static Player CreatePlayerEntity(PlayerDTO playerDto, string passwordHash)
        {
            return new Player
            {
                Username = playerDto.Username,
                Email = playerDto.Email,
                PasswordHash = passwordHash
            };
        }

        public static Profile CreateProfileEntity(int playerId)
        {
            return new Profile
            {
                PlayerID = playerId,
                FullName = "Default Name",
                AvatarURL = "default_avatar.png",
                Bio = "Default Bio",
                JoinDate = DateTime.Now,
                SignUpDate = DateTime.Now,
                LastVisit = DateTime.Now
            };
        }

        public static UserScores CreatePlayerScoresEntity(int playerId)
        {
            return new UserScores
            {
                PlayerID = playerId,
                Wins = 0,
                Losses = 0
            };
        }

        public static FriendRequest CreateFriendRequest(int senderId, int receiverId)
        {
            return new FriendRequest
            {
                SenderPlayerID = senderId,
                ReceiverPlayerID = receiverId,
                RequestStatus = "pending"
            };
        }

        public static ChatMessages CreateChatMessage(int senderId, int receiverId, string messageText)
        {
            return new ChatMessages
            {
                SenderID = senderId,
                ReceiverID = receiverId,
                MessageText = messageText,
                Timestamp = DateTime.Now
            };
        }

        public static GameLobby CreateGameLobby(string lobbyName, int hostId, string password = null)
        {
            return new GameLobby
            {
                LobbyName = lobbyName,
                HostID = hostId,
                Password = password
            };
        }

        public static GuestPlayers CreateGuestPlayer(string username, int statusId)
        {
            return new GuestPlayers
            {
                Username = username,
                JoinDate = DateTime.Now
            };
        }

        public static PasswordResetRequests CreatePasswordResetRequest(int playerId, string resetCode)
        {
            return new PasswordResetRequests
            {
                PlayerID = playerId,
                ResetCode = resetCode,
                ExpirationDate = DateTime.Now.AddHours(1),
                IsUsed = false
            };
        }
    }
}
