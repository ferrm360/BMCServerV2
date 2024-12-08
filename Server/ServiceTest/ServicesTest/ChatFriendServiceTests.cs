using DataAccess.Repositories;
using DataAccess;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Service.Connection.Managers;
using Service.Implements;
using System.Collections.Generic;
using System;

namespace ServiceTest.Implements
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
            var sender = new Player { PlayerID = 1, Username = "FerRMZ" };
            var receiver = new Player { PlayerID = 2, Username = "Marla" };
            _playerRepositoryMock.Setup(r => r.GetByUsername("FerRMZ")).Returns(sender);
            _playerRepositoryMock.Setup(r => r.GetByUsername("Marla")).Returns(receiver);
            _friendRequestRepositoryMock.Setup(r => r.AreFriends(1, 2)).Returns(true);

            var result = _chatFriendService.SendMessageToFriend("FerRMZ", "Marla", "Hello!");

            Assert.IsTrue(result.IsSuccess);
        }

        [TestMethod]
        public void SendMessageToFriend_ShouldReturnFailure_WhenUsersAreNotFriends()
        {
            var sender = new Player { PlayerID = 1, Username = "FerRMZ" };
            var receiver = new Player { PlayerID = 2, Username = "Marla" };
            _playerRepositoryMock.Setup(r => r.GetByUsername("FerRMZ")).Returns(sender);
            _playerRepositoryMock.Setup(r => r.GetByUsername("Marla")).Returns(receiver);
            _friendRequestRepositoryMock.Setup(r => r.AreFriends(1, 2)).Returns(false);

            var result = _chatFriendService.SendMessageToFriend("FerRMZ", "Marla", "Hello!");

            Assert.AreEqual("Info.NoAreFriends", result.ErrorKey);
        }

        [TestMethod]
        public void SendMessageToFriend_ShouldReturnFailure_WhenReceiverNotFound()
        {
            var sender = new Player { PlayerID = 1, Username = "FerRMZ" };
            _playerRepositoryMock.Setup(r => r.GetByUsername("FerRMZ")).Returns(sender);
            _playerRepositoryMock.Setup(r => r.GetByUsername("Marla")).Returns((Player)null);

            var result = _chatFriendService.SendMessageToFriend("FerRMZ", "Marla", "Hello!");

            Assert.IsFalse(result.IsSuccess);
        }

        [TestMethod]
        public void SendMessageToFriend_ShouldReturnFailure_WhenExceptionOccurs()
        {
            var sender = new Player { PlayerID = 1, Username = "FerRMZ" };
            var receiver = new Player { PlayerID = 2, Username = "Marla" };
            _playerRepositoryMock.Setup(r => r.GetByUsername("FerRMZ")).Returns(sender);
            _playerRepositoryMock.Setup(r => r.GetByUsername("Marla")).Returns(receiver);
            _friendRequestRepositoryMock.Setup(r => r.AreFriends(1, 2)).Returns(true);
            _chatMessagesRepositoryMock.Setup(r => r.AddMessage(It.IsAny<int>(), It.IsAny<int>(), It.IsAny<string>())).Throws(new Exception("DB error"));

            var result = _chatFriendService.SendMessageToFriend("FerRMZ", "Marla", "Hello!");

            Assert.IsFalse(result.IsSuccess);
        }

        [TestMethod]
        public void GetChatHistory_ShouldReturnSuccess_WithMessages()
        {
            var player1 = new Player { PlayerID = 1, Username = "FerRMZ" };
            var player2 = new Player { PlayerID = 2, Username = "Marla" };
            var messages = new List<ChatMessages>
            {
                new ChatMessages { Player = player1, MessageText = "Hello!", Timestamp = DateTime.Now }
            };
            _playerRepositoryMock.Setup(r => r.GetByUsername("FerRMZ")).Returns(player1);
            _playerRepositoryMock.Setup(r => r.GetByUsername("Marla")).Returns(player2);
            _chatMessagesRepositoryMock.Setup(r => r.GetMessagesBetweenPlayers(1, 2)).Returns(messages);

            var result = _chatFriendService.GetChatHistory("FerRMZ", "Marla");

            Assert.IsTrue(result.IsSuccess);
        }

        [TestMethod]
        public void GetChatHistory_ShouldReturnFailure_WhenUsersNotFound()
        {
            _playerRepositoryMock.Setup(r => r.GetByUsername("FerRMZ")).Returns((Player)null);

            var result = _chatFriendService.GetChatHistory("FerRMZ", "Marla");

            Assert.IsFalse(result.IsSuccess);
        }

        [TestMethod]
        public void GetChatHistory_ShouldReturnFailure_WhenExceptionOccurs()
        {
            var player1 = new Player { PlayerID = 1, Username = "FerRMZ" };
            var player2 = new Player { PlayerID = 2, Username = "Marla" };
            _playerRepositoryMock.Setup(r => r.GetByUsername("FerRMZ")).Returns(player1);
            _playerRepositoryMock.Setup(r => r.GetByUsername("Marla")).Returns(player2);
            _chatMessagesRepositoryMock.Setup(r => r.GetMessagesBetweenPlayers(It.IsAny<int>(), It.IsAny<int>())).Throws(new Exception("DB error"));

            var result = _chatFriendService.GetChatHistory("FerRMZ", "Marla");

            Assert.AreEqual("Error retrieving chat history.", result.ErrorKey);
        }
    }
}
