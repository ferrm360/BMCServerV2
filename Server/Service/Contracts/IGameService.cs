using Service.DTO;
using Service.Results;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

namespace Service.Contracts
{
    [ServiceContract(CallbackContract = typeof(IGameCallback))]
    public interface IGameService
    {
        [OperationContract]
        OperationResponse InitializeGame(string lobbyId, List<string> players);

        [OperationContract]
        OperationResponse SubmitInitialMatrix(string lobbyId, string player, GameBoardDTO board);

        [OperationContract]
        OperationResponse StartGame(string lobbyId);
    }

    public interface IGameCallback
    {
        [OperationContract(IsOneWay = true)]
        void OnGameStarted();
    }
}
