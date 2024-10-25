using DataAccess;
using DataAccess.Repositories;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Service.Contracts;
using Service.DTO;
using Service.Implements;
using Service.Utilities.Helpers;
using System;

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

        [TestMethod]
        public void Register_ShouldReturnFailure_WhenUsernameIsEmpty()
        {
            var playerDTO = new PlayerDTO { Username = "", Email = "ferram@gmail.com", Password = "Fer20HVZRA6" };

            var result = _accountService.Register(playerDTO);

            Assert.AreEqual("Error.InvalidUsername", result.ErrorKey);
        }

        [TestMethod]
        public void Register_ShouldReturnFailure_WhenEmailIsInvalid()
        {
            var playerDTO = new PlayerDTO { Username = "FerRMZ", Email = "", Password = "Fer20HVZRA6" };

            var result = _accountService.Register(playerDTO);

            Assert.AreEqual("Error.InvalidEmail", result.ErrorKey);
        }

        [TestMethod]
        public void Register_ShouldReturnFailure_WhenPasswordIsEmpty()
        {
            var playerDTO = new PlayerDTO { Username = "FerRMZ", Email = "ferram@gmail.com", Password = "" };

            var result = _accountService.Register(playerDTO);

            Assert.AreEqual("Error.InvalidPassword", result.ErrorKey);
        }

        [TestMethod]
        public void Login_ShouldReturnFailure_WhenUserNotFound()
        {
            var username = "FerRMZ";
            var password = "323242ddfdMetFer";
            _playerRepositoryMock.Setup(r => r.GetByUsername(It.IsAny<string>())).Returns((Player)null);

            var result = _accountService.Login(username, password);

            Assert.AreEqual("Error.UserNotFound", result.ErrorKey);
        }

        [TestMethod]
        public void Login_ShouldReturnFailure_WhenPasswordIsInvalid()
        {
            var username = "FerRMZ";
            var password = "323242ddfdMetFer20";
            var player = new Player { Username = username, PasswordHash = PasswordHelper.HashPassword("323242ddfdMetFer") };
            _playerRepositoryMock.Setup(r => r.GetByUsername(It.IsAny<string>())).Returns(player);

            var result = _accountService.Login(username, password);

            Assert.AreEqual("Error.InvalidPassword", result.ErrorKey);
        }

        [TestMethod]
        public void Login_ShouldReturnSuccess_WhenCredentialsAreValid()
        {
            var username = "FerRMZ";
            var password = "323242ddfdMetFer";
            var player = new Player { Username = username, PasswordHash = PasswordHelper.HashPassword(password) };
            _playerRepositoryMock.Setup(r => r.GetByUsername(It.IsAny<string>())).Returns(player);

            var result = _accountService.Login(username, password);

            Assert.IsTrue(result.IsSuccess);
        }

        [TestMethod]
        public void Login_ShouldReturnFailure_WhenUsernameIsEmpty()
        {
            var username = "";
            var password = "323242ddfdMetFer";

            var result = _accountService.Login(username, password);

            Assert.AreEqual("Error.InvalidUsername", result.ErrorKey);
        }

        [TestMethod]
        public void Login_ShouldReturnFailure_WhenPasswordIsEmpty()
        {
            var username = "FerRMZ";
            var password = "";

            var result = _accountService.Login(username, password);

            Assert.AreEqual("Error.InvalidPassword", result.ErrorKey);
        }
    }
}
