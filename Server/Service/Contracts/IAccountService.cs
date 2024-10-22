using System.ServiceModel;
using Service.DTO;
using Service.Results;

namespace Service.Contracts
{
    [ServiceContract]
    public interface IAccountService
    {
        [OperationContract]
        OperationResult Register(PlayerDTO player);
        [OperationContract]
        OperationResult Login(string username, string password);
    }
}
