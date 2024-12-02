using DataAccess.Repositories;
using Service.Connection.Managers;
using Service.Contracts;
using Service.DTO;
using Service.Results;
using Service.Utilities.Constans;
using Service.Utilities.Results;
using System;
using System.Linq;
using System.ServiceModel;

namespace Service.Implements
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerSession)]
    public class ChatFriendService : IChatFriendService
    {
        private readonly IChatMessagesRepository _chatMessagesRepository;
        private readonly IFriendRequestRepository _friendRequestRepository;
        private readonly IPlayerRepository _playerRepository;
        private readonly ConnectionManager _connectionManager;

        public ChatFriendService(IChatMessagesRepository chatMessagesRepository,
                                 IFriendRequestRepository friendRequestRepository,
                                 IPlayerRepository playerRepository,
                                 ConnectionManager connectionManager)
        {
            _chatMessagesRepository = chatMessagesRepository;
            _friendRequestRepository = friendRequestRepository;
            _playerRepository = playerRepository;
            _connectionManager = connectionManager;
        }

        public OperationResponse SendMessageToFriend(string senderUsername, string receiverUsername, string message)
        {
            var sender = _playerRepository.GetByUsername(senderUsername);
            var receiver = _playerRepository.GetByUsername(receiverUsername);

            if (sender == null || receiver == null)
            {
                return OperationResponse.Failure(MessageChatFriend.SenderNotFound);
            }

            if (!_friendRequestRepository.AreFriends(sender.PlayerID, receiver.PlayerID))
            {
                return OperationResponse.Failure(MessageChatFriend.NoAreFriend);
            }

            try
            {
                var formattedMessage = $"{senderUsername}: {message}";
                _chatMessagesRepository.AddMessage(sender.PlayerID, receiver.PlayerID, formattedMessage);

                var messageDto = new MessageFriendDTO
                {
                    ReceiverUsername = senderUsername,
                    SenderUsername = senderUsername,
                    Message = formattedMessage,
                    Timestamp = DateTime.Now
                };

                if (_connectionManager.IsUserRegistered(receiverUsername) &&
                    _connectionManager.GetActiveUsers().TryGetValue(receiverUsername, out var receiverChannel))
                {
                    var receiverCallback = receiverChannel.GetProperty<IChatFriendCallback>();
                    receiverCallback?.ReceiveMessage(messageDto.SenderUsername, messageDto.ReceiverUsername,messageDto.Message);
                }

                return OperationResponse.SuccessResult();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error sending message to {receiverUsername}: {ex.Message}");
                return OperationResponse.Failure(MessageChatFriend.CantSendMessages);
            }
        }

        public ChatFriendResponse GetChatHistory(string username1, string username2)
        {
            var player1 = _playerRepository.GetByUsername(username1);
            var player2 = _playerRepository.GetByUsername(username2);

            if (player1 == null || player2 == null)
            {
                return ChatFriendResponse.Failure(MessageChatFriend.SenderNotFound);
            }

            try
            {
                var messages = _chatMessagesRepository.GetMessagesBetweenPlayers(player1.PlayerID, player2.PlayerID);

                var messageList = messages.Select(m => new MessageFriendDTO
                {
                    SenderUsername = m.Player.Username,
                    Message = m.MessageText,
                    Timestamp = (DateTime)m.Timestamp
                }).ToList();

                return ChatFriendResponse.SuccessResult(messageList);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error retrieving chat history: {ex.Message}");
                return ChatFriendResponse.Failure("Error retrieving chat history.");
            }
        }
    }
}
