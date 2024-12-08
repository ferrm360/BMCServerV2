using Service.DTO;
using Service.Entities;
using Service.Results;
using Service.Utilities.Results;
using System.Collections.Generic;
using System.ServiceModel;

namespace Service.Contracts
{
    /// <summary>
    /// Defines operations for managing lobbies and player interactions within lobbies.
    /// </summary>
    [ServiceContract(CallbackContract = typeof(ILobbyCallback))]
    public interface ILobbyService
    {
        /// <summary>
        /// Creates a new lobby based on the provided request data.
        /// </summary>
        /// <param name="request">Details of the lobby to be created, including its name and privacy settings.</param>
        /// <returns>A <see cref="LobbyResponse"/> indicating the success or failure of the lobby creation.</returns>
        [OperationContract]
        LobbyResponse CreateLobby(CreateLobbyRequestDTO request);

        /// <summary>
        /// Allows a player to join an existing lobby.
        /// </summary>
        /// <param name="request">Details of the lobby to join and the player's credentials.</param>
        /// <returns>A <see cref="LobbyResponse"/> indicating the success or failure of the join operation.</returns>
        [OperationContract]
        LobbyResponse JoinLobby(JoinLobbyRequestDTO request);

        /// <summary>
        /// Retrieves a list of all active lobbies.
        /// </summary>
        /// <returns>A list of <see cref="LobbyDTO"/> containing details of all active lobbies.</returns>
        [OperationContract]
        List<LobbyDTO> GetAllLobbies();

        /// <summary>
        /// Removes a player from a lobby.
        /// </summary>
        /// <param name="lobbyId">The unique identifier of the lobby.</param>
        /// <param name="username">The username of the player leaving the lobby.</param>
        /// <returns>A <see cref="LobbyResponse"/> indicating the success or failure of the operation.</returns>
        [OperationContract]
        LobbyResponse LeaveLobby(string lobbyId, string username);

        /// <summary>
        /// Kicks a player out of a lobby.
        /// </summary>
        /// <param name="lobbyId">The unique identifier of the lobby.</param>
        /// <param name="hostUsername">The username of the lobby host issuing the kick command.</param>
        /// <param name="targetUsername">The username of the player to be kicked.</param>
        /// <returns>A <see cref="LobbyResponse"/> indicating the success or failure of the operation.</returns>
        [OperationContract]
        LobbyResponse KickPlayer(string lobbyId, string hostUsername, string targetUsername);

        /// <summary>
        /// Starts the game for the specified lobby.
        /// </summary>
        /// <param name="lobbyId">The unique identifier of the lobby.</param>
        /// <param name="hostUsername">The username of the lobby host.</param>
        /// <returns>An <see cref="OperationResponse"/> indicating the success or failure of the operation.</returns>
        [OperationContract]
        OperationResponse StartGame(string lobbyId, string hostUsername);
    }

    /// <summary>
    /// Defines the callback contract for notifying players in the lobby.
    /// </summary>
    public interface ILobbyCallback
    {
        /// <summary>
        /// Notifies when a player joins a lobby.
        /// </summary>
        /// <param name="playerName">The name of the player who joined.</param>
        /// <param name="lobbyId">The unique identifier of the lobby.</param>
        [OperationContract(IsOneWay = true)]
        void NotifyPlayerJoined(string playerName, string lobbyId);

        /// <summary>
        /// Notifies when a player leaves a lobby.
        /// </summary>
        /// <param name="playerName">The name of the player who left.</param>
        /// <param name="lobbyId">The unique identifier of the lobby.</param>
        [OperationContract(IsOneWay = true)]
        void NotifyPlayerLeft(string playerName, string lobbyId);

        /// <summary>
        /// Sends a message indicating that a player has joined the lobby.
        /// </summary>
        /// <param name="message">The join message.</param>
        [OperationContract(IsOneWay = true)]
        void NotifyPlayerJoinedMessage(string message);

        /// <summary>
        /// Sends a message indicating that a player has left the lobby.
        /// </summary>
        /// <param name="message">The leave message.</param>
        [OperationContract(IsOneWay = true)]
        void NotifyPlayerLeftMessage(string message);

        /// <summary>
        /// Notifies players in the lobby that the game has started.
        /// </summary>
        /// <param name="lobbyId">The unique identifier of the lobby.</param>
        [OperationContract(IsOneWay = true)]
        void StartGameNotification(string lobbyId);

        /// <summary>
        /// Notifies a player that they have been kicked from the lobby.
        /// </summary>
        [OperationContract(IsOneWay = true)]
        void NotifyPlayerKicked();

    }
}
