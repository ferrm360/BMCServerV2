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

namespace Service.Test.Services.Implements
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
            // Crear mocks para las dependencias
            _mockPlayerRepository = new Mock<IPlayerRepository>();
            _mockConnectionManager = new Mock<ConnectionManager>();
            _mockConnectionEventHandler = new Mock<ConnectionEventHandler>();

            // Crear el servicio con las dependencias mockeadas
            _guestPlayerService = new GuestPlayerService(
                _mockPlayerRepository.Object,
                _mockConnectionManager.Object,
                _mockConnectionEventHandler.Object
            );
        }

        [TestMethod]
        public void RegisterGuestPlayer_InvalidUsername_ReturnsFailure()
        {
            // Arrange
            var invalidUsername = "   "; // Nombre de usuario inválido

            // Act
            var result = _guestPlayerService.RegisterGuestPlayer(invalidUsername);

            // Assert
            Assert.IsFalse(result.IsSuccess);
            Assert.AreEqual(ErrorMessages.InvalidUsername, result.ErrorKey);
        }

        [TestMethod]
        public void RegisterGuestPlayer_UserAlreadyConnected_ReturnsFailure()
        {
            // Arrange
            var username = "guest1";
            _mockConnectionManager.Setup(cm => cm.IsUserRegistered(username)).Returns(true);

            // Act
            var result = _guestPlayerService.RegisterGuestPlayer(username);

            // Assert
            Assert.IsFalse(result.IsSuccess);
            Assert.AreEqual(ErrorMessages.UserAlreadyConnected, result.ErrorKey);
        }

        [TestMethod]
        public void RegisterGuestPlayer_DuplicateUsername_ReturnsFailure()
        {
            // Arrange
            var username = "guest1";
            _mockConnectionManager.Setup(cm => cm.IsUserRegistered(username)).Returns(false);
            _mockPlayerRepository.Setup(repo => repo.GetByUsername(username)).Returns(new Player()); 

            // Act
            var result = _guestPlayerService.RegisterGuestPlayer(username);

            // Assert
            Assert.IsFalse(result.IsSuccess);
            Assert.AreEqual(ErrorMessages.DuplicateUsername, result.ErrorKey);
        }

        [TestMethod]
        public void RegisterGuestPlayer_Success_ReturnsSuccess()
        {
            // Arrange
            var username = "guest1";
            _mockConnectionManager.Setup(cm => cm.IsUserRegistered(username)).Returns(false);
            _mockPlayerRepository.Setup(repo => repo.GetByUsername(username)).Returns((Player)null);
            _mockConnectionManager.Setup(cm => cm.RegisterUser(username, It.IsAny<IContextChannel>())).Returns(true);

            // Act
            var result = _guestPlayerService.RegisterGuestPlayer(username);

            // Assert
            Assert.IsTrue(result.IsSuccess);
        }

        [TestMethod]
        public void LogoutGuestPlayer_InvalidUsername_ReturnsFailure()
        {
            // Arrange
            var invalidUsername = "   "; // Nombre de usuario inválido

            // Act
            var result = _guestPlayerService.LogoutGuestPlayer(invalidUsername);

            // Assert
            Assert.IsFalse(result.IsSuccess);
            Assert.AreEqual(ErrorMessages.InvalidUsername, result.ErrorKey);
        }

        [TestMethod]
        public void LogoutGuestPlayer_UserNotConnected_ReturnsFailure()
        {
            // Arrange
            var username = "guest1";
            _mockConnectionManager.Setup(cm => cm.IsUserRegistered(username)).Returns(false); // Usuario no conectado

            // Act
            var result = _guestPlayerService.LogoutGuestPlayer(username);

            // Assert
            Assert.IsFalse(result.IsSuccess);
            Assert.AreEqual(ErrorMessages.UserNotConnected, result.ErrorKey);
        }

        [TestMethod]
        public void LogoutGuestPlayer_Success_ReturnsSuccess()
        {
            var username = "guest1";
            _mockConnectionManager.Setup(cm => cm.IsUserRegistered(username)).Returns(true);

            var result = _guestPlayerService.LogoutGuestPlayer(username);

            Assert.IsTrue(result.IsSuccess);
        }

        [TestMethod]
        public void LogoutGuestPlayer_Exception_ReturnsFailure()
        {
            var username = "guest1";
            _mockConnectionManager.Setup(cm => cm.IsUserRegistered(username)).Returns(true);
            _mockConnectionEventHandler.Setup(handler => handler.HandleDisconnection(username)).Throws(new Exception("Unexpected error"));

            var result = _guestPlayerService.LogoutGuestPlayer(username);

            Assert.IsFalse(result.IsSuccess);
            Assert.AreEqual(ErrorMessages.GeneralException, result.ErrorKey);
        }
    }
}
