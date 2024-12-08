using Service.Results;
using Service.Utilities.Results;
using System.ServiceModel;

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
        [OperationContract]
        PlayerScoreListResponse GetAllScores();
    }
}
