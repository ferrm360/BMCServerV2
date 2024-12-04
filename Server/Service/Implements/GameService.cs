using Service.Contracts;
using Service.DTO;
using Service.Entities;
using Service.Results;
using Service.Utilities;
using Service.Utilities.Constans;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Threading.Tasks;

namespace Service.Implements
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerSession, ConcurrencyMode = ConcurrencyMode.Multiple)]
    public class GameService : IGameService
    {
        public static readonly ConcurrentDictionary<string, GameSession> _activeGames = new ConcurrentDictionary<string, GameSession>();

        public async Task<OperationResponse> AttackAsync(string lobbyId, string attacker, AttackPositionDTO attackPosition)
        {
            if (!_activeGames.TryGetValue(lobbyId, out var gameSession))
            {
                return OperationResponse.Failure("Game not found.");
            }

            var opponent = gameSession.GetOpponent(attacker);
            if (opponent == null)
            {
                Console.WriteLine($"El atacante '{attacker}' no tiene un oponente en la lobby '{lobbyId}'.");
                return OperationResponse.Failure("Opponent not found.");
            }

            if (gameSession.GetCurrentPlayer() != attacker)
            {
                Console.WriteLine($"El jugador {attacker} está intentando atacar fuera de su turno.");
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
                    Console.WriteLine($"Error notificando ataque a {opponent}: {ex.Message}");
                    return OperationResponse.Failure("Failed to notify opponent.");
                }
            }
            else
            {
                Console.WriteLine($"Callback para el oponente '{opponent}' no disponible en la lobby '{lobbyId}'.");
                return OperationResponse.Failure("Opponent callback not available.");
            }
        }


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

                Console.WriteLine($"Jugador {player} está listo en la lobby {lobbyId}.");
                PrintGameSessionsState();

                if (gameSession.AreAllPlayersReady())
                {
                    Console.WriteLine($"Todos los jugadores están listos en la lobby {lobbyId}.");

                    var tasks = new List<Task>();
                    foreach (var registeredPlayer in gameSession.GetPlayers())
                    {
                        if (gameSession.TryGetCallback(registeredPlayer, out var registeredCallback))
                        {
                            tasks.Add(Task.Run(() =>
                            {
                                try
                                {
                                    Console.WriteLine($"Notificando a {registeredPlayer} que el juego ha comenzado.");
                                    registeredCallback.OnGameStarted();
                                }
                                catch (Exception ex)
                                {
                                    Console.WriteLine($"Error notificando inicio del juego al jugador {registeredPlayer}: {ex.Message}");
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
                Console.WriteLine($"Error al marcar al jugador {player} como listo: {ex.Message}");
                return OperationResponse.Failure($"Error al marcar al jugador como listo: {ex.Message}");
            }

            return OperationResponse.SuccessResult("PlayerReady");
        }



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

        public async Task<OperationResponse> NotifyGameOverAsync(string lobbyId, string looser)
        {
            if (!_activeGames.TryGetValue(lobbyId, out var gameSession))
            {
                return OperationResponse.Failure("Game not found.");
            }

            var opponent = gameSession.GetOpponent(looser);
            if (opponent == null)
            {
                return OperationResponse.Failure("Opponent not found.");
            }


            if (gameSession.TryGetCallback(opponent, out var opponentCallback))
            {
                try
                {
                    var tasks = new List<Task>();
                    Console.WriteLine("Callback despues");
                    tasks.Add(Task.Run(() =>
                    {
                            opponentCallback.OnGameOver();
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
                Console.WriteLine($"Callback para el oponente '{opponent}' no disponible en la lobby '{lobbyId}'.");
                return OperationResponse.Failure("No se recupero el callback");
            }
        }

        public async Task<OperationResponse> NotifyCellDeadAsync(CellDeadDTO cellDeadDTO)
        {
            Console.WriteLine("Meow");
            if (!_activeGames.TryGetValue(cellDeadDTO.LobbyId, out var gameSession))
            {
                return OperationResponse.Failure("Game not found.");
            }

            var opponent = gameSession.GetOpponent(cellDeadDTO.Looser);
            if (opponent == null)
            {
                return OperationResponse.Failure("Opponent not found.");
            }

            Console.WriteLine("Meowcallback");
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
                Console.WriteLine($"Callback para el oponente '{opponent}' no disponible en la lobby '{cellDeadDTO.LobbyId}'.");
                return OperationResponse.Failure("No se recupero el callback");
            }

        }
    }
}
