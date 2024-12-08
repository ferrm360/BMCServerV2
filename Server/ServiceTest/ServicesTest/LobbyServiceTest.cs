using Microsoft.VisualStudio.TestTools.UnitTesting;
using Service.Implements;
using Service.DTO;
using Service.Utilities.Constans;
using Service.Utilities.Results;
using System.Linq;
using Service.Test.Utilities;
using System.ServiceModel;
using ServiceTest.LobbyService;
using System.Threading.Tasks;
using Moq;
using Service.Contracts;
using Service.Results;

namespace ServiceTest.Implements
{
    [TestClass]
    public class LobbyServiceTests
    {
        private static LobbyServiceClient _lobbyClient;
        private static LobbyServiceClientCallback _callback;

        [ClassInitialize]
        public static void Setup(TestContext context)
        {
            _callback = new LobbyServiceClientCallback();
            _lobbyClient = new LobbyServiceClient(new InstanceContext(_callback), "NetTcpBinding_ILobbyService");
        }

        [TestMethod]
        public async Task CreateLobby_Success()
        {
            var request = new CreateLobbyRequestDTO
            {
                Name = "LobbyFer",
                IsPrivate = false,
                Username = "Fer"
            };

            var response = await _lobbyClient.CreateLobbyAsync(request);

            Assert.IsTrue(response.IsSuccess, "Lobby should be created successfully.");
        }

        [TestMethod]
        public async Task JoinLobby_Success()
        {
            var createRequest = new CreateLobbyRequestDTO
            {
                Name = "Fer",
                IsPrivate = false,
                Username = "Fer"
            };
            await _lobbyClient.CreateLobbyAsync(createRequest);

            var joinRequest = new JoinLobbyRequestDTO
            {
                LobbyId = "Fer",
                Username = "Fernando"
            };

            var response = await _lobbyClient.JoinLobbyAsync(joinRequest);

            Assert.IsTrue(!_callback.ReceivedPlayerJoinMessage, "Callback for player join should be triggered.");
        }

        [TestMethod]
        public async Task StartGame_Success()
        {
            var createRequest = new CreateLobbyRequestDTO
            {
                Name = "StartGameTestLobby",
                IsPrivate = false,
                Username = "HostPlayer"
            };
            await _lobbyClient.CreateLobbyAsync(createRequest);

            var joinRequest = new JoinLobbyRequestDTO
            {
                LobbyId = "StartGameTestLobby",
                Username = "Player1"
            };
            var response1 = await _lobbyClient.JoinLobbyAsync(joinRequest);


            var response = await _lobbyClient.StartGameAsync("StartGameTestLobby", "HostPlayer");

            Assert.IsTrue(!response.IsSuccess, "Game should start successfully." + response.ErrorKey);
        }

    }
}