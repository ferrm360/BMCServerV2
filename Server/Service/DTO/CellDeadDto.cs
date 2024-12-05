using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Service.DTO
{
    [DataContract]
    public class CellDeadDTO
    {
        [DataMember]
        public string LobbyId { get; set; }
        [DataMember]
        public string Looser { get; set; }
        [DataMember]
        public int X { get; set; }
        [DataMember]
        public int Y { get; set; }
        [DataMember]
        public string CardName { get; set; }
    }
}
