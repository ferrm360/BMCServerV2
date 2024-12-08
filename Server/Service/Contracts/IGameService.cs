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

        /// <summary>
        /// Processes an attack in the game.
        /// </summary>
        /// <param name="lobbyId">Unique identifier of the lobby.</param>
        /// <param name="attacker">Username of the player making the attack.</param>
        /// <param name="attackPosition">Details of the attack position.</param>
        /// <returns>A task with an operation response indicating success or failure.</returns>
        [OperationContract]
        Task<OperationResponse> AttackAsync(string lobbyId, string attacker, AttackPositionDTO attackPosition);

        /// <summary>
        /// Notifies the game that a player has lost.
        /// </summary>
        /// <param name="lobbyId">Unique identifier of the lobby.</param>
        /// <param name="loser">Username of the player who lost.</param>
        /// <returns>A task with an operation response indicating success or failure.</returns>
        [OperationContract]
        Task<OperationResponse> NotifyGameOverAsync(string lobbyId, string loser);

        /// <summary>
        /// Notifies that a specific cell is destroyed in the game.
        /// </summary>
        /// <param name="cellDeadDTO">Details of the destroyed cell.</param>
        /// <returns>A task with an operation response indicating success or failure.</returns>
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

        /// <summary>
        /// Notifies the client when an attack is received.
        /// </summary>
        /// <param name="attackPosition">Details of the received attack.</param>
        [OperationContract(IsOneWay = true)]
        void OnAttackReceived(AttackPositionDTO attackPosition);


        /// <summary>
        /// Notifies the client about their turn change status.
        /// </summary>
        /// <param name="isPlayerTurn">Indicates whether it is the client's turn.</param>
        [OperationContract(IsOneWay = true)]
        Task OnTurnChangedAsync(bool isPlayerTurn);

        /// <summary>
        /// Notifies the client that the game is over and indicates the loser.
        /// </summary>
        /// <param name="loser">Username of the player who lost.</param>
        [OperationContract(IsOneWay = true)]
        void OnGameOver(string loser);

        /// <summary>
        /// Notifies the client about a cell destruction event.
        /// </summary>
        /// <param name="cellDeadDTO">Details of the destroyed cell.</param>
        [OperationContract(IsOneWay = true)]
        void OnCellDead(CellDeadDTO cellDeadDTO);
    }
}
