using Service.DTO;
using Service.Results;
using System.ServiceModel;


namespace Service.Contracts
{
    [ServiceContract]
    public interface IEmailService
    {
        [OperationContract]
        OperationResponse SendEmail(EmailDTO emailDTO);
    }
}
