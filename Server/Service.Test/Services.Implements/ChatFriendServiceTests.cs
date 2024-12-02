using DataAccess.Repositories;
using DataAccess;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Service.Connection.Managers;
using Service.Implements;
using System.Collections.Generic;
using System;

namespace Service.Test.Services.Implements
{
    [TestClass]
    public class ChatFriendServiceTests
    {
        private Mock<IChatMessagesRepository> _chatMessagesRepositoryMock;
        private Mock<IFriendRequestRepository> _friendRequestRepositoryMock;
        private Mock<IPlayerRepository> _playerRepositoryMock;
        private ConnectionManager _connectionManager;
        private ChatFriendService _chatFriendService;

        [TestInitialize]
        public void Setup()
        {
            _chatMessagesRepositoryMock = new Mock<IChatMessagesRepository>();
            _friendRequestRepositoryMock = new Mock<IFriendRequestRepository>();
            _playerRepositoryMock = new Mock<IPlayerRepository>();
            _connectionManager = new ConnectionManager();

            _chatFriendService = new ChatFriendService(
                _chatMessagesRepositoryMock.Object,
                _friendRequestRepositoryMock.Object,
                _playerRepositoryMock.Object,
                _connectionManager);
        }

        [TestMethod]
        public void SendMessageToFriend_ShouldReturnSuccess_WhenUsersAreFriends()
        {
            var sender = new Player { PlayerID = 1, Username = "UserA" };
            var receiver = new Player { PlayerID = 2, Username = "UserB" };
            _playerRepositoryMock.Setup(r => r.GetByUsername("UserA")).Returns(sender);
            _playerRepositoryMock.Setup(r => r.GetByUsername("UserB")).Returns(receiver);
            _friendRequestRepositoryMock.Setup(r => r.AreFriends(1, 2)).Returns(true);

            var result = _chatFriendService.SendMessageToFriend("UserA", "UserB", "Hello!");

            Assert.IsTrue(result.IsSuccess);
        }

        [TestMethod]
        public void SendMessageToFriend_ShouldReturnFailure_WhenUsersAreNotFriends()
        {
            var sender = new Player { PlayerID = 1, Username = "UserA" };
            var receiver = new Player { PlayerID = 2, Username = "UserB" };
            _playerRepositoryMock.Setup(r => r.GetByUsername("UserA")).Returns(sender);
            _playerRepositoryMock.Setup(r => r.GetByUsername("UserB")).Returns(receiver);
            _friendRequestRepositoryMock.Setup(r => r.AreFriends(1, 2)).Returns(false);

            var result = _chatFriendService.SendMessageToFriend("UserA", "UserB", "Hello!");

            Assert.AreEqual("Users are not friends.", result.ErrorKey);
        }

        [TestMethod]
        public void SendMessageToFriend_ShouldReturnFailure_WhenReceiverNotFound()
        {
            var sender = new Player { PlayerID = 1, Username = "UserA" };
            _playerRepositoryMock.Setup(r => r.GetByUsername("UserA")).Returns(sender);
            _playerRepositoryMock.Setup(r => r.GetByUsername("UserB")).Returns((Player)null);

            var result = _chatFriendService.SendMessageToFriend("UserA", "UserB", "Hello!");

            Assert.IsFalse(result.IsSuccess);
        }

        [TestMethod]
        public void SendMessageToFriend_ShouldReturnFailure_WhenExceptionOccurs()
        {
            var sender = new Player { PlayerID = 1, Username = "UserA" };
            var receiver = new Player { PlayerID = 2, Username = "UserB" };
            _playerRepositoryMock.Setup(r => r.GetByUsername("UserA")).Returns(sender);
            _playerRepositoryMock.Setup(r => r.GetByUsername("UserB")).Returns(receiver);
            _friendRequestRepositoryMock.Setup(r => r.AreFriends(1, 2)).Returns(true);
            _chatMessagesRepositoryMock.Setup(r => r.AddMessage(It.IsAny<int>(), It.IsAny<int>(), It.IsAny<string>())).Throws(new Exception("DB error"));

            var result = _chatFriendService.SendMessageToFriend("UserA", "UserB", "Hello!");

            Assert.IsFalse(result.IsSuccess);
        }

        [TestMethod]
        public void GetChatHistory_ShouldReturnSuccess_WithMessages()
        {
            var player1 = new Player { PlayerID = 1, Username = "UserA" };
            var player2 = new Player { PlayerID = 2, Username = "UserB" };
            var messages = new List<ChatMessages>
            {
                new ChatMessages { Player = player1, MessageText = "Hello!", Timestamp = DateTime.Now }
            };
            _playerRepositoryMock.Setup(r => r.GetByUsername("UserA")).Returns(player1);
            _playerRepositoryMock.Setup(r => r.GetByUsername("UserB")).Returns(player2);
            _chatMessagesRepositoryMock.Setup(r => r.GetMessagesBetweenPlayers(1, 2)).Returns(messages);

            var result = _chatFriendService.GetChatHistory("UserA", "UserB");

            Assert.IsTrue(result.IsSuccess);
        }

        [TestMethod]
        public void GetChatHistory_ShouldReturnFailure_WhenUsersNotFound()
        {
            _playerRepositoryMock.Setup(r => r.GetByUsername("UserA")).Returns((Player)null);

            var result = _chatFriendService.GetChatHistory("UserA", "UserB");

            Assert.IsFalse(result.IsSuccess);
        }

        [TestMethod]
        public void GetChatHistory_ShouldReturnFailure_WhenExceptionOccurs()
        {
            var player1 = new Player { PlayerID = 1, Username = "UserA" };
            var player2 = new Player { PlayerID = 2, Username = "UserB" };
            _playerRepositoryMock.Setup(r => r.GetByUsername("UserA")).Returns(player1);
            _playerRepositoryMock.Setup(r => r.GetByUsername("UserB")).Returns(player2);
            _chatMessagesRepositoryMock.Setup(r => r.GetMessagesBetweenPlayers(It.IsAny<int>(), It.IsAny<int>())).Throws(new Exception("DB error"));

            var result = _chatFriendService.GetChatHistory("UserA", "UserB");

            Assert.AreEqual("Error retrieving chat history.", result.ErrorKey);
        }
    }
}
