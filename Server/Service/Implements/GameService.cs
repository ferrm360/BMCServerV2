using Service.Contracts;
using Service.DTO;
using Service.Entities;
using Service.Results;
using Service.Utilities;
using Service.Utilities.Constans;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.ServiceModel;
using System.Threading.Tasks;

namespace Service.Implements
{
    /// <summary>
    /// Provides game management services for multiplayer sessions.
    /// </summary>
    /// <remarks>
    /// This class handles game initialization, player readiness, turn-based gameplay, 
    /// and game termination logic. It interacts with game sessions, manages callbacks for 
    /// real-time communication, and processes player actions such as attacks and game state updates.
    /// </remarks>
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerSession, ConcurrencyMode = ConcurrencyMode.Multiple)]
    public class GameService : IGameService
    {
        public static readonly ConcurrentDictionary<string, GameSession> _activeGames = new ConcurrentDictionary<string, GameSession>();

        /// <summary>
        /// Processes an attack action from a player in the game.
        /// </summary>
        /// <param name="lobbyId">The unique identifier of the game lobby.</param>
        /// <param name="attacker">The username of the attacking player.</param>
        /// <param name="attackPosition">The position being attacked.</param>
        /// <returns>A Task containing the operation response.</returns>
        public async Task<OperationResponse> AttackAsync(string lobbyId, string attacker, AttackPositionDTO attackPosition)
        {
            if (!_activeGames.TryGetValue(lobbyId, out var gameSession))
            {
                return OperationResponse.Failure("Game not found.");
            }

            var opponent = gameSession.GetOpponent(attacker);
            if (opponent == null)
            {
                return OperationResponse.Failure("Opponent not found.");
            }

            if (gameSession.GetCurrentPlayer() != attacker)
            {
                return OperationResponse.Failure("It's not your turn.");
            }


            if (gameSession.TryGetCallback(opponent, out var opponentCallback))
            {
                try
                {
                    opponentCallback.OnAttackReceived(attackPosition);
                    Console.WriteLine($"Ataque enviado a {opponent}: Posición X={attackPosition.X}, Y={attackPosition.Y}.");

                    gameSession.RotateTurnAsync();
                    return OperationResponse.SuccessResult("Attack sent.");
                }
                catch (Exception ex)
                {
                    CustomLogger.Fatal($"Error notificando ataque a {opponent}: {ex.Message}");
                    return OperationResponse.Failure("Failed to notify opponent.");
                }
            }
            else
            {
                CustomLogger.Warn($"Callback para el oponente '{opponent}' no disponible en la lobby '{lobbyId}'.");
                return OperationResponse.Failure("Opponent callback not available.");
            }
        }

        /// <summary>
        /// Initializes a new game session with the specified players.
        /// </summary>
        /// <param name="lobbyId">The unique identifier of the game lobby.</param>
        /// <param name="players">A list of usernames for the players in the game.</param>
        /// <returns>An OperationResponse indicating the success or failure of the operation.</returns>
        public OperationResponse InitializeGame(string lobbyId, List<string> players)
        {
            if (_activeGames.ContainsKey(lobbyId))
            {
                return OperationResponse.Failure(GameMessages.GameAlredyExist);
            }

            var gameSession = new GameSession();
            foreach (var player in players)
            {
                try
                {
                    gameSession.AddPlayer(player);
                }
                catch (Exception ex)
                {
                    CustomLogger.Warn(ex.Message);
                    return OperationResponse.Failure(GameMessages.CantAddingPlayer);
                }
            }

            _activeGames[lobbyId] = gameSession;
            PrintGameSessionsState();
            return OperationResponse.SuccessResult();
        }

        /// <summary>
        /// Marks a player as ready for the game.
        /// </summary>
        /// <param name="lobbyId">The unique identifier of the game lobby.</param>
        /// <param name="player">The username of the player to mark as ready.</param>
        /// <returns>A Task containing the operation response.</returns>
        public async Task<OperationResponse> MarkPlayerReadyAsync(string lobbyId, string player)
        {
            if (!_activeGames.TryGetValue(lobbyId, out var gameSession))
            {
                return OperationResponse.Failure("Game not found");
            }

            try
            {
                var callback = OperationContext.Current.GetCallbackChannel<IGameCallback>();
                gameSession.RegisterCallback(player, callback);

                gameSession.MarkPlayerReady(player);

                PrintGameSessionsState();

                if (gameSession.AreAllPlayersReady())
                {
                    var tasks = new List<Task>();
                    foreach (var registeredPlayer in gameSession.GetPlayers())
                    {
                        if (gameSession.TryGetCallback(registeredPlayer, out var registeredCallback))
                        {
                            tasks.Add(Task.Run(() =>
                            {
                                try
                                {
                                    registeredCallback.OnGameStarted();
                                }
                                catch (Exception ex)
                                {
                                    CustomLogger.Warn($"Error notificando inicio del juego al jugador {registeredPlayer}: {ex.Message}");
                                    gameSession.RemoveCallback(registeredPlayer);
                                }
                            }));
                        }
                    }

                    await Task.WhenAll(tasks);
                    return OperationResponse.SuccessResult("AllPlayersReady");
                }
            }
            catch (Exception ex)
            {
                return OperationResponse.Failure($"Error al marcar al jugador como listo: {ex.Message}");
            }

            return OperationResponse.SuccessResult("PlayerReady");
        }

        /// <summary>
        /// Starts the game session if all players are ready.
        /// </summary>
        /// <param name="lobbyId">The unique identifier of the game lobby.</param>
        /// <returns>A Task containing the operation response.</returns>
        public async Task<OperationResponse> StartGameAsync(string lobbyId)
        {
            if (!_activeGames.TryGetValue(lobbyId, out var gameSession))
            {
                return OperationResponse.Failure(GameMessages.GameNotFound);
            }

            if (!gameSession.AreAllPlayersReady())
            {
                return OperationResponse.Failure(GameMessages.PlayerNotReady);
            }

            CustomLogger.Info($"Juego iniciado para la lobby: {lobbyId}");

            await Task.Delay(100);
            return OperationResponse.SuccessResult();
        }


        /// <summary>
        /// Prints the current state of all active game sessions for debugging purposes.
        /// </summary>
        private static void PrintGameSessionsState()
        {
            if (_activeGames.IsEmpty)
            {
                Console.WriteLine("No hay sesiones activas.");
                return;
            }

            foreach (var lobby in _activeGames)
            {
                Console.WriteLine($"LobbyId: {lobby.Key}");
                var gameSession = lobby.Value;

                foreach (var player in gameSession.GetPlayers())
                {
                    var isReady = gameSession.IsPlayerReady(player) ? "Sí" : "No";
                    Console.WriteLine($"  Jugador: {player} - Listo: {isReady}");
                }
            }
        }

        /// <summary>
        /// Notifies players about the end of the game.
        /// </summary>
        /// <param name="lobbyId">The unique identifier of the game lobby.</param>
        /// <param name="loser">The username of the losing player.</param>
        /// <returns>A Task containing the operation response.</returns>
        public async Task<OperationResponse> NotifyGameOverAsync(string lobbyId, string loser)
        {
            if (!_activeGames.TryGetValue(lobbyId, out var gameSession))
            {
                return OperationResponse.Failure("Game not found.");
            }

            var opponent = gameSession.GetOpponent(loser);
            if (opponent == null)
            {
                return OperationResponse.Failure("Opponent not found.");
            }


            if (gameSession.TryGetCallback(opponent, out var opponentCallback))
            {
                try
                {
                    var tasks = new List<Task>();
                    tasks.Add(Task.Run(() =>
                    {
                            opponentCallback.OnGameOver(loser);
                    }));

                    await Task.WhenAll(tasks);
                    return OperationResponse.SuccessResult();
                }
                catch (Exception ex) { 
                    return OperationResponse.Failure(ex.ToString());
                }
            }
            else
            {
                return OperationResponse.Failure("Callback not retrieved");
            }
        }

        /// <summary>
        /// Notifies the opponent about a destroyed cell during the game.
        /// </summary>
        /// <param name="cellDeadDTO">Details of the destroyed cell and affected player.</param>
        /// <returns>A Task containing the operation response.</returns>
        public async Task<OperationResponse> NotifyCellDeadAsync(CellDeadDTO cellDeadDTO)
        {
            if (!_activeGames.TryGetValue(cellDeadDTO.LobbyId, out var gameSession))
            {
                return OperationResponse.Failure("Game not found.");
            }

            var opponent = gameSession.GetOpponent(cellDeadDTO.Looser);
            if (opponent == null)
            {
                return OperationResponse.Failure("Opponent not found.");
            }

            if (gameSession.TryGetCallback(opponent, out var opponentCallback))
            {
                try
                {
                    var tasks = new List<Task>();
                    tasks.Add(Task.Run(() =>
                    {
                        opponentCallback.OnCellDead(cellDeadDTO);
                    }));

                    await Task.WhenAll(tasks);
                    return OperationResponse.SuccessResult();
                }
                catch (Exception ex)
                {
                    return OperationResponse.Failure(ex.ToString());
                }
            }
            else
            {
                CustomLogger.Warn($"Callback para el oponente '{opponent}' no disponible en la lobby '{cellDeadDTO.LobbyId}'.");
                return OperationResponse.Failure("Callback not retrieved");
            }

        }
    }
}
