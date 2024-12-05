using System;
using System.Configuration;
using System.Net;
using System.Net.Mail;

namespace Service.Email
{
    public static class EmailConfigHelper
    {
        private static Configuration GetEmailSettingsConfiguration()
        {
            try
            {
                // Usar el archivo de configuración por defecto
                return ConfigurationManager.OpenExeConfiguration(ConfigurationUserLevel.None);
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error al cargar el archivo de configuración de correo.", ex);
            }
        }

        public static string GetFromAddress()
        {
            try
            {
                var emailConfig = GetEmailSettingsConfiguration();
                string fromAddress = emailConfig.AppSettings.Settings["EmailFromAddress"]?.Value;

                if (string.IsNullOrEmpty(fromAddress))
                {
                    throw new InvalidOperationException("La dirección 'EmailFromAddress' no está configurada en el archivo de configuración.");
                }

                return fromAddress;
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error al obtener la dirección 'EmailFromAddress' desde la configuración.", ex);
            }
        }

        public static SmtpClient GetSmtpClient()
        {
            try
            {
                var emailConfig = GetEmailSettingsConfiguration();

                string smtpHost = emailConfig.AppSettings.Settings["SmtpHost"]?.Value;
                string smtpPortString = emailConfig.AppSettings.Settings["SmtpPort"]?.Value;
                string smtpUsername = emailConfig.AppSettings.Settings["SmtpUsername"]?.Value;
                string smtpPassword = emailConfig.AppSettings.Settings["SmtpPassword"]?.Value;
                bool enableSsl = bool.Parse(emailConfig.AppSettings.Settings["EnableSsl"]?.Value ?? "true");

                if (string.IsNullOrEmpty(smtpHost) || string.IsNullOrEmpty(smtpUsername) || string.IsNullOrEmpty(smtpPassword))
                {
                    throw new InvalidOperationException("Faltan configuraciones importantes para el cliente SMTP.");
                }

                int smtpPort = string.IsNullOrEmpty(smtpPortString) ? 587 : int.Parse(smtpPortString);

                var smtpClient = new SmtpClient(smtpHost)
                {
                    Port = smtpPort,
                    Credentials = new NetworkCredential(smtpUsername, smtpPassword),
                    EnableSsl = enableSsl
                };

                return smtpClient;
            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error al configurar el cliente SMTP desde la configuración.", ex);
            }
        }
    }
}
