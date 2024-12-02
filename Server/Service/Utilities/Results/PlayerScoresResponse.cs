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
    public class PlayerScoresResponse
    {
        [DataMember]
        public bool IsSuccess { get; set; }

        [DataMember]
        public string ErrorKey { get; set; }

        [DataMember]
        public PlayerScoresDTO Scores { get; set; }

        public static PlayerScoresResponse SuccessResult(PlayerScoresDTO scores)
        {
            return new PlayerScoresResponse { IsSuccess = true, Scores = scores };
        }

        public static PlayerScoresResponse Failure(string errorKey)
        {
            return new PlayerScoresResponse { IsSuccess = false, ErrorKey = errorKey };
        }
    }
}
