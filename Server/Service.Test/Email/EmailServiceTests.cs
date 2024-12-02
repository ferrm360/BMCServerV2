using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using Service.Email;
using System.Net.Mail;

namespace Service.Test.Email
{
    // TODO ver porque no jala
    [TestClass]
    public class EmailServiceTests
    {
        private Mock<SmtpClient> _smtpClientMock;
        private EmailService _emailService;

        [TestInitialize]
        public void Setup()
        {
            _smtpClientMock = new Mock<SmtpClient>();
            _emailService = new EmailService(_smtpClientMock.Object, "ferram200011@gmail.com");
        }

        [TestMethod]
        public void Send_ShouldSendEmail_WithCorrectParameters()
        {
            _smtpClientMock.Setup(client => client.Send(It.IsAny<MailMessage>())).Verifiable();

            _emailService.Send("test@example.com", "Test Subject", "Test Body");

            _smtpClientMock.Verify(client => client.Send(It.Is<MailMessage>(msg =>
                msg.To[0].Address == "test@example.com" &&
                msg.Subject == "Test Subject" &&
                msg.Body == "Test Body"
            )), Times.Once);
        }
    }
}
