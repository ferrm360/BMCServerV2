using Service.Contracts;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;

namespace Service.Entities
{
    public class GameSession
    {
        private readonly ConcurrentDictionary<string, IGameCallback> _callbackChannels = new ConcurrentDictionary<string, IGameCallback>();
        private readonly HashSet<string> _readyPlayers = new HashSet<string>();
        private readonly List<string> _players = new List<string>();

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

            _callbackChannels[player] = callback;
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
            foreach (var callback in _callbackChannels.Values)
            {
                callback?.OnGameStarted();
            }
        }


        public IEnumerable<IGameCallback> GetCallbacks()
        {
            return _callbackChannels.Values;
        }

        public bool TryGetCallback(string player, out IGameCallback callback)
        {
            return _callbackChannels.TryGetValue(player, out callback);
        }

        public void RemoveCallback(string player)
        {
            _callbackChannels.TryRemove(player, out _);
        }

    }
}
