using DataAccess.Repositories;
using Service.DTO;
using Service.Email;
using Service.Email.Templates;
using Service.Results;
using System;
using System.Net.Mail;

namespace Service.Implements
{
    public class EmailService : Contracts.IEmailService
    {
        private readonly IPlayerRepository _playerRepository;

        public EmailService(IPlayerRepository playerRepository)
        {
            _playerRepository = playerRepository;
        }


        public OperationResponse SendEmail(EmailDTO emailDTO)
        {
            try
            {
                var templateFactory = new TemplateFactory(_playerRepository);

                var emailService = EmailServiceFactory.CreateEmailService();
                var (subject, body) = templateFactory.GetTemplate(emailDTO);

                var smtpClient = EmailConfigHelper.GetSmtpClient();
                var mailMessage = new MailMessage
                {
                    From = new MailAddress(EmailConfigHelper.GetFromAddress()),
                    Subject = subject,
                    Body = body,
                    IsBodyHtml = true
                };

                mailMessage.To.Add(emailDTO.Recipient);

                smtpClient.Send(mailMessage);


                return OperationResponse.SuccessResult("Email sent successfully.");
            }
            catch (Exception ex) {
                return OperationResponse.Failure($"Error while sending email: {ex.Message}");
            }
        }
    }
}
