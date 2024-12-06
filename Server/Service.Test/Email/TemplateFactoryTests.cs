using DataAccess.Repositories;
using DataAccess;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Service.DTO;
using Service.Email.Templates;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service.Test.Email
{
    [TestClass]
    public class TemplateFactoryTests
    {
        private Mock<IPlayerRepository> _mockPlayerRepository;
        private TemplateFactory _templateFactory;

        [TestInitialize]
        public void Setup()
        {
            _mockPlayerRepository = new Mock<IPlayerRepository>();

            _templateFactory = new TemplateFactory(_mockPlayerRepository.Object);
        }

        [TestMethod]
        public void GetTemplate_ChangePassword_ReturnsCorrectSubjectAndBody()
        {
            var emailDto = new EmailDTO
            {
                EmailType = "changepassword",
                Username = "FerMRZ",
                VerificationCode = "123456"
            };

            var (subject, body) = _templateFactory.GetTemplate(emailDto);

            Assert.AreEqual("BMC - Change Your Password", subject);
        }

        [TestMethod]
        public void GetTemplate_LobbyInvite_ReturnsCorrectSubjectAndBody()
        {
            var emailDto = new EmailDTO
            {
                EmailType = "lobbyinvite",
                Username = "FerRMZ"
            };

            _mockPlayerRepository.Setup(repo => repo.GetByUsername("player1")).Returns(new Player { Email = "player1@example.com" });

            var (subject, body) = _templateFactory.GetTemplate(emailDto);

            Assert.AreEqual("You’ve Been Invited to Join a Game Lobby!", subject);
        }

        [TestMethod]
        public void GetTemplate_Custom_ReturnsCustomBody()
        {
            var emailDto = new EmailDTO
            {
                EmailType = "custom",
                CustomBody = "Hola marla."
            };

            var (subject, body) = _templateFactory.GetTemplate(emailDto);

            Assert.AreEqual("Custom Message", subject);
        }

        [TestMethod]
        public void GetTemplate_UnsupportedEmailType_ThrowsException()
        {
            var emailDto = new EmailDTO
            {
                EmailType = "unsupportedtype"
            };

            Assert.ThrowsException<ArgumentException>(() =>
            {
                _templateFactory.GetTemplate(emailDto);

            });
        }

        [TestMethod]
        public void GetTemplate_PlayerNotFound_ThrowsException()
        {
            var emailDto = new EmailDTO
            {
                EmailType = "lobbyinvite",
                Username = "FerRMZ"
            };

            _mockPlayerRepository.Setup(repo => repo.GetByUsername("FerRMZ")).Returns((Player)null);

            Assert.ThrowsException<ArgumentException>(() =>
            {
                _templateFactory.GetTemplate(emailDto);

            });

        }
    }
}
