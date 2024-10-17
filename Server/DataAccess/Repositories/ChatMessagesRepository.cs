using DataAccess.Utilities;
using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Data.SqlClient;
using System.Linq;

namespace DataAccess.Repositories
{
    public class ChatMessagesRepository : IChatMessagesRepository
    {
        private readonly BMCEntities _context;

        public ChatMessagesRepository(BMCEntities context)
        {
            _context = context;
        }

        public IEnumerable<ChatMessages> GetMessagesBetweenPlayers(int player1Id, int player2Id)
        {
            if (player1Id <= 0 || player2Id <= 0)
            {
                throw new ArgumentException("Player IDs must be greater than zero.");
            }

            try
            {
                return _context.ChatMessages
                    .Where(cm => (cm.SenderID == player1Id && cm.ReceiverID == player2Id) ||
                                 (cm.SenderID == player2Id && cm.ReceiverID == player1Id))
                    .OrderBy(cm => cm.Timestamp)
                    .ToList();
            }
            catch (SqlException)
            {
                throw;
            }
            catch (Exception ex)
            {
                throw new DataAccessException("An unexpected error occurred while retrieving messages between players.", ex);
            }
        }

        public IEnumerable<ChatMessages> GetRecentMessages(int playerId, int limit)
        {
            if (playerId <= 0)
            {
                throw new ArgumentException("Player ID must be greater than zero.", nameof(playerId));
            }

            if (limit <= 0)
            {
                throw new ArgumentException("Limit must be greater than zero.", nameof(limit));
            }

            try
            {
                return _context.ChatMessages
                    .Where(cm => cm.ReceiverID == playerId || cm.SenderID == playerId)
                    .OrderByDescending(cm => cm.Timestamp)
                    .Take(limit)
                    .ToList();
            }
            catch (SqlException)
            {
                throw;
            }
            catch (Exception ex)
            {
                throw new DataAccessException("An unexpected error occurred while retrieving recent messages.", ex);
            }
        }

        public void AddMessage(int senderId, int receiverId, string messageText)
        {
            if (senderId <= 0 || receiverId <= 0)
            {
                throw new ArgumentException("Sender and Receiver IDs must be greater than zero.");
            }

            if (string.IsNullOrWhiteSpace(messageText))
            {
                throw new ArgumentException("Message text cannot be empty or whitespace.");
            }

            try
            {
                var message = new ChatMessages
                {
                    SenderID = senderId,
                    ReceiverID = receiverId,
                    MessageText = messageText,
                    Timestamp = DateTime.Now
                };

                _context.ChatMessages.Add(message);
                _context.SaveChanges();
            }
            catch (DbUpdateException ex)
            {
                throw new DataAccessException("Error occurred while adding the chat message.", ex);
            }
            catch (SqlException)
            {
                throw;
            }
            catch (Exception ex)
            {
                throw new DataAccessException("An unexpected error occurred while adding the chat message.", ex);
            }
        }
    }
}
