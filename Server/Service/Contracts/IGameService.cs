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
        OperationResponse InitializeGame(string lobbyId, string player1, string player2);

        [OperationContract]
        OperationResponse SubmitInitialMatrix(string lobbyId, string player, List<List<int>> matrix);

        [OperationContract]
        OperationResponse StartGame(string lobbyId, string player);
    }

    public interface IGameCallback
    {
        [OperationContract(IsOneWay = true)]
        void OnGameStarted();
    }
}
