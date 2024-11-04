using System;
using System.Runtime.Serialization;

namespace Service.DTO
{
    [DataContract]
    public class MessageFriendDTO
    {
        [DataMember]
        public string SenderUsername { get; set; }
        [DataMember]
        public string ReceiverUsername { get; set; }
        [DataMember]
        public string Message { get; set; }
        [DataMember]
        public DateTime Timestamp { get; set; }
    }
}
