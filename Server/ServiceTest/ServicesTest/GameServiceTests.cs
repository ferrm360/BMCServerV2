using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Service.Contracts;
using Service.DTO;
using Service.Entities;
using Service.Implements;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service.Test.Services.Implements
{
    [TestClass]
    public class GameServiceTests
    {
        private Mock<IGameCallback> _callbackMock;
        private Mock<GameSession> _gameSessionMock;
        private GameService _gameService;

        [TestInitialize]
        public void Setup()
        {
            // Mocks
            _callbackMock = new Mock<IGameCallback>();
            _gameSessionMock = new Mock<GameSession>();

            // Inyectar los mocks en la clase que queremos probar
            _gameService = new GameService();
        }

        [TestMethod]
        public async Task AttackAsync_ShouldReturnFailure_WhenGameNotFound()
        {
            // Arrange
            string lobbyId = "lobby1";
            string attacker = "Player1";
            var attackPosition = new AttackPositionDTO { X = 1, Y = 1 };

            // Simular que el juego no existe
            GameService._activeGames.Clear();

            // Act
            var result = await _gameService.AttackAsync(lobbyId, attacker, attackPosition);

            // Assert
            Assert.IsFalse(result.IsSuccess);
            Assert.AreEqual("Game not found.", result.ErrorKey);
        }

        [TestMethod]
        public async Task AttackAsync_ShouldReturnFailure_WhenNotYourTurn()
        {
            // Arrange
            string lobbyId = "lobby1";
            string attacker = "Player1";
            var attackPosition = new AttackPositionDTO { X = 1, Y = 1 };

            // Simulamos un juego en curso
            var gameSession = new GameSession();
            GameService._activeGames[lobbyId] = gameSession;


            // Act
            var result = await _gameService.AttackAsync(lobbyId, attacker, attackPosition);

            // Assert
            Assert.IsFalse(result.IsSuccess);
            Assert.AreEqual("It's not your turn.", result.ErrorKey);
        }

        [TestMethod]
        public async Task AttackAsync_ShouldReturnSuccess_WhenAttackSent()
        {
            // Arrange
            string lobbyId = "lobby1";
            string attacker = "Player1";
            var attackPosition = new AttackPositionDTO { X = 1, Y = 1 };

            // Simulamos un juego en curso
            var gameSession = new GameSession();
            GameService._activeGames[lobbyId] = gameSession;

         
            var result = await _gameService.AttackAsync(lobbyId, attacker, attackPosition);

            // Assert
            Assert.IsTrue(result.IsSuccess);
            _callbackMock.Verify(cb => cb.OnAttackReceived(It.IsAny<AttackPositionDTO>()), Times.Once);
        }

    }
}
