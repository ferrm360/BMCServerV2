using Service.Contracts;
using Service.DTO;
using Service.Entities;
using Service.Results;
using Service.Utilities;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.ServiceModel;

namespace Service.Implements
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerSession, ConcurrencyMode = ConcurrencyMode.Multiple)]
    public class GameService : IGameService
    {
        private static readonly ConcurrentDictionary<string, GameSession> _activeGames = new ConcurrentDictionary<string, GameSession>();

        public OperationResponse InitializeGame(string lobbyId, List<string> players)
        {
            CustomLogger.Info($"[InitializeGame] Iniciando juego para lobbyId: {lobbyId} con jugadores: {string.Join(", ", players)}");

            if (_activeGames.ContainsKey(lobbyId))
            {
                CustomLogger.Warn($"[InitializeGame] Ya existe un juego para el lobbyId: {lobbyId}");
                return OperationResponse.Failure("Game already exists for this lobby.");
            }

            var gameSession = new GameSession();
            foreach (var player in players)
            {
                try
                {
                    gameSession.AddPlayer(player);
                    CustomLogger.Info($"[InitializeGame] Jugador añadido: {player} al lobbyId: {lobbyId}");

                }
                catch (Exception ex)
                {
                    return OperationResponse.Failure($"Error adding player {player}: {ex.Message}");
                }
            }

            _activeGames[lobbyId] = gameSession;
            PrintGameSessionsState();

            return OperationResponse.SuccessResult();
        }

        public OperationResponse SubmitInitialMatrix(string lobbyId, string player, GameBoardDTO board)
        {
            CustomLogger.Info($"[SubmitInitialMatrix] Recibiendo matriz inicial del jugador: {player} en lobbyId: {lobbyId}");
            if (!_activeGames.TryGetValue(lobbyId, out var gameSession))
            {
                CustomLogger.Warn($"[SubmitInitialMatrix] No se encontró una sesión para el lobbyId: {lobbyId}");
                return OperationResponse.Failure("Game session not found.");
            }

            try
            {
                gameSession.SetMatrix(player, board);
                CustomLogger.Info($"[SubmitInitialMatrix] Tablero asignado al jugador {player} en el lobbyId {lobbyId}");

            }
            catch (Exception ex)
            {
                CustomLogger.Error($"[SubmitInitialMatrix] Error al asignar el tablero al jugador {player} en lobbyId: {lobbyId}", ex);
                return OperationResponse.Failure($"Error setting matrix for player {player}: {ex.Message}");
            }

            PrintGameSessionsState();


            return OperationResponse.SuccessResult();
        }

        public OperationResponse StartGame(string lobbyId)
        {
            if (!_activeGames.TryGetValue(lobbyId, out var gameSession))
            {
                return OperationResponse.Failure("Game session not found.");
            }

            if (!gameSession.AreAllBoardsSet())
            {
                return OperationResponse.Failure("Not all players have submitted their boards.");
            }

            return OperationResponse.SuccessResult();
        }

        private void PrintGameSessionsState()
        {
            Console.WriteLine("=== ESTADO ACTUAL DE LAS SESIONES ===");

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
                    var hasBoard = gameSession.GetPlayerBoard(player) != null ? "Sí" : "No";
                    Console.WriteLine($"  Jugador: {player} - Tablero asignado: {hasBoard}");
                }
            }

            Console.WriteLine("=====================================");
        }

    }
}
