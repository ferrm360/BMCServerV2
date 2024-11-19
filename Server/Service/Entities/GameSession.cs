using Service.DTO;
using System;
using System.Collections.Generic;

namespace Service.Entities
{
    public class GameSession
    {
        private readonly Dictionary<string, GameBoardDTO> _playerBoards = new Dictionary<string, GameBoardDTO>();

        public void AddPlayer(string player)
        {
            if (_playerBoards.ContainsKey(player))
                throw new InvalidOperationException($"Player {player} is already in the session.");

            _playerBoards[player] = null;
        }

        public void SetMatrix(string player, GameBoardDTO board)
        {
            if (!_playerBoards.ContainsKey(player))
                throw new InvalidOperationException($"Player {player} is not part of this session.");

            _playerBoards[player] = board;
        }

        public GameBoardDTO GetPlayerBoard(string player)
        {
            if (!_playerBoards.TryGetValue(player, out var board))
                throw new InvalidOperationException($"Player {player} is not part of this session.");

            return board;
        }

        public bool AreAllBoardsSet()
        {
            foreach (var board in _playerBoards.Values)
            {
                if (board == null)
                    return false;
            }
            return true;
        }
    }
}
