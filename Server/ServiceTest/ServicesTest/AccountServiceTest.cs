using DataAccess;
using DataAccess.Repositories;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Service.Connection.Managers;
using Service.Contracts;
using Service.DTO;
using Service.Implements;
using Service.Utilities.Helpers;
using Service.Utilities.Validators.AccountService;
using System;
using System.ServiceModel;

namespace ServiceTest.Implements
{
    [TestClass]
    public class AccountServiceTests
    {
        private Mock<IPlayerRepository> _playerRepositoryMock;
        private Mock<IProfileRepository> _profileRepositoryMock;
        private Mock<IPlayerScoresRepository> _scoreRepositoryMock;
        private ConnectionManager _connectionManager;
        private ConnectionEventHandler _connectionEventHandler;
        private IAccountService _accountService;
        private Mock<IValidationAccountService> _validationAccountServiceMock;

        [TestInitialize]
        public void Setup()
        {
            _playerRepositoryMock = new Mock<IPlayerRepository>();
            _profileRepositoryMock = new Mock<IProfileRepository>();
            _scoreRepositoryMock = new Mock<IPlayerScoresRepository>();
            _validationAccountServiceMock = new Mock<IValidationAccountService>();

            _connectionManager = new ConnectionManager();
            _connectionEventHandler = new ConnectionEventHandler(_connectionManager);

            _accountService = new AccountService(
                _playerRepositoryMock.Object,
                _profileRepositoryMock.Object,
                _scoreRepositoryMock.Object,
                _connectionManager,
                _connectionEventHandler,
                _validationAccountServiceMock.Object
            );
        }


        [TestMethod]
        public void Register_ShouldReturnFailure_WhenUsernameExists()
        {
            var playerDTO = new PlayerDTO { Username = "FerRMZ", Email = "ferram@gmail.com", Password = "Fer20HVZRA6" };

            _validationAccountServiceMock.Setup(v => v.ValidateUsername(playerDTO.Username)).Returns((string)null);
            _validationAccountServiceMock.Setup(v => v.ValidateEmail(playerDTO.Email)).Returns((string)null);
            _validationAccountServiceMock.Setup(v => v.ValidatePassword(playerDTO.Password)).Returns((string)null);
            _validationAccountServiceMock.Setup(v => v.ValidatePlayerExistsByUsername(It.IsAny<IPlayerRepository>(), playerDTO.Username)).Returns("Error.DuplicateUsername");

            var result = _accountService.Register(playerDTO);

            Assert.AreEqual("Error.DuplicateUsername", result.ErrorKey);
        }

        [TestMethod]
        public void Register_ShouldReturnFailure_WhenEmailExists()
        {
            var playerDTO = new PlayerDTO { Username = "FerRMZ", Email = "ferram@gmail.com", Password = "Fer20HVZRA6" };

            _validationAccountServiceMock.Setup(v => v.ValidateUsername(playerDTO.Username)).Returns((string)null);
            _validationAccountServiceMock.Setup(v => v.ValidateEmail(playerDTO.Email)).Returns((string)null);
            _validationAccountServiceMock.Setup(v => v.ValidatePassword(playerDTO.Password)).Returns((string)null);
            _validationAccountServiceMock.Setup(v => v.ValidatePlayerExistsByEmail(It.IsAny<IPlayerRepository>(), playerDTO.Email)).Returns("Error.DuplicateEmail");

            var result = _accountService.Register(playerDTO);

            Assert.AreEqual("Error.DuplicateEmail", result.ErrorKey);
        }

        [TestMethod]
        public void Register_ShouldReturnSuccess_WhenValidPlayer()
        {
            var playerDTO = new PlayerDTO { Username = "Fer2011", Email = "Fer2011@gmail.com", Password = "Fer112620HVZRA6" };

            _validationAccountServiceMock.Setup(v => v.ValidateUsername(playerDTO.Username)).Returns((string)null);
            _validationAccountServiceMock.Setup(v => v.ValidateEmail(playerDTO.Email)).Returns((string)null);
            _validationAccountServiceMock.Setup(v => v.ValidatePassword(playerDTO.Password)).Returns((string)null);
            _validationAccountServiceMock.Setup(v => v.ValidatePlayerExistsByUsername(It.IsAny<IPlayerRepository>(), playerDTO.Username)).Returns((string)null);  // No error
            _validationAccountServiceMock.Setup(v => v.ValidatePlayerExistsByEmail(It.IsAny<IPlayerRepository>(), playerDTO.Email)).Returns((string)null);  // No error

            _playerRepositoryMock.Setup(r => r.GetByUsername(It.IsAny<string>())).Returns((Player)null);
            _playerRepositoryMock.Setup(r => r.GetByEmail(It.IsAny<string>())).Returns((Player)null);

            var result = _accountService.Register(playerDTO);

            Assert.IsTrue(result.IsSuccess);
        }

        [TestMethod]
        public void Register_ShouldReturnFailure_WhenUsernameIsEmpty()
        {
            var playerDTO = new PlayerDTO { Username = "", Email = "ferram@gmail.com", Password = "Fer20HVZRA6" };

            _validationAccountServiceMock.Setup(v => v.ValidateUsername(playerDTO.Username)).Returns("Error.InvalidUsername");

            var result = _accountService.Register(playerDTO);

            Assert.AreEqual("Error.InvalidUsername", result.ErrorKey);
        }

        [TestMethod]
        public void Register_ShouldReturnFailure_WhenEmailIsInvalid()
        {
            var playerDTO = new PlayerDTO { Username = "FerRMZ", Email = "", Password = "Fer20HVZRA6" };

            _validationAccountServiceMock.Setup(v => v.ValidateEmail(playerDTO.Email)).Returns("Error.InvalidEmail");

            var result = _accountService.Register(playerDTO);

            Assert.AreEqual("Error.InvalidEmail", result.ErrorKey);
        }

        [TestMethod]
        public void Register_ShouldReturnFailure_WhenPasswordIsEmpty()
        {
            var playerDTO = new PlayerDTO { Username = "FerRMZ", Email = "ferram@gmail.com", Password = "" };

            _validationAccountServiceMock.Setup(v => v.ValidatePassword(playerDTO.Password)).Returns("Error.InvalidPassword");

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
            _validationAccountServiceMock.Setup(v => v.ValidateUsername(username)).Returns("Error.InvalidUsername");


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

        [TestMethod]
        public void Login_ShouldReturnFailure_WhenUserAlreadyConnected()
        {
            _connectionManager.RegisterUser("FerRMZ", Mock.Of<IContextChannel>());

            var username = "FerRMZ";
            var password = "12345";
            _playerRepositoryMock.Setup(r => r.GetByUsername(It.IsAny<string>())).Returns(new Player
            {
                Username = username,
                PasswordHash = PasswordHelper.HashPassword(password)
            });

            var result = _accountService.Login(username, password);

            Assert.AreEqual("Error.UserAlreadyConnected", result.ErrorKey);
        }

        [TestMethod]
        public void Logout_ShouldReturnSuccess_WhenUserIsRegistered()
        {
            var username = "FerRMZ";
            _connectionManager.RegisterUser(username, Mock.Of<IContextChannel>());

            var result = _accountService.Logout(username);

            Assert.IsTrue(result.IsSuccess);
        }

        [TestMethod]
        public void Logout_ShouldReturnFailure_WhenUserIsNotRegistered()
        {
            var username = "Marla";

            var result = _accountService.Logout(username);

            Assert.AreEqual("Error.UserNotConnected", result.ErrorKey);
        }
    }
}
