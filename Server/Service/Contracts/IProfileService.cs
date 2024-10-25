using Service.DTO;
using Service.Results;
using Service.Utilities.Results;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

namespace Service.Contracts
{
    [ServiceContract]
    public interface IProfileService
    {
        [OperationContract]
        OperationResponse UpdatePassword(string username, string newPassword, string oldPassword);
        [OperationContract]
        OperationResponse UpdateProfilePicture(string username, byte[] imageBytes, string fileName);
        [OperationContract]
        OperationResponse UpdateUsername(string currentUsername, string newUsername);
        [OperationContract]
        OperationResponse UpdateBio(string bio, string username);
        [OperationContract]
        ProfileResponse GetProfileByUsername(string username);
        [OperationContract]
        ImageResponse GetProfileImage(string username);
    }
}
