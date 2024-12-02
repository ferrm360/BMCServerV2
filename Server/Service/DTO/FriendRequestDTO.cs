using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Service.DTO
{
    [DataContract]
    public class FriendRequestDTO
    {
        [DataMember]
        public int RequestID { get; set; }
        [DataMember]
        public string SenderUsername { get; set; }
        [DataMember]
        public string ReceiverUsername { get; set; }
        [DataMember]
        public string Status { get; set; }

    }
}
