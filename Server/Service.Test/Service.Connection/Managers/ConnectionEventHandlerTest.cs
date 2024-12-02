using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Service.Connection.Managers;
using System;
using System.ServiceModel;

namespace Service.Test.Service.Connection.Managers
{
    [TestClass]
    public class ConnectionEventHandlerTest
    {
        private ConnectionEventHandler _connectionEventHandler;
        private ConnectionManager _connectionManager;
        private Mock<IContextChannel> _mockChannel;

        [TestInitialize]
        public void Setup()
        {
            _connectionManager = new ConnectionManager();
            _connectionEventHandler = new ConnectionEventHandler (_connectionManager);
            _mockChannel = new Mock<IContextChannel>();
        }

        [TestMethod]
        public void RegisterChannelEvents_ShouldUnregisterUser_OnClosedEvent()
        {
            _connectionManager.RegisterUser("TestUser", _mockChannel.Object);
            _connectionEventHandler.RegisterChannelEvents("TestUser", _mockChannel.Object);

            _mockChannel.Raise(channel => channel.Closed += null, EventArgs.Empty);

            Assert.IsFalse(_connectionManager.IsUserRegistered("TestUser"));
        }

        [TestMethod]
        public void RegisterChannelEvents_ShouldUnregisterUser_OnFaultedEvent()
        {
            _connectionManager.RegisterUser("TestUser", _mockChannel.Object);
            _connectionEventHandler.RegisterChannelEvents("TestUser", _mockChannel.Object);

            _mockChannel.Raise(channel => channel.Faulted += null, EventArgs.Empty);

            Assert.IsFalse(_connectionManager.IsUserRegistered("TestUser"));
        }
    }
}
