using Service.DTO;
using Service.Email;
using Service.Email.Templates;
using Service.Results;
using System;

namespace Service.Implements
{
    public class EmailService : Contracts.IEmailService
    {
        public OperationResponse SendEmail(EmailDTO emailDTO)
        {
            try
            {
                var emailService = EmailServiceFactory.CreateEmailService();
                var (subject, body) = TemplateFactory.GetTemplate(emailDTO);

                emailService.Send(emailDTO.Recipient, subject, body);

                return OperationResponse.SuccessResult("Email sent successfully.");
            }
            catch (Exception ex) {
                return OperationResponse.Failure($"Error while sending email: {ex.Message}");
            }
        }
    }
}
