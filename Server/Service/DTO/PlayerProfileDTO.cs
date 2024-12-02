using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Service.DTO
{
    [DataContract]
    public class PlayerProfileDTO
    {
        [DataMember]
        public string FullName { get; set; }
        [DataMember]
        public string Bio { get; set; }
        [DataMember]
        public DateTime JoinDate { get; set; }
        [DataMember]
        public DateTime SingUpDate { get; set; }
        [DataMember]
        public DateTime LastVisit { get; set; }
        [DataMember]
        public byte[] ProfileImage { get; set; }
    }
}
