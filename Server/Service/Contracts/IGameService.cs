using Service.DTO;
using Service.Results;
using System.Collections.Generic;
using System.ServiceModel;
using System.Threading.Tasks;

namespace Service.Contracts
{
    [ServiceContract(CallbackContract = typeof(IGameCallback))]
    public interface IGameService
    {
        /// <summary>
        /// Initializes a new game session.
        /// </summary>
        /// <param name="lobbyId">Unique identifier of the lobby.</param>
        /// <param name="players">List of player usernames.</param>
        /// <returns>A Task with the operation response.</returns>
        [OperationContract]
        OperationResponse InitializeGame(string lobbyId, List<string> players);

        /// <summary>
        /// Marks a player as ready.
        /// </summary>
        /// <param name="lobbyId">Unique identifier of the lobby.</param>
        /// <param name="player">Username of the player.</param>
        /// <returns>A Task with the operation response.</returns>
        [OperationContract]
        Task<OperationResponse> MarkPlayerReadyAsync(string lobbyId, string player);

        /// <summary>
        /// Starts the game session if all players are ready.
        /// </summary>
        /// <param name="lobbyId">Unique identifier of the lobby.</param>
        /// <returns>A Task with the operation response.</returns>
        [OperationContract]
        Task<OperationResponse> StartGameAsync(string lobbyId);

        [OperationContract]
        Task<OperationResponse> AttackAsync(string lobbyId, string attacker, AttackPositionDTO attackPosition);

        [OperationContract]
        Task<OperationResponse> NotifyGameOverAsync(string lobbyId, string loser);

        [OperationContract]
        Task<OperationResponse> NotifyCellDeadAsync(CellDeadDTO cellDeadDTO);
    }

    public interface IGameCallback
    {
        /// <summary>
        /// Notifies the client when the game has started.
        /// </summary>
        [OperationContract(IsOneWay = true)]
        void OnGameStarted();

        /// <summary>
        /// Notifies the client when another player is ready.
        /// </summary>
        /// <param name="player">Username of the player who is ready.</param>
        [OperationContract(IsOneWay = true)]
        void OnPlayerReady(string player);

        [OperationContract(IsOneWay = true)]
        void OnAttackReceived(AttackPositionDTO attackPosition);

        [OperationContract(IsOneWay = true)]
        Task OnTurnChangedAsync(bool isPlayerTurn);

        [OperationContract(IsOneWay = true)]
        void OnGameOver(string loser);

        [OperationContract(IsOneWay = true)]
        void OnCellDead(CellDeadDTO cellDeadDTO);
    }
}
