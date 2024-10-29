using Service.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Service.Utilities.Results
{
    [DataContract]
    public class LobbyResponse
    {
        [DataMember]
        public bool IsSuccess { get; set; }

        [DataMember]
        public string ErrorKey { get; set; }

        [DataMember]
        public LobbyDTO Lobby { get; set; }

        public static LobbyResponse SuccessResult(LobbyDTO lobby)
        {
            return new LobbyResponse { IsSuccess = true, Lobby = lobby };
        }

        public static LobbyResponse Failure(string errorKey)
        {
            return new LobbyResponse { IsSuccess = false, ErrorKey = errorKey };
        }
    }
}
