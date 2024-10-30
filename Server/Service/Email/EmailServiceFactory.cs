namespace Service.Email
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
