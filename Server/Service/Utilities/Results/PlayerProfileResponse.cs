using Service.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Service.Utilities.Results
{
    public class PlayerProfileResponse
    {
        [DataMember]
        public bool IsSuccess { get; set; }

        [DataMember]
        public string ErrorKey { get; set; }

        [DataMember]
        public List<PlayerProfileDTO> Profile { get; set; }

        [DataMember]
        public List<PlayerDTO> Player { get; set; }

        public static PlayerProfileResponse SuccessResult(List<PlayerProfileDTO> profile, List<PlayerDTO> player)
        {
            return new PlayerProfileResponse { IsSuccess = true, Profile = profile, Player = player };
        }

        public static PlayerProfileResponse Failure(string errorKey)
        {
            return new PlayerProfileResponse { IsSuccess = false, ErrorKey = errorKey };
        }
    }
}
