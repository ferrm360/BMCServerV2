using DataAccess;
using DataAccess.Repositories;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Service.Connection.Managers;
using Service.Implements;
using Service.Utilities.Constans;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

namespace ServiceTest.Services.Implements
{
    [TestClass]
    public class GuestPlayerServiceTest
    {
        private Mock<IPlayerRepository> _mockPlayerRepository;
        private Mock<ConnectionManager> _mockConnectionManager;
        private Mock<ConnectionEventHandler> _mockConnectionEventHandler;
        private GuestPlayerService _guestPlayerService;

        [TestInitialize]
        public void Setup()
        {
            _mockPlayerRepository = new Mock<IPlayerRepository>();
            _mockConnectionManager = new Mock<ConnectionManager>();
            _mockConnectionEventHandler = new Mock<ConnectionEventHandler>();

            _guestPlayerService = new GuestPlayerService(
                _mockPlayerRepository.Object,
                _mockConnectionManager.Object,
                _mockConnectionEventHandler.Object
            );
        }

        [TestMethod]
        public void RegisterGuestPlayer_ShouldReturnFailure_WhenUsernameIsNullOrEmpty()
        {
            var result = _guestPlayerService.RegisterGuestPlayer("");
            Assert.IsFalse(result.IsSuccess);
            Assert.AreEqual(ErrorMessages.InvalidUsername, result.ErrorKey);
        }

        [TestMethod]
        public void RegisterGuestPlayer_ShouldReturnFailure_WhenUserAlreadyConnected()
        {
            var username = "existingUsername";
            _mockConnectionManager.Setup(m => m.IsUserRegistered(username)).Returns(true);

            var result = _guestPlayerService.RegisterGuestPlayer(username);

            Assert.IsFalse(result.IsSuccess);
            Assert.AreEqual(ErrorMessages.UserAlreadyConnected, result.ErrorKey);
        }

        [TestMethod]
        public void RegisterGuestPlayer_ShouldReturnFailure_WhenUsernameAlreadyExistsInDatabase()
        {
            var username = "existingUsername";
            _mockConnectionManager.Setup(m => m.IsUserRegistered(username)).Returns(false);
            _mockPlayerRepository.Setup(p => p.GetByUsername(username)).Returns(new Player());

            var result = _guestPlayerService.RegisterGuestPlayer(username);

            Assert.IsFalse(result.IsSuccess);
            Assert.AreEqual(ErrorMessages.DuplicateUsername, result.ErrorKey);
        }

        [TestMethod]
        public void RegisterGuestPlayer_ShouldReturnFailure_WhenRegisterUserFails()
        {
            var username = "newUser";
            _mockConnectionManager.Setup(m => m.IsUserRegistered(username)).Returns(false);
            _mockPlayerRepository.Setup(p => p.GetByUsername(username)).Returns((Player)null);
            _mockConnectionManager.Setup(m => m.RegisterUser(username, It.IsAny<IContextChannel>())).Returns(false);

            var result = _guestPlayerService.RegisterGuestPlayer(username);

            Assert.IsFalse(result.IsSuccess);
            Assert.AreEqual(ErrorMessages.UserAlreadyConnected, result.ErrorKey);
        }

        [TestMethod]
        public void RegisterGuestPlayer_ShouldReturnSuccess_WhenUserIsRegisteredSuccessfully()
        {
            var username = "newUser";
            _mockConnectionManager.Setup(m => m.IsUserRegistered(username)).Returns(false);
            _mockPlayerRepository.Setup(p => p.GetByUsername(username)).Returns((Player)null);
            _mockConnectionManager.Setup(m => m.RegisterUser(username, It.IsAny<IContextChannel>())).Returns(true);

            var result = _guestPlayerService.RegisterGuestPlayer(username);

            Assert.IsTrue(result.IsSuccess);
        }

        [TestMethod]
        public void LogoutGuestPlayer_ShouldReturnFailure_WhenUsernameIsNullOrEmpty()
        {
            var result = _guestPlayerService.LogoutGuestPlayer("");
            Assert.IsFalse(result.IsSuccess);
            Assert.AreEqual(ErrorMessages.InvalidUsername, result.ErrorKey);
        }

        [TestMethod]
        public void LogoutGuestPlayer_ShouldReturnFailure_WhenUserNotConnected()
        {
            var username = "notConnectedUser";
            _mockConnectionManager.Setup(m => m.IsUserRegistered(username)).Returns(false);

            var result = _guestPlayerService.LogoutGuestPlayer(username);

            Assert.IsFalse(result.IsSuccess);
            Assert.AreEqual(ErrorMessages.UserNotConnected, result.ErrorKey);
        }

        [TestMethod]
        public void LogoutGuestPlayer_ShouldReturnSuccess_WhenUserLoggedOutSuccessfully()
        {
            var username = "connectedUser";
            _mockConnectionManager.Setup(m => m.IsUserRegistered(username)).Returns(true);

            var result = _guestPlayerService.LogoutGuestPlayer(username);

            Assert.IsTrue(result.IsSuccess);
        }

        [TestMethod]
        public void LogoutGuestPlayer_ShouldReturnFailure_WhenUnexpectedErrorOccurs()
        {
            var username = "anyUser";
            _mockConnectionManager.Setup(m => m.IsUserRegistered(username)).Returns(true);
            _mockConnectionEventHandler.Setup(m => m.HandleDisconnection(username)).Throws(new Exception());

            var result = _guestPlayerService.LogoutGuestPlayer(username);

            Assert.IsFalse(result.IsSuccess);
            Assert.AreEqual(ErrorMessages.GeneralException, result.ErrorKey);
        }
    }
}
