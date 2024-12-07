using System.ServiceModel;
using Service.DTO;
using Service.Results;
using Service.Utilities.Results;

namespace Service.Contracts
{
    [ServiceContract]
    public interface IAccountService
    {
        [OperationContract]
        OperationResponse Register(PlayerDTO player);
        [OperationContract]
        LoginResponse Login(string username, string password);
        [OperationContract]
        OperationResponse Logout(string username); 
     }
}
