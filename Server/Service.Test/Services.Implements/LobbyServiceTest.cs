using Microsoft.VisualStudio.TestTools.UnitTesting;
using Service.Implements;
using Service.DTO;
using Service.Utilities.Constans;
using Service.Utilities.Results;
using System.Linq;

namespace Service.Test.Services.Implements
{
    [TestClass]
    public class LobbyServiceTests
    {
        private LobbyService _lobbyService;

        [TestInitialize]
        public void Setup()
        {
            _lobbyService = new LobbyService();
        }

        #region CreateLobby Tests

        [TestMethod]
        public void CreateLobby_Success()
        {
            var request = new CreateLobbyRequestDTO
            {
                Name = "TestLobby",
                IsPrivate = true,
                Password = "12345"
            };

            var response = _lobbyService.CreateLobby(request);
            Assert.AreEqual(request.Name, response.Lobby.Name);
        }

        [TestMethod]
        public void CreateLobby_PublicLobby_Success()
        {
            var request = new CreateLobbyRequestDTO
            {
                Name = "PublicLobby",
                IsPrivate = false,
                Password = null
            };

            var response = _lobbyService.CreateLobby(request);

            Assert.IsTrue(response.IsSuccess && !response.Lobby.IsPrivate);
        }

        [TestMethod]
        public void CreateLobby_Failure_DuplicateLobbyName()
        {
            var request = new CreateLobbyRequestDTO
            {
                Name = "TestLobby",
                IsPrivate = false
            };

            _lobbyService.CreateLobby(request);

            var response = _lobbyService.CreateLobby(request);

            Assert.AreEqual(ErrorMessages.DuplicateLobbyName, response.ErrorKey);
        }

        #endregion

        #region JoinLobby Tests

        [TestMethod]
        public void JoinLobby_Success_PublicLobby()
        {
            var createRequest = new CreateLobbyRequestDTO { Name = "PublicLobby", IsPrivate = false, Username = "HostUser" };
            var createResponse = _lobbyService.CreateLobby(createRequest);

            var joinRequest = new JoinLobbyRequestDTO
            {
                LobbyId = createResponse.Lobby.LobbyId,
                Username = "Player1"
            };

            var joinResponse = _lobbyService.JoinLobby(joinRequest);

            Assert.IsTrue(joinResponse.Lobby.Players.Contains("HostUser") && joinResponse.Lobby.Players.Contains("Player1"));
        }


        [TestMethod]
        public void JoinLobby_Failure_PrivateLobby_IncorrectPassword()
        {
            var createRequest = new CreateLobbyRequestDTO { Name = "PrivateLobby", IsPrivate = true, Password = "correct_password" };
            var createResponse = _lobbyService.CreateLobby(createRequest);

            var joinRequest = new JoinLobbyRequestDTO
            {
                LobbyId = createResponse.Lobby.LobbyId,
                Username = "Player1",
                Password = "wrong_password"
            };

            var joinResponse = _lobbyService.JoinLobby(joinRequest);

            Assert.AreEqual(ErrorMessages.InvalidLobbyPassword, joinResponse.ErrorKey);
        }

        [TestMethod]
        public void JoinLobby_Failure_LobbyFull()
        {
            var createRequest = new CreateLobbyRequestDTO { Name = "FullLobby", IsPrivate = false };
            var createResponse = _lobbyService.CreateLobby(createRequest);

            _lobbyService.JoinLobby(new JoinLobbyRequestDTO { LobbyId = createResponse.Lobby.LobbyId, Username = "Player1" });
            _lobbyService.JoinLobby(new JoinLobbyRequestDTO { LobbyId = createResponse.Lobby.LobbyId, Username = "Player2" });

            var joinRequest = new JoinLobbyRequestDTO
            {
                LobbyId = createResponse.Lobby.LobbyId,
                Username = "Player3"
            };

            var joinResponse = _lobbyService.JoinLobby(joinRequest);

            Assert.AreEqual(ErrorMessages.LobbyFull, joinResponse.ErrorKey);
        }

        #endregion

        #region LeaveLobby Tests

        [TestMethod]
        public void LeaveLobby_Success()
        {
            var createRequest = new CreateLobbyRequestDTO { Name = "LobbyToLeave", IsPrivate = false };
            var createResponse = _lobbyService.CreateLobby(createRequest);

            var joinRequest = new JoinLobbyRequestDTO { LobbyId = createResponse.Lobby.LobbyId, Username = "Player1" };
            _lobbyService.JoinLobby(joinRequest);

            var leaveResponse = _lobbyService.LeaveLobby(createResponse.Lobby.LobbyId, "Player1");

            Assert.AreEqual(1, leaveResponse.Lobby.CurrentPlayers);
        }

        [TestMethod]
        public void LeaveLobby_RemovesLobbyIfEmpty()
        {
            var createRequest = new CreateLobbyRequestDTO { Name = "TemporaryLobby", IsPrivate = false, Username = "HostUser" };
            var createResponse = _lobbyService.CreateLobby(createRequest);

            var joinRequest = new JoinLobbyRequestDTO { LobbyId = createResponse.Lobby.LobbyId, Username = "Player1" };
            _lobbyService.JoinLobby(joinRequest);

            _lobbyService.LeaveLobby(createResponse.Lobby.LobbyId, "Player1");

            var leaveResponse = _lobbyService.LeaveLobby(createResponse.Lobby.LobbyId, "HostUser");

            var allLobbies = _lobbyService.GetAllLobbies();
            Assert.IsFalse(allLobbies.Any(l => l.LobbyId == createResponse.Lobby.LobbyId));
        }


        [TestMethod]
        public void LeaveLobby_Failure_LobbyNotFound()
        {
            var leaveResponse = _lobbyService.LeaveLobby("NonExistentLobbyId", "Player1");

            Assert.IsFalse(leaveResponse.IsSuccess);
            Assert.AreEqual(ErrorMessages.LobbyNotFound, leaveResponse.ErrorKey);
        }

        #endregion

        #region GetAllLobbies Tests

        [TestMethod]
        public void GetAllLobbies_ReturnsAllActiveLobbies()
        {
            _lobbyService.CreateLobby(new CreateLobbyRequestDTO { Name = "Lobby1", IsPrivate = false });
            _lobbyService.CreateLobby(new CreateLobbyRequestDTO { Name = "Lobby2", IsPrivate = true, Password = "secret" });

            var lobbies = _lobbyService.GetAllLobbies();

            Assert.AreEqual(2, lobbies.Count);
            Assert.IsTrue(lobbies.Any(l => l.Name == "Lobby1"));
            Assert.IsTrue(lobbies.Any(l => l.Name == "Lobby2"));
        }

        [TestMethod]
        public void GetAllLobbies_ReturnsEmptyWhenNoActiveLobbies()
        {
            var lobbies = _lobbyService.GetAllLobbies();

            Assert.AreEqual(0, lobbies.Count);
        }

        #endregion


        [TestMethod]
        public void KickPlayer_Success()
        {
            // Crear la lobby y agregar jugadores
            var createRequest = new CreateLobbyRequestDTO { Name = "KickableLobby", IsPrivate = false, Username = "HostUser" };
            var createResponse = _lobbyService.CreateLobby(createRequest);

            var joinRequest = new JoinLobbyRequestDTO { LobbyId = createResponse.Lobby.LobbyId, Username = "PlayerToKick" };
            _lobbyService.JoinLobby(joinRequest);

            // Expulsar al jugador
            var kickResponse = _lobbyService.KickPlayer(createResponse.Lobby.LobbyId, "HostUser", "PlayerToKick");

            Assert.IsTrue(kickResponse.IsSuccess);
            Assert.IsFalse(createResponse.Lobby.Players.Contains("PlayerToKick"));
        }

        [TestMethod]
        public void KickPlayer_Failure_NotHost()
        {
            var createRequest = new CreateLobbyRequestDTO { Name = "KickableLobby", IsPrivate = false, Username = "HostUser" };
            var createResponse = _lobbyService.CreateLobby(createRequest);

            var joinRequest = new JoinLobbyRequestDTO { LobbyId = createResponse.Lobby.LobbyId, Username = "PlayerToKick" };
            _lobbyService.JoinLobby(joinRequest);

            // Intento de expulsar por un usuario que no es el host
            var kickResponse = _lobbyService.KickPlayer(createResponse.Lobby.LobbyId, "NotHostUser", "PlayerToKick");

            Assert.IsFalse(kickResponse.IsSuccess);
            Assert.AreEqual(ErrorMessages.NotLobbyHost, kickResponse.ErrorKey);
        }

        [TestMethod]
        public void KickPlayer_Failure_PlayerNotInLobby()
        {
            var createRequest = new CreateLobbyRequestDTO { Name = "KickableLobby", IsPrivate = false, Username = "HostUser" };
            var createResponse = _lobbyService.CreateLobby(createRequest);

            // Intento de expulsar a un jugador que no está en la lobby
            var kickResponse = _lobbyService.KickPlayer(createResponse.Lobby.LobbyId, "HostUser", "NonExistentPlayer");

            Assert.IsFalse(kickResponse.IsSuccess);
            Assert.AreEqual(ErrorMessages.PlayerNotInLobby, kickResponse.ErrorKey);
        }
    }
}
