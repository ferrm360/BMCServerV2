using Service.Contracts;
using Service.Entities;
using Service.Results;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

namespace Service.Implements
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerSession, ConcurrencyMode = ConcurrencyMode.Multiple)]
    public class GameService : IGameService
    {
        private static readonly ConcurrentDictionary<string, GameSession> _activeGames = new ConcurrentDictionary<string, GameSession>();
        private readonly IGameCallback _callback;

        public GameService()
        {
            _callback = OperationContext.Current.GetCallbackChannel<IGameCallback>();
        }

        public OperationResponse InitializeGame(string lobbyId, string player1, string player2)
        {
            if (_activeGames.ContainsKey(lobbyId))
                return OperationResponse.Failure("Game already exists for this lobby.");

            var gameSession = new GameSession(player1, player2);
            _activeGames[lobbyId] = gameSession;

            return OperationResponse.SuccessResult();
        }

        public OperationResponse SubmitInitialMatrix(string lobbyId, string player, List<List<int>> matrix)
        {
            if (!_activeGames.TryGetValue(lobbyId, out var gameSession))
                return OperationResponse.Failure("Game session not found.");

            gameSession.SetMatrix(player, matrix);

            return OperationResponse.SuccessResult();
        }


        public OperationResponse StartGame(string lobbyId, string player)
        {
            if (!_activeGames.TryGetValue(lobbyId, out var gameSession))
                return OperationResponse.Failure("Game session not found.");

            bool bothPlayersReady = gameSession.SetPlayerReady(player);

            if (bothPlayersReady)
            {
                gameSession.NotifyPlayersGameStarted();
            }

            return OperationResponse.SuccessResult();
        }
    }
}
