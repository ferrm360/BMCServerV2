using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Service.DTO
{
    [DataContract]
    public class FlipCardDTO
    {
        [DataMember]
        public string LobbyId { get; set; }
        [DataMember]
        public string Player { get; set; }
        [DataMember]
        public string CardName { get; set; }
        [DataMember]
        public int Row { get; set; }
        [DataMember]
        public int Col { get; set; }
        [DataMember]
        public bool IsPlayerBoard { get; set; }
    }
}
