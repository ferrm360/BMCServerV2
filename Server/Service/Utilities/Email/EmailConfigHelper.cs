using System.Configuration;
using System.Net.Mail;
using System.Net;

namespace Service.Utilities.Email
{
    public static class EmailConfigHelper
    {
        public static string GetFromAddress()
        {
            return ConfigurationManager.AppSettings["EmailFromAddress"];
        }

        public static SmtpClient GetSmtpClient()
        {
            var smtpClient = new SmtpClient
            {
                Host = ConfigurationManager.AppSettings["SmtpHost"],
                Port = int.Parse(ConfigurationManager.AppSettings["SmtpPort"]),
                EnableSsl = bool.Parse(ConfigurationManager.AppSettings["EnableSsl"]),
                Credentials = new NetworkCredential(
                    ConfigurationManager.AppSettings["SmtpUsername"],
                    ConfigurationManager.AppSettings["SmtpPassword"]
                )
            };

            return smtpClient;
        }
    }
}
