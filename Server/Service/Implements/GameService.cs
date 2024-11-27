using Service.Contracts;
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
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerSession, ConcurrencyMode = ConcurrencyMode.Multiple)]
    public class GameService : IGameService
    {
        private static readonly ConcurrentDictionary<string, GameSession> _activeGames = new ConcurrentDictionary<string, GameSession>();

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

                    // Ejecutar los callbacks en paralelo para evitar bloqueos
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

                    await Task.WhenAll(tasks); // Espera a que todos los callbacks terminen
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

            // Simular lógica de inicio del juego
            await Task.Delay(100); // Por ejemplo, cargar recursos o configurar estados
            return OperationResponse.SuccessResult();
        }

        private void NotifyPlayersReadyStatus(GameSession gameSession, string readyPlayer)
        {
            foreach (var player in gameSession.GetPlayers())
            {
                if (player == readyPlayer) continue; // No notifiques al jugador actual

                if (gameSession.TryGetCallback(player, out var callback))
                {
                    try
                    {
                        callback.OnPlayerReady(readyPlayer);
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine($"Error notificando al jugador {player}: {ex.Message}");
                        gameSession.RemoveCallback(player); // Manejar desconexión
                    }
                }
            }
        }

        private void PrintGameSessionsState()
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
    }
}
