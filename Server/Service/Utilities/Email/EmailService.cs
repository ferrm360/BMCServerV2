using System;
using System.Net;
using System.Net.Mail;

namespace Service.Utilities.Email
{
    public class EmailService : IEmailService
    {
        private readonly SmtpClient _smtpClient;
        private readonly string _fromAddress;

        public EmailService(SmtpClient smtpClient, string fromAddress)
        {
            _smtpClient = smtpClient;
            _fromAddress = fromAddress;
        }

        public void Send(string to, string subject, string body)
        {
            var mailMessage = new MailMessage(_fromAddress, to, subject, body);
            _smtpClient.Send(mailMessage);
        }
    }
}