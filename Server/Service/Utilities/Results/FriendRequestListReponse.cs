using Service.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Service.Utilities.Results
{
    public class FriendRequestListReponse
    {
        [DataMember]
        public bool IsSuccess { get; set; }

        [DataMember]
        public string ErrorKey { get; set; }

        [DataMember]
        public List<FriendRequestDTO> FriendRequests { get; set; }


        public static FriendRequestListReponse SuccessResult(List<FriendRequestDTO> friendRequests)
        {
            return new FriendRequestListReponse { IsSuccess = true, FriendRequests = friendRequests };
        }

        public static FriendRequestListReponse Failure(string errorKey)
        {
            return new FriendRequestListReponse { IsSuccess = false, ErrorKey = errorKey };
        }
    }
}
