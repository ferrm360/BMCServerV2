using Service.Contracts;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

namespace Service.Entities
{
    public class GameSession
    {
        public string Player1 { get; }
        public string Player2 { get; }
        private bool _player1Ready;
        private bool _player2Ready;
        private List<List<int>> _matrixPlayer1;
        private List<List<int>> _matrixPlayer2;
        private readonly IGameCallback _callbackPlayer1;
        private readonly IGameCallback _callbackPlayer2;

        public GameSession(string player1, string player2)
        {
            Player1 = player1;
            Player2 = player2;
            _callbackPlayer1 = OperationContext.Current.GetCallbackChannel<IGameCallback>();
            _callbackPlayer2 = OperationContext.Current.GetCallbackChannel<IGameCallback>();
        }

        public void SetMatrix(string player, List<List<int>> matrix)
        {
            if (player == Player1)
                _matrixPlayer1 = matrix;
            else if (player == Player2)
                _matrixPlayer2 = matrix;
        }

        public bool SetPlayerReady(string player)
        {
            if (player == Player1)
                _player1Ready = true;
            else if (player == Player2)
                _player2Ready = true;

            return _player1Ready && _player2Ready;
        }

        public void NotifyPlayersGameStarted()
        {
            _callbackPlayer1?.OnGameStarted();
            _callbackPlayer2?.OnGameStarted();
        }
    }
}
