using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Service.DTO
{
    [DataContract]
    public class CreateLobbyRequestDTO
    {
        [DataMember]
        public string Name { get; set; }
        [DataMember]
        public bool IsPrivate { get; set; }
        [DataMember]
        public string Password { get; set; }
        [DataMember]
        public string Username { get; set; }
        [DataMember]
        public string Host { get; set; }
    }
}
