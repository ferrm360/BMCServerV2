using Service.Contracts;
using Service.DTO;
using Service.Entities;
using Service.Results;
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
                return OperationResponse.Failure("Game already exists for this lobby.");

            var gameSession = new GameSession();
            foreach (var player in players)
            {
                try
                {
                    gameSession.AddPlayer(player);
                }
                catch (Exception ex)
                {
                    return OperationResponse.Failure($"Error adding player {player}: {ex.Message}");
                }
            }

            _activeGames[lobbyId] = gameSession;

            return OperationResponse.SuccessResult();
        }

        public OperationResponse SubmitInitialMatrix(string lobbyId, string player, GameBoardDTO board)
        {
            if (!_activeGames.TryGetValue(lobbyId, out var gameSession))
                return OperationResponse.Failure("Game session not found.");

            try
            {
                gameSession.SetMatrix(player, board);
            }
            catch (Exception ex)
            {
                return OperationResponse.Failure($"Error setting matrix for player {player}: {ex.Message}");
            }

            return OperationResponse.SuccessResult();
        }

        public OperationResponse StartGame(string lobbyId)
        {
            if (!_activeGames.TryGetValue(lobbyId, out var gameSession))
                return OperationResponse.Failure("Game session not found.");

            if (!gameSession.AreAllBoardsSet())
                return OperationResponse.Failure("Not all players have submitted their boards.");

            return OperationResponse.SuccessResult();
        }
    }
}
