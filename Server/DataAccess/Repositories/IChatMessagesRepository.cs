using System.Collections.Generic;

namespace DataAccess.Repositories
{
    public interface IChatMessagesRepository
    {
        IEnumerable<ChatMessages> GetMessagesBetweenPlayers(int player1Id, int player2Id);
        IEnumerable<ChatMessages> GetRecentMessages(int playerId, int limit);
        void AddMessage(int senderId, int receiverId, string messageText);
    }
}