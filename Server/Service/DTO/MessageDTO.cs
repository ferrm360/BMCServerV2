using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Service.DTO
{
    [DataContract]
    public class MessageDTO
    {
        [DataMember]
        public string sender { get; set; }
        [DataMember] 
        public string message { get; set; }
    }
}
