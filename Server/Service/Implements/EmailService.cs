using DataAccess.Repositories;
using Service.DTO;
using Service.Email;
using Service.Email.Templates;
using Service.Results;
using Service.Utilities;
using System;
using System.Net.Mail;

namespace Service.Implements
{
    /// <summary>
    /// Service responsible for sending emails to users.
    /// </summary>
    public class EmailService : Contracts.IEmailService
    {
        private readonly IPlayerRepository _playerRepository;
        private readonly ITemplateFactory _templateFactory;

        /// <summary>
        /// Initializes a new instance of the <see cref="EmailService"/> class.
        /// </summary>
        /// <param name="playerRepository">Repository to manage player data.</param>
        /// <param name="templateFactory">Factory to generate email templates.</param>
        public EmailService(IPlayerRepository playerRepository, ITemplateFactory templateFactory)
        {
            _playerRepository = playerRepository;
            _templateFactory = templateFactory;
        }

        /// <summary>
        /// Sends an email to the specified recipient using a predefined template.
        /// </summary>
        /// <param name="emailDTO">The email data transfer object containing recipient, email type, and other data.</param>
        /// <returns>
        /// An <see cref="OperationResponse"/> indicating the success or failure of the operation.
        /// </returns>
        public OperationResponse SendEmail(EmailDTO emailDTO)
        {
            try
            {

                var emailService = EmailServiceFactory.CreateEmailService();
                var (subject, body) = _templateFactory.GetTemplate(emailDTO);

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
            catch (FormatException ex)
            {
                CustomLogger.Warn($"Invalid email format: {ex.Message}");
                return OperationResponse.Failure("Invalid email format.");
            }
            catch (SmtpFailedRecipientException ex)
            {
                CustomLogger.Error($"Failed to send email to recipient: {ex.FailedRecipient}. Error: {ex.Message}");
                return OperationResponse.Failure($"Failed to send email to {ex.FailedRecipient}.");
            }
            catch (SmtpException ex)
            {
                CustomLogger.Error($"SMTP error: {ex.Message}");
                return OperationResponse.Failure("SMTP error while sending email.");
            }
            catch (Exception ex)
            {
                CustomLogger.Fatal("Unexpected error during SendEmail", ex);
                return OperationResponse.Failure($"Unexpected error while sending email: {ex.Message}");
            }
        }
    }
}
