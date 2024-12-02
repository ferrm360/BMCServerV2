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
    public class ProfileResponse
    {
        [DataMember]
        public bool IsSuccess { get; set; }

        [DataMember]
        public string ErrorKey { get; set; }

        [DataMember]
        public PlayerProfileDTO Profile { get; set; }

        public static ProfileResponse SuccessResult(PlayerProfileDTO profile)
        {
            return new ProfileResponse { IsSuccess = true, Profile = profile };
        }

        public static ProfileResponse Failure(string errorKey)
        {
            return new ProfileResponse { IsSuccess = false, ErrorKey = errorKey };
        }
    }
}
