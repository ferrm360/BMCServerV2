using System.ServiceModel;
using Service.DTO;
using Service.Results;

namespace Service.Contracts
{
    [ServiceContract]
    public interface IAccountService
    {
        [OperationContract]
        OperationResult<object> Register(PlayerDTO player);

        [OperationContract]
        OperationResult<PlayerDTO> Login(string username, string password);

    
    }
}
