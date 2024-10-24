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
    public class FriendListResponse
    {
        [DataMember]
        public bool IsSuccess { get; set; }

        [DataMember]
        public string ErrorKey { get; set; }

        [DataMember]
        public List<PlayerDTO> Friends { get; set; }

        public static FriendListResponse SuccessResult(List<PlayerDTO> friends)
        {
            return new FriendListResponse { IsSuccess = true, Friends = friends };
        }

        public static FriendListResponse Failure(string errorKey)
        {
            return new FriendListResponse { IsSuccess = false, ErrorKey = errorKey };
        }
    }
}
