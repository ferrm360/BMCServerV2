using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Service.DTO
{
    [DataContract]
    public class LobbyDTO
    {
        [DataMember]
        public string LobbyId { get; set; }
        [DataMember]
        public string Name { get; set; }
        [DataMember]
        public bool IsPrivate { get; set; }
        [DataMember]
        public int CurrentPlayers { get; set; }
        [DataMember]
        public int MaxPlayers { get; set; } = 2;
    }
}
