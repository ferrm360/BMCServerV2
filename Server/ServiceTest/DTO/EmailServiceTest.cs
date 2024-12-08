using DataAccess.Repositories;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Service.DTO;
using Service.Implements;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;

namespace ServiceTest.DTO
{
    [TestClass]
    public class EmailServiceTest
    {
        private Mock<IPlayerRepository> _mockPlayerRepository;
        private Mock<Service.Email.ITemplateFactory> _mockTemplateFactory;
        private Mock<SmtpClient> _mockSmtpClient;
        private EmailService _emailService;

        [TestInitialize]
        public void Setup()
        {
            _mockPlayerRepository = new Mock<IPlayerRepository>();
            _mockTemplateFactory = new Mock<Service.Email.ITemplateFactory>();
            _mockSmtpClient = new Mock<SmtpClient>();

            _emailService = new EmailService(_mockPlayerRepository.Object, _mockTemplateFactory.Object);
        }


        [TestMethod]
        public void SendEmail_EmailServiceThrowsException_ReturnsFailure()
        {
            var emailDTO = new EmailDTO
            {
                Recipient = "test@example.com",
                EmailType = "changepassword",
                Username = "user1",
                VerificationCode = "123456"
            };

            _mockTemplateFactory.Setup(factory => factory.GetTemplate(emailDTO))
                .Throws(new Exception("Template error"));

            var result = _emailService.SendEmail(emailDTO);

            Assert.AreEqual("Unexpected error while sending email: Template error", result.ErrorKey);
        }
    }
}
