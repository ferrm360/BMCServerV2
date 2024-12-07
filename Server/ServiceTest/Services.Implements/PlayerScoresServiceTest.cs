using DataAccess.Repositories;
using DataAccess;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Service.DTO;
using Service.Implements;
using Service.Utilities.Constans;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ServiceTest.Services.Implements
{
    [TestClass]
    public class PlayerScoresServiceTest
    {
        private Mock<IPlayerRepository> _mockPlayerRepository;
        private Mock<IPlayerScoresRepository> _mockScoreRepository;
        private PlayerScoresService _playerScoresService;

        [TestInitialize]
        public void Setup()
        {
            _mockPlayerRepository = new Mock<IPlayerRepository>();
            _mockScoreRepository = new Mock<IPlayerScoresRepository>();

            _playerScoresService = new PlayerScoresService(_mockScoreRepository.Object, _mockPlayerRepository.Object);
        }

        [TestMethod]
        public void GetScoresByUsername_PlayerNotFound_ReturnsFailure()
        {
            var username = "FerRMZ";
            _mockPlayerRepository.Setup(repo => repo.GetByUsername(username)).Returns((Player)null);

            var result = _playerScoresService.GetScoresByUsername(username);

            Assert.IsFalse(result.IsSuccess);
            Assert.AreEqual(ErrorMessages.UserNotFound, result.ErrorKey);
        }

        [TestMethod]
        public void GetScoresByUsername_ScoresNotFound_ReturnsFailure()
        {
            var username = "FerRMZ";
            var player = new Player { PlayerID = 1, Username = username };
            _mockPlayerRepository.Setup(repo => repo.GetByUsername(username)).Returns(player);

            var result = _playerScoresService.GetScoresByUsername(username);

            Assert.IsFalse(result.IsSuccess);
        }

        [TestMethod]
        public void GetScoresByUsername_Success_ReturnsScores()
        {
            var username = "FerRMZ";
            var player = new Player { PlayerID = 1, Username = username };
            var playerScores = new UserScores { PlayerID = 1, Wins = 5, Losses = 3 };

            _mockPlayerRepository.Setup(repo => repo.GetByUsername(username)).Returns(player);
            _mockScoreRepository.Setup(repo => repo.GetScoresByPlayerId(player.PlayerID)).Returns(playerScores);

            var result = _playerScoresService.GetScoresByUsername(username);

            Assert.IsTrue(result.IsSuccess);
        }

        [TestMethod]
        public void IncrementWins_PlayerNotFound_ReturnsFailure()
        {
            var username = "FerRMZ";
            _mockPlayerRepository.Setup(repo => repo.GetByUsername(username)).Returns((Player)null);

            var result = _playerScoresService.IncrementWins(username);

            Assert.IsFalse(result.IsSuccess);
            Assert.AreEqual(ErrorMessages.UserNotFound, result.ErrorKey);
        }

        [TestMethod]
        public void IncrementWins_Success_IncrementsWins()
        {
            var username = "FerRMZ";
            var player = new Player { PlayerID = 1, Username = username };
            _mockPlayerRepository.Setup(repo => repo.GetByUsername(username)).Returns(player);
            _mockScoreRepository.Setup(repo => repo.IncrementWins(player.PlayerID));
            _mockScoreRepository.Setup(repo => repo.Save());

            var result = _playerScoresService.IncrementWins(username);

            Assert.IsTrue(result.IsSuccess);
        }

        [TestMethod]
        public void IncrementLosses_PlayerNotFound_ReturnsFailure()
        {
            var username = "FerRMZ";
            _mockPlayerRepository.Setup(repo => repo.GetByUsername(username)).Returns((Player)null);

            var result = _playerScoresService.IncrementLosses(username);

            Assert.IsFalse(result.IsSuccess);
            Assert.AreEqual(ErrorMessages.UserNotFound, result.ErrorKey);
        }

        [TestMethod]
        public void IncrementLosses_Success_IncrementsLosses()
        {
            var username = "FerRMZ";
            var player = new Player { PlayerID = 1, Username = username };
            _mockPlayerRepository.Setup(repo => repo.GetByUsername(username)).Returns(player);
            _mockScoreRepository.Setup(repo => repo.IncrementLosses(player.PlayerID));
            _mockScoreRepository.Setup(repo => repo.Save());

            var result = _playerScoresService.IncrementLosses(username);

            Assert.IsTrue(result.IsSuccess);
        }
    }
}
