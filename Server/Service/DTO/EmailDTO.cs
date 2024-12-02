using System.Runtime.Serialization;

namespace Service.DTO
{
    [DataContract]
    public class EmailDTO
    {
        [DataMember]
        public string Recipient { get; set; }
        [DataMember]
        public string Username { get; set; }
        [DataMember]
        public string EmailType { get; set; }
        [DataMember]
        public string VerificationCode { get; set; }
        [DataMember]
        public string LobbyName { get; set; }
        [DataMember] 
        public string LobbyHost { get; set; }
        [DataMember]
        public string LobbyPassword { get; set; }
        [DataMember]
        public string CustomBody { get; set; }

    }
}
