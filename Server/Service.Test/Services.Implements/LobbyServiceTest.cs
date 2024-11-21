using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Service.Contracts;
using Service.DTO;
using Service.Implements;
using Service.Utilities.Constans;
using System.Linq;
using System.ServiceModel;

namespace Service.Test.Services.Implements
{
    [TestClass]
    public class LobbyServiceTests
    {
        private LobbyService _lobbyService;
        private Mock<ILobbyCallback> _mockCallback;

        [TestInitialize]
        public void Setup()
        {
            _mockCallback = new Mock<ILobbyCallback>();

            var mockContext = new Mock<OperationContext>(MockBehavior.Strict);
            mockContext.Setup(c => c.GetCallbackChannel<ILobbyCallback>())
                       .Returns(_mockCallback.Object);

            OperationContext.Current = mockContext.Object;

            _lobbyService = new LobbyService();
        }

        #region CreateLobby Tests

        [TestMethod]
        public void CreateLobby_ShouldCreatePrivateLobby_Success()
        {
            var request = new CreateLobbyRequestDTO
            {
                Name = "PrivateLobby",
                IsPrivate = true,
                Password = "12345",
                Username = "HostUser"
            };

            var response = _lobbyService.CreateLobby(request);

            Assert.IsNotNull(response.Lobby, "Lobby should not be null.");
            Assert.AreEqual(request.Name, response.Lobby.Name, "Lobby name does not match.");
            Assert.IsTrue(response.Lobby.IsPrivate, "Lobby should be private.");
        }

        [TestMethod]
        public void CreateLobby_ShouldFailWhenDuplicateName()
        {
            var request = new CreateLobbyRequestDTO
            {
                Name = "DuplicateLobby",
                IsPrivate = false,
                Username = "HostUser"
            };

            _lobbyService.CreateLobby(request);
            var response = _lobbyService.CreateLobby(request);

            Assert.AreEqual(ErrorMessages.DuplicateLobbyName, response.ErrorKey, "Duplicate lobby name error not returned.");
        }

        #endregion

        #region JoinLobby Tests

        [TestMethod]
        public void JoinLobby_ShouldAddPlayerToPublicLobby_Success()
        {
            var createRequest = new CreateLobbyRequestDTO
            {
                Name = "JoinableLobby",
                IsPrivate = false,
                Username = "HostUser"
            };

            var createResponse = _lobbyService.CreateLobby(createRequest);

            var joinRequest = new JoinLobbyRequestDTO
            {
                LobbyId = createResponse.Lobby.LobbyId,
                Username = "Player1"
            };

            var joinResponse = _lobbyService.JoinLobby(joinRequest);

            Assert.IsNotNull(joinResponse.Lobby, "Lobby should not be null.");
            Assert.IsTrue(joinResponse.Lobby.Players.Contains("Player1"), "Player was not added to the lobby.");
        }

        [TestMethod]
        public void JoinLobby_ShouldFailForInvalidPassword()
        {
            var createRequest = new CreateLobbyRequestDTO
            {
                Name = "PrivateLobby",
                IsPrivate = true,
                Password = "correct_password",
                Username = "HostUser"
            };

            var createResponse = _lobbyService.CreateLobby(createRequest);

            var joinRequest = new JoinLobbyRequestDTO
            {
                LobbyId = createResponse.Lobby.LobbyId,
                Username = "Player1",
                Password = "wrong_password"
            };

            var joinResponse = _lobbyService.JoinLobby(joinRequest);

            Assert.AreEqual(ErrorMessages.InvalidLobbyPassword, joinResponse.ErrorKey, "Invalid password error not returned.");
        }

        [TestMethod]
        public void JoinLobby_ShouldFailWhenLobbyIsFull()
        {
            var createRequest = new CreateLobbyRequestDTO
            {
                Name = "FullLobby",
                IsPrivate = false,
                Username = "HostUser"
            };

            var createResponse = _lobbyService.CreateLobby(createRequest);

            _lobbyService.JoinLobby(new JoinLobbyRequestDTO { LobbyId = createResponse.Lobby.LobbyId, Username = "Player1" });
            _lobbyService.JoinLobby(new JoinLobbyRequestDTO { LobbyId = createResponse.Lobby.LobbyId, Username = "Player2" });

            var joinRequest = new JoinLobbyRequestDTO
            {
                LobbyId = createResponse.Lobby.LobbyId,
                Username = "Player3"
            };

            var joinResponse = _lobbyService.JoinLobby(joinRequest);

            Assert.AreEqual(ErrorMessages.LobbyFull, joinResponse.ErrorKey, "Lobby full error not returned.");
        }

        #endregion

        #region LeaveLobby Tests

        [TestMethod]
        public void LeaveLobby_ShouldReducePlayerCount_Success()
        {
            var createRequest = new CreateLobbyRequestDTO
            {
                Name = "ReducibleLobby",
                IsPrivate = false,
                Username = "HostUser"
            };

            var createResponse = _lobbyService.CreateLobby(createRequest);

            var joinRequest = new JoinLobbyRequestDTO
            {
                LobbyId = createResponse.Lobby.LobbyId,
                Username = "Player1"
            };

            _lobbyService.JoinLobby(joinRequest);

            var leaveResponse = _lobbyService.LeaveLobby(createResponse.Lobby.LobbyId, "Player1");

            Assert.AreEqual(1, leaveResponse.Lobby.CurrentPlayers, "Player count was not reduced.");
        }

        [TestMethod]
        public void LeaveLobby_ShouldFailWhenLobbyNotFound()
        {
            var leaveResponse = _lobbyService.LeaveLobby("NonExistentLobbyId", "Player1");

            Assert.AreEqual(ErrorMessages.LobbyNotFound, leaveResponse.ErrorKey, "Lobby not found error not returned.");
        }

        #endregion

        #region KickPlayer Tests

        [TestMethod]
        public void KickPlayer_ShouldRemovePlayerFromLobby_Success()
        {
            var createRequest = new CreateLobbyRequestDTO
            {
                Name = "KickLobby",
                IsPrivate = false,
                Username = "HostUser"
            };

            var createResponse = _lobbyService.CreateLobby(createRequest);

            var joinRequest = new JoinLobbyRequestDTO
            {
                LobbyId = createResponse.Lobby.LobbyId,
                Username = "PlayerToKick"
            };

            _lobbyService.JoinLobby(joinRequest);

            var kickResponse = _lobbyService.KickPlayer(createResponse.Lobby.LobbyId, "HostUser", "PlayerToKick");

            Assert.IsFalse(createResponse.Lobby.Players.Contains("PlayerToKick"), "Player was not removed from the lobby.");
        }

        [TestMethod]
        public void KickPlayer_ShouldFailWhenNotHost()
        {
            var createRequest = new CreateLobbyRequestDTO
            {
                Name = "KickLobby",
                IsPrivate = false,
                Username = "HostUser"
            };

            var createResponse = _lobbyService.CreateLobby(createRequest);

            var joinRequest = new JoinLobbyRequestDTO
            {
                LobbyId = createResponse.Lobby.LobbyId,
                Username = "PlayerToKick"
            };

            _lobbyService.JoinLobby(joinRequest);

            var kickResponse = _lobbyService.KickPlayer(createResponse.Lobby.LobbyId, "NonHostUser", "PlayerToKick");

            Assert.AreEqual(ErrorMessages.NotLobbyHost, kickResponse.ErrorKey, "Not host error not returned.");
        }

        #endregion
    }
}
