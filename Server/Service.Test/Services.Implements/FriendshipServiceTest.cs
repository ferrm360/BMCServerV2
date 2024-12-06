using DataAccess.Repositories;
using DataAccess;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Service.Implements;
using Service.Results;
using Service.Utilities.Validators;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Service.Utilities.Validators.FriendshipService;
using Service.Utilities.Constans;

namespace Service.Test.Services.Implements
{
    [TestClass]
    public class FriendshipServiceTest
    {
        private Mock<IPlayerRepository> _mockPlayerRepository;
        private Mock<IFriendRequestRepository> _mockFriendRequestRepository;
        private Mock<IValidationFriendshipService> _mockValidationService;
        private Mock<IProfileRepository> _mockProfileRepository;
        private FriendshipService _friendshipService;

        [TestInitialize]
        public void Setup()
        {
            _mockPlayerRepository = new Mock<IPlayerRepository>();
            _mockFriendRequestRepository = new Mock<IFriendRequestRepository>();
            _mockValidationService = new Mock<IValidationFriendshipService>();
            _mockProfileRepository = new Mock<IProfileRepository>();

            _mockValidationService.Setup(v => v.ValidateUserExists(It.IsAny<string>())).Returns(OperationResponse.SuccessResult());
            _mockValidationService.Setup(v => v.ValidateFriendRequestDoesNotExist(It.IsAny<int>(), It.IsAny<int>())).Returns(OperationResponse.SuccessResult());

            _friendshipService = new FriendshipService(
                _mockPlayerRepository.Object,
                _mockFriendRequestRepository.Object,
                _mockValidationService.Object,
                _mockProfileRepository.Object
            );
        }

        [TestMethod]
        public void SendFriendRequest_ShouldReturnFailure_WhenSenderDoesNotExist()
        {
            string senderUsername = "sender";
            string receiverUsername = "receiver";

            _mockValidationService.Setup(v => v.ValidateUserExists(senderUsername)).Returns(OperationResponse.Failure("Sender not found"));

            var result = _friendshipService.SendFriendRequest(senderUsername, receiverUsername);

            Assert.IsFalse(result.IsSuccess);
            Assert.AreEqual("Sender not found", result.ErrorKey);
        }

        [TestMethod]
        public void SendFriendRequest_ShouldReturnFailure_WhenReceiverDoesNotExist()
        {
            string senderUsername = "sender";
            string receiverUsername = "receiver";

            _mockValidationService.Setup(v => v.ValidateUserExists(receiverUsername)).Returns(OperationResponse.Failure("Receiver not found"));

            var result = _friendshipService.SendFriendRequest(senderUsername, receiverUsername);

            Assert.IsFalse(result.IsSuccess);
        }

        [TestMethod]
        public void SendFriendRequest_ShouldReturnFailure_WhenRequestAlreadyExists()
        {
            string senderUsername = "sender";
            string receiverUsername = "receiver";

            _mockValidationService.Setup(v => v.ValidateFriendRequestDoesNotExist(It.IsAny<int>(), It.IsAny<int>())).Returns(OperationResponse.Failure("Friend request already exists"));

            var result = _friendshipService.SendFriendRequest(senderUsername, receiverUsername);

       
            Assert.AreEqual(ErrorMessages.InvalidUsername, result.ErrorKey);
        }

        [TestMethod]
        public void SendFriendRequest_ShouldReturnSuccess_WhenRequestIsSent()
        {
            string senderUsername = "sender";
            string receiverUsername = "receiver";

            var sender = new Player { PlayerID = 1, Username = senderUsername };
            var receiver = new Player { PlayerID = 2, Username = receiverUsername };
            _mockPlayerRepository.Setup(r => r.GetByUsername(senderUsername)).Returns(sender);
            _mockPlayerRepository.Setup(r => r.GetByUsername(receiverUsername)).Returns(receiver);

            _mockFriendRequestRepository.Setup(r => r.SendFriendRequest(sender.PlayerID, receiver.PlayerID));

            var result = _friendshipService.SendFriendRequest(senderUsername, receiverUsername);

            Assert.IsTrue(result.IsSuccess);
        }
    }
}
