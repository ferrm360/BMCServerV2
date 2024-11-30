using Service.Contracts;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Service.Entities
{
    public class GameSession
    {
        private readonly ConcurrentDictionary<string, IGameCallback> _gameCallbackChannels = new ConcurrentDictionary<string, IGameCallback>();

        private readonly HashSet<string> _readyPlayers = new HashSet<string>();
        private readonly List<string> _players = new List<string>();
        private int _currentTurnIndex = 0; 


        public void AddPlayer(string player)
        {
            if (_players.Contains(player))
                throw new InvalidOperationException($"Player {player} is already in the session.");

            _players.Add(player);
        }

        public void RegisterCallback(string player, IGameCallback callback)
        {
            if (!_players.Contains(player))
                throw new InvalidOperationException($"Player {player} is not part of this session.");

            _gameCallbackChannels[player] = callback;
        }

        public void MarkPlayerReady(string player)
        {
            if (!_players.Contains(player))
                throw new InvalidOperationException($"Player {player} is not part of this session.");

            _readyPlayers.Add(player);
        }

        public bool IsPlayerReady(string player)
        {
            return _readyPlayers.Contains(player);
        }

        public bool AreAllPlayersReady()
        {
            return _players.Count > 0 && _readyPlayers.Count == _players.Count;
        }

        public IEnumerable<string> GetPlayers()
        {
            return _players;
        }

        public IEnumerable<string> GetReadyPlayers()
        {
            return _readyPlayers;
        }

        public void NotifyGameStarted()
        {
            foreach (var callback in _gameCallbackChannels.Values)
            {
                callback?.OnGameStarted();
            }
        }


        public IEnumerable<IGameCallback> GetCallbacks()
        {
            return _gameCallbackChannels.Values;
        }

        public bool TryGetCallback(string player, out IGameCallback callback)
        {
            return _gameCallbackChannels.TryGetValue(player, out callback);
        }

        public void RemoveCallback(string player)
        {
            _gameCallbackChannels.TryRemove(player, out _);
        }

        public string GetOpponent(string player)
        {
            return _players.FirstOrDefault(p => p != player);
        }

        public string GetCurrentPlayer()
        {
            return _players[_currentTurnIndex];
        }

        public async Task RotateTurnAsync()
        {
            _currentTurnIndex = (_currentTurnIndex + 1) % _players.Count;
            string currentPlayer = GetCurrentPlayer();

            Console.WriteLine($"Es el turno de {currentPlayer}");

            await NotifyTurnChangeAsync(currentPlayer);
        }

        private async Task NotifyTurnChangeAsync(string currentPlayer)
        {
            var tasks = new List<Task>();

            foreach (var player in _gameCallbackChannels.Keys)
            {
                var isPlayerTurn = player == currentPlayer;
                try
                {
                    var callbackTask = _gameCallbackChannels[player].OnTurnChangedAsync(isPlayerTurn);
                    tasks.Add(callbackTask);
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Error notificando turno a {player}: {ex.Message}");
                }
            }

            await Task.WhenAll(tasks);
        }
    
    }
}
