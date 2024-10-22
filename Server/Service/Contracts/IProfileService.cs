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
        OperationResult UpdatePassword(string username, string newPassword, string oldPassword);
        [OperationContract]
        OperationResult UpdateProfilePicture(string username, byte[] imageBytes, string fileName);
        [OperationContract]
        OperationResult UpdateUsername(string currentUsername, string newUsername);
    }
}
