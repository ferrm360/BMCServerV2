using Service.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Service.Utilities.Results
{
    public class PlayerScoreListResponse
    {
        [DataMember]
        public bool IsSuccess { get; set; }

        [DataMember]
        public string ErrorKey { get; set; }

        [DataMember]
        public List<PlayerScoresDTO> Scores { get; set; }

        public static PlayerScoreListResponse SuccessResult(List<PlayerScoresDTO> scores)
        {
            return new PlayerScoreListResponse { IsSuccess = true, Scores = scores };
        }

        public static PlayerScoreListResponse Failure(string errorKey)
        {
            return new PlayerScoreListResponse { IsSuccess = false, ErrorKey = errorKey };
        }
    }
}
