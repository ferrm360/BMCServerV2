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
using Service.DTO;
using System.IO;

namespace ServiceTest.Implements
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

            _mockFriendRequestRepository.Setup(r => r.Save());

            _friendshipService = new FriendshipService(
                _mockPlayerRepository.Object,
                _mockFriendRequestRepository.Object,
                _mockValidationService.Object,
                _mockProfileRepository.Object
            );
        }


        [TestMethod]
        public void AcceptFriendRequest_ShouldReturnSuccess_WhenRequestAccepted()
        {

            var requestId = 1;
            _mockFriendRequestRepository.Setup(r => r.AcceptRequest(requestId));

            var result = _friendshipService.AcceptFriendRequest(requestId);

            Assert.IsTrue(result.IsSuccess);
        }

        [TestMethod]
        public void AcceptFriendRequest_ShouldReturnFailure_WhenExceptionOccurs()
        {
            var requestId = 1;
            _mockFriendRequestRepository.Setup(r => r.AcceptRequest(requestId)).Throws(new Exception());

            var result = _friendshipService.AcceptFriendRequest(requestId);

            Assert.AreEqual("Error.GeneralException", result.ErrorKey);
        }


        [TestMethod]
        public void GetFriendList_ShouldReturnSuccess_WhenPlayerHasFriends()
        {
            var username = "FerRMZ";
            var player = new PlayerDTO { PlayerID = 1, Username = username };
            _mockPlayerRepository.Setup(r => r.GetByUsername(username)).Returns(new Player { PlayerID = 1, Username = username });
            _mockFriendRequestRepository.Setup(r => r.GetAcceptedFriends(1)).Returns(new List<Player> { new Player { PlayerID = 2, Username = "Marla" } });

            var result = _friendshipService.GetFriendList(username);

            Assert.AreEqual(1, result.Friends.Count);
        }

        [TestMethod]
        public void GetFriendList_ShouldReturnFailure_WhenUserNotFound()
        {
            var username = "FerRMZ";
            _mockPlayerRepository.Setup(r => r.GetByUsername(username)).Returns((Player)null);

            var result = _friendshipService.GetFriendList(username);

            Assert.AreEqual("UserNotFound", result.ErrorKey);
        }


        [TestMethod]
        public void GetFriendRequestList_ShouldReturnSuccess_WhenRequestsExist()
        {
            var username = "Marla";

            _mockPlayerRepository.Setup(r => r.GetByUsername(username)).Returns(new Player { PlayerID = 1, Username = username });

            var mockRequest = new FriendRequest
            {
                RequestID = 1,
                Player = new Player { Username = "SenderUser" },
                Player1 = new Player { Username = "ReceiverUser" },
                RequestStatus = "Accepted"
            };

            _mockFriendRequestRepository.Setup(r => r.GetReceivedRequests(1)).Returns(new List<FriendRequest> { mockRequest });

            var result = _friendshipService.GetFriendRequestList(username);
        }

        [TestMethod]
        public void GetFriendRequestList_ShouldReturnFailure_WhenUserNotFound()
        {
            var username = "FerRMZ";
            _mockPlayerRepository.Setup(r => r.GetByUsername(username)).Returns((Player)null);

            var result = _friendshipService.GetFriendRequestList(username);

            Assert.IsFalse(result.IsSuccess);
            Assert.AreEqual("User not found.", result.ErrorKey);
        }


        [TestMethod]
        public void RejectFriendResponse_ShouldReturnSuccess_WhenRequestRejected()
        {
            var requestId = 1;
            _mockFriendRequestRepository.Setup(r => r.RejectRequest(requestId));

            var result = _friendshipService.RejectFriendResponse(requestId);

            Assert.IsTrue(result.IsSuccess);
        }

        [TestMethod]
        public void RejectFriendResponse_ShouldReturnFailure_WhenExceptionOccurs()
        {
            var requestId = 1;
            _mockFriendRequestRepository.Setup(r => r.RejectRequest(requestId)).Throws(new Exception());

            var result = _friendshipService.RejectFriendResponse(requestId);

            Assert.AreEqual("Error.GeneralException", result.ErrorKey);
        }


        [TestMethod]
        public void SendFriendRequest_ShouldReturnSuccess_WhenRequestIsSent()
        {
            var senderUsername = "FerRMZ";
            var receiverUsername = "Marla";


            _mockValidationService.Setup(v => v.ValidateUserExists(senderUsername)).Returns(OperationResponse.SuccessResult());
            _mockValidationService.Setup(v => v.ValidateUserExists(receiverUsername)).Returns(OperationResponse.SuccessResult());
            _mockValidationService.Setup(v => v.ValidateFriendRequestDoesNotExist(It.IsAny<int>(), It.IsAny<int>())).Returns(OperationResponse.SuccessResult());


            _mockPlayerRepository.Setup(p => p.GetByUsername(senderUsername)).Returns(new Player { PlayerID = 1, Username = senderUsername });
            _mockPlayerRepository.Setup(p => p.GetByUsername(receiverUsername)).Returns(new Player { PlayerID = 2, Username = receiverUsername });


            _mockFriendRequestRepository.Setup(r => r.SendFriendRequest(It.IsAny<int>(), It.IsAny<int>()));
            _mockFriendRequestRepository.Setup(r => r.Save());

            var result = _friendshipService.SendFriendRequest(senderUsername, receiverUsername);
            Assert.IsTrue(result.IsSuccess, $"Expected success, but got failure with error: {result.ErrorKey}");

        }

        [TestMethod]
        public void SendFriendRequest_ShouldReturnFailure_WhenSenderDoesNotExist()
        {
            var senderUsername = "FerRMZ";
            var receiverUsername = "Marla";
            _mockValidationService.Setup(v => v.ValidateUserExists(senderUsername)).Returns(OperationResponse.Failure("Sender not found"));

            var result = _friendshipService.SendFriendRequest(senderUsername, receiverUsername);

            Assert.IsFalse(result.IsSuccess);
            Assert.AreEqual("Sender not found", result.ErrorKey);
        }


        [TestMethod]
        public void GetPlayersListByUsername_ShouldReturnSuccess_WhenPlayersFound()
        {
            var playerUsername = "FerRMZ";
            var ownerUsername = "Marla";
            _mockPlayerRepository.Setup(r => r.GetByUsername(ownerUsername)).Returns(new Player { PlayerID = 1, Username = ownerUsername });
            _mockPlayerRepository.Setup(r => r.GetPlayersByUsername(playerUsername, 1)).Returns(new List<Player> { new Player { PlayerID = 2, Username = playerUsername } });

            var result = _friendshipService.GetPlayersListByUsername(playerUsername, ownerUsername);

            Assert.IsTrue(result.IsSuccess);
        }


        [TestMethod]
        public void ConvertImageUrlToBytes_ShouldReturnImageBytes_WhenFileExists()
        {
            var imageUrl = "existing-image.jpg";
            var filePath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, imageUrl);
            File.WriteAllText(filePath, "test");
            var result = _friendshipService.ConvertImageUrlToBytes(imageUrl);

             
            Assert.AreEqual(4, result.Length);
        }

        [TestMethod]
        public void ConvertImageUrlToBytes_ShouldThrowException_WhenFileNotFound()
        {
            var imageUrl = "non-existing-image.jpg";

            Assert.ThrowsException<System.IO.FileNotFoundException>(() => _friendshipService.ConvertImageUrlToBytes(imageUrl));
        }
    }
}
