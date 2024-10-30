using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Service.Connection.Managers;
using System.ServiceModel;

namespace Service.Test.Service.Connection.Managers
{
    [TestClass]
    public class ConnectionManagerTest
    {
        private ConnectionManager _connectionManager;
        private Mock<IContextChannel> _mockChannel;

        [TestInitialize]
        public void Setup()
        {
            _connectionManager = new ConnectionManager();
            _mockChannel = new Mock<IContextChannel>();
        }

        [TestMethod]
        public void RegisterUser_ShouldAddUser_WhenUserIsNotRegistered()
        {
            bool result = _connectionManager.RegisterUser("TestUser", _mockChannel.Object);
            Assert.IsTrue(result);
            Assert.IsTrue(_connectionManager.IsUserRegistered("TestUser"));
        }

        [TestMethod]
        public void RegisterUser_ShouldReturnFalse_WhenUserAlreadyRegistered()
        {
            _connectionManager.RegisterUser("TestUser", _mockChannel.Object);
            bool result = _connectionManager.RegisterUser("TestUser", _mockChannel.Object);
            Assert.IsFalse(result);
        }

        [TestMethod]
        public void UnregisterUser_ShouldRemoveUser_WhenUserIsRegistered()
        {
            _connectionManager.RegisterUser("TestUser", _mockChannel.Object);
            bool result = _connectionManager.UnregisterUser("TestUser");
            Assert.IsTrue(result);
            Assert.IsFalse(_connectionManager.IsUserRegistered("TestUser"));
        }
    }
}
