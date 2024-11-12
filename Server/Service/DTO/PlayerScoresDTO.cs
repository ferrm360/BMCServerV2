using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;

namespace Service.DTO
{
    [DataContract]
    public class PlayerScoresDTO
    {
        [DataMember]
        public int PlayerId { get; set; }
        [DataMember]
        public int Wins { get; set; }
        [DataMember]
        public int Losses { get; set; }
    }
}
