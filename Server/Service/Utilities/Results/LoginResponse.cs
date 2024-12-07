using Service.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Service.Utilities.Results
{
    [DataContract]
    public class LoginResponse
    {
        [DataMember]
        public bool IsSuccess { get; set; }

        [DataMember]
        public string ErrorKey { get; set; }

        [DataMember]
        public String Email { get; set; }

        public static LoginResponse SuccessResult(String email)
        {
            return new LoginResponse { IsSuccess = true, Email = email };
        }

        public static LoginResponse Failure(string errorKey)
        {
            return new LoginResponse { IsSuccess = false, ErrorKey = errorKey };
        }
    }
}
