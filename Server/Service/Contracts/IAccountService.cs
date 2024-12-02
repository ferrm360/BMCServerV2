using System.ServiceModel;
using Service.DTO;
using Service.Results;

namespace Service.Contracts
{
    [ServiceContract]
    public interface IAccountService
    {
        [OperationContract]
        OperationResponse Register(PlayerDTO player);
        [OperationContract]
        OperationResponse Login(string username, string password);
        [OperationContract]
        OperationResponse Logout(string username); 
     }
}
