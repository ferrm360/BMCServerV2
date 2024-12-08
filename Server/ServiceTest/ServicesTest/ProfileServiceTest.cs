using DataAccess.Repositories;
using DataAccess;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Service.Implements;
using Service.Utilities.Constans;
using Service.Utilities.Helpers;

namespace ServiceTest.Implements
{
    [TestClass]
    public class ProfileServiceTests
    {
        private Mock<IPlayerRepository> _playerRepositoryMock;
        private Mock<IProfileRepository> _profileRepositoryMock;
        private ProfileService _profileService;

        [TestInitialize]
        public void Setup()
        {
            _playerRepositoryMock = new Mock<IPlayerRepository>();
            _profileRepositoryMock = new Mock<IProfileRepository>();

            _profileService = new ProfileService(
                _playerRepositoryMock.Object,
                _profileRepositoryMock.Object
            );
        }

        [TestMethod]
        public void UpdateUsername_ShouldReturnSuccess_WhenNewUsernameIsAvailable()
        {
            var currentUsername = "FerRMZ";
            var newUsername = "MarlaRobloxGamer777";
            var player = new Player { Username = currentUsername , PlayerID = 1};

            _playerRepositoryMock.Setup(r => r.GetByUsername(currentUsername)).Returns(player);
            _playerRepositoryMock.Setup(r => r.GetByUsername(newUsername)).Returns((Player)null);

            var result = _profileService.UpdateUsername(currentUsername, newUsername);

            Assert.IsTrue(result.IsSuccess);
        }

        [TestMethod]
        public void UpdateUsername_ShouldReturnFailure_WhenNewUsernameAlreadyExists()
        {
            var currentUsername = "FerRMZ";
            var newUsername = "neco2000";
            var existingPlayer = new Player { Username = newUsername };

            _playerRepositoryMock.Setup(r => r.GetByUsername(newUsername)).Returns(existingPlayer);

            var result = _profileService.UpdateUsername(currentUsername, newUsername);

            Assert.AreEqual(ErrorMessages.DuplicateUsername, result.ErrorKey);
        }

        [TestMethod]
        public void UpdatePassword_ShouldReturnFailure_WhenOldPasswordIsIncorrect()
        {
            var username = "FerRMZ";
            var oldPassword = "ferHVZRA62011";
            var newPassword = "MARF0011HV";
            var player = new Player { Username = username, PasswordHash = PasswordHelper.HashPassword("ferHVZRA6200011") };

            _playerRepositoryMock.Setup(r => r.GetByUsername(It.IsAny<string>())).Returns(player);

            var result = _profileService.UpdatePassword(username, newPassword, oldPassword);

            Assert.AreEqual(ErrorMessages.DifferentPassword, result.ErrorKey);
        }

        [TestMethod]
        public void UpdatePassword_ShouldReturnSuccess_WhenOldPasswordIsCorrect()
        {
            var username = "FerRMZ";
            var oldPassword = "ferHVZRA6200011";
            var newPassword = "MARF0011HV";
            var player = new Player { Username = username, PasswordHash = PasswordHelper.HashPassword("ferHVZRA6200011") };

            _playerRepositoryMock.Setup(r => r.GetByUsername(It.IsAny<string>())).Returns(player);

            var result = _profileService.UpdatePassword(username, newPassword, oldPassword);

            Assert.IsTrue(result.IsSuccess);
        }

        [TestMethod]
        public void UpdateProfilePicture_ShouldReturnFailure_WhenUserNotFound()
        {
            var username = "FerR20";
            var imageBytes = new byte[] { 1, 2, 3 };
            var fileName = "image.png";

            _playerRepositoryMock.Setup(r => r.GetByUsername(It.IsAny<string>())).Returns((Player)null);

            var result = _profileService.UpdateProfilePicture(username, imageBytes, fileName);

            Assert.AreEqual(ErrorMessages.UserNotFound, result.ErrorKey);
        }

        [TestMethod]
        public void UpdateProfilePicture_ShouldReturnSuccess_WhenUserAndProfileExist()
        {
            var username = "FerEMZ";
            var imageBytes = new byte[] { 1, 2, 3 };
            var fileName = "profileImage.png";
            var player = new Player { Username = username, PlayerID = 1 };
            var profile = new Profile { PlayerID = 1 };

            _playerRepositoryMock.Setup(r => r.GetByUsername(It.IsAny<string>())).Returns(player);
            _profileRepositoryMock.Setup(r => r.GetProfileByPlayerId(It.IsAny<int>())).Returns(profile);

            var result = _profileService.UpdateProfilePicture(username, imageBytes, fileName);

            Assert.IsTrue(result.IsSuccess);
        }


        [TestMethod]
        public void GetProfileByUsername_ShouldReturnFailure_WhenUserNotFound()
        {
            var username = "MarlaRoblox";

            _playerRepositoryMock.Setup(r => r.GetByUsername(It.IsAny<string>())).Returns((Player)null);

            var result = _profileService.GetProfileByUsername(username);

            Assert.AreEqual(ErrorMessages.UserNotFound, result.ErrorKey);
        }

        [TestMethod]
        public void GetProfileImage_ShouldReturnFailure_WhenImageNotFound()
        {
            var username = "FerRMZ";
            var player = new Player { Username = username, PlayerID = 1 };
            var profile = new Profile { PlayerID = 1, AvatarURL = "nonexistentFile.jpg" };

            _playerRepositoryMock.Setup(r => r.GetByUsername(It.IsAny<string>())).Returns(player);
            _profileRepositoryMock.Setup(r => r.GetProfileByPlayerId(It.IsAny<int>())).Returns(profile);

            var result = _profileService.GetProfileImage(username);

            Assert.AreEqual(ErrorMessages.ImageNotFound, result.ErrorKey);
        }
    }
}
