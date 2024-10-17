using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service.Utilities.Email
{
    public static class EmailServiceFactory
    {
        public static IEmailService CreateEmailService()
        {
            var smtpClient = EmailConfigHelper.GetSmtpClient();
            var fromAddress = EmailConfigHelper.GetFromAddress();

            return new EmailService(smtpClient, fromAddress);
        }
    }
}
