using Service.Results;
using Service.Utilities.Results;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

namespace Service.Contracts
{
    [ServiceContract]
    public interface IPlayerScoresService
    {
        [OperationContract]
        PlayerScoresResponse GetScoresByUsername(string username);
        [OperationContract]
        OperationResponse IncrementWins(string username);
        [OperationContract]
        OperationResponse IncrementLosses(string username);
    }
}
