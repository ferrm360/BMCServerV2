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

        public OperationResponse SubmitInitialMatrix(string lobbyId, string player, GameBoardDTO board)
        {
            if (!_activeGames.TryGetValue(lobbyId, out var gameSession))
            {
                return OperationResponse.Failure(GameMessages.GameNotFound);
            }

            try
            {
                gameSession.SetMatrix(player, board);

            }
            catch (Exception ex)
            {
                CustomLogger.Warn(ex.Message);
                return OperationResponse.Failure(GameMessages.CantSummitMatrix);
            }

            PrintGameSessionsState();
            return OperationResponse.SuccessResult();
        }

        public OperationResponse StartGame(string lobbyId)
        {
            if (!_activeGames.TryGetValue(lobbyId, out var gameSession))
            {
                return OperationResponse.Failure(GameMessages.GameNotFound);
            }

            if (!gameSession.AreAllBoardsSet())
            {
                return OperationResponse.Failure(GameMessages.PlayerDontSummitGameBoard);
            }

            return OperationResponse.SuccessResult();
        }


        // FIXME para debbug
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
                    var hasBoard = gameSession.GetPlayerBoard(player) != null ? "Sí" : "No";
                    Console.WriteLine($"  Jugador: {player} - Tablero asignado: {hasBoard}");
                }
            }
        }
    }
}
