using System.Configuration;
using System.Net.Mail;
using System.Net;

namespace Service.Email
{
    public static class EmailConfigHelper
    {
        private static Configuration GetEmailSettingsConfiguration()
        {
            var configMap = new ExeConfigurationFileMap
            {
                ExeConfigFilename = @"emailSettings.config"
            };
            return ConfigurationManager.OpenMappedExeConfiguration(configMap, ConfigurationUserLevel.None);
        }

        public static string GetFromAddress()
        {
            var emailConfig = GetEmailSettingsConfiguration();
            return emailConfig.AppSettings.Settings["EmailFromAddress"]?.Value;
        }


        public static SmtpClient GetSmtpClient()
        {
            var emailConfig = GetEmailSettingsConfiguration();

            var smtpClient = new SmtpClient
            {
                Host = emailConfig.AppSettings.Settings["SmtpHost"]?.Value,
                Port = int.Parse(emailConfig.AppSettings.Settings["SmtpPort"]?.Value ?? "25"),
                EnableSsl = bool.Parse(emailConfig.AppSettings.Settings["EnableSsl"]?.Value ?? "false"),
                Credentials = new NetworkCredential(
                    emailConfig.AppSettings.Settings["SmtpUsername"]?.Value,
                    emailConfig.AppSettings.Settings["SmtpPassword"]?.Value
                )
            };
            return smtpClient;
        }
    }
}
