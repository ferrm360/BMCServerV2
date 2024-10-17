using Service.DTO;
using Service.Results;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

namespace Service.Contracts
{
    [ServiceContract]
    internal interface IProfileService
    {
        [OperationContract]
        OperationResult<PlayerDTO> updatePassword(string username, string newPassword, string oldPassword);
        [OperationContract]
        OperationResult<PlayerDTO> updateProfilePicture(string url);
        [OperationContract]
        OperationResult<PlayerDTO> updateEmail(string email, string confirmationCode);
    }
}
