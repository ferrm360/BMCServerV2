namespace Service.Email
{
    public interface IEmailService
    {
        void Send(string toAddress, string subject, string body);
    }
}
