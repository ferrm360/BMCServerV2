namespace Service.Utilities.Email
{
    public interface IEmailService
    {
        void Send(string toAddress, string subject, string body);
    }
}
