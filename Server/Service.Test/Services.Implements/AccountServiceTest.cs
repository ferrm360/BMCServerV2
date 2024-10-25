using DataAccess;
using DataAccess.Repositories;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Service.Contracts;
using Service.DTO;
using Service.Implements;

namespace Service.Test.Services.Implements
{
    [TestClass]
    public class AccountServiceTests
    {
        private Mock<IPlayerRepository> _playerRepositoryMock;
        private Mock<IProfileRepository> _profileRepositoryMock;
        private Mock<IPlayerScoresRepository> _scoreRepositoryMock;
        private IAccountService _accountService;

        [TestInitialize]
        public void Setup()
        {
            _playerRepositoryMock = new Mock<IPlayerRepository>();
            _profileRepositoryMock = new Mock<IProfileRepository>();
            _scoreRepositoryMock = new Mock<IPlayerScoresRepository>();

            _accountService = new AccountService(
                _playerRepositoryMock.Object,
                _profileRepositoryMock.Object,
                _scoreRepositoryMock.Object);
        }

        [TestMethod]
        public void Register_ShouldReturnFailure_WhenUsernameExists()
        {
            var playerDTO = new PlayerDTO { Username = "FerRMZ", Email = "ferram@gmail.com", Password = "Fer20HVZRA6" };

            _playerRepositoryMock.Setup(r => r.GetByUsername(It.IsAny<string>())).Returns(new Player());

            var result = _accountService.Register(playerDTO);

            Assert.AreEqual("Error.DuplicateUsername", result.ErrorKey);
        }

        [TestMethod]
        public void Register_ShouldReturnFailure_WhenEmailExists()
        {
            var playerDTO = new PlayerDTO { Username = "-FerRM-", Email = "ferram@gmail.com", Password = "Fer112620HVZRA6" };

            _playerRepositoryMock.Setup(r => r.GetByEmail(It.IsAny<string>())).Returns(new Player());

            var result = _accountService.Register(playerDTO);

            Assert.AreEqual("Error.DuplicateEmail", result.ErrorKey);
        }

        [TestMethod]
        public void Register_ShouldReturnSuccess_WhenValidPlayer()
        {
            var playerDTO = new PlayerDTO { Username = "Fer2011", Email = "Fer2011@gmail.com", Password = "Fer112620HVZRA6" };

            _playerRepositoryMock.Setup(r => r.GetByUsername(It.IsAny<string>())).Returns((Player)null);
            _playerRepositoryMock.Setup(r => r.GetByEmail(It.IsAny<string>())).Returns((Player)null);

            var result = _accountService.Register(playerDTO);

            Assert.IsTrue(result.IsSuccess);
        }
    }
}
