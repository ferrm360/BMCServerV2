using DataAccess;
using DataAccess.Repositories;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Service.Connection.Managers;
using Service.Implements;
using Service.Utilities.Constans;
using ServiceTest.GuestPlayerService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

namespace ServiceTest.Implements
{
    [TestClass]
    public class GuestPlayerServiceTests
    {
        private Service.Implements.GuestPlayerService _guestPlayerService;
        private IPlayerRepository _playerRepository;
        private ConnectionManager _connectionManager;
        private ConnectionEventHandler _connectionEventHandler;
        private readonly BMCEntities _context;


        [TestInitialize]
        public void Setup()
        {
            _playerRepository = new PlayerRepository(_context);
            _connectionManager = new ConnectionManager();
            _connectionEventHandler = new ConnectionEventHandler(_connectionManager);

            _guestPlayerService = new Service.Implements.GuestPlayerService(_playerRepository, _connectionManager, _connectionEventHandler);
        }

        [TestMethod]
        public void TestRegisterGuestPlayer_Success()
        {
            var response = _guestPlayerService.RegisterGuestPlayer("testPlayer");

            Assert.IsTrue(!response.IsSuccess);
        }
    }
}
