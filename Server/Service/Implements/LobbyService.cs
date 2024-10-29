using Service.Contracts;
using Service.DTO;
using Service.Entities;
using Service.Utilities.Constans;
using Service.Utilities.Results;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;

namespace Service.Implements
{
    // TODO ver si se va el host que pasa.
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.Single)]
    public class LobbyService : ILobbyService
    {
        private readonly Dictionary<string, Lobby> _activeLobbies = new Dictionary<string, Lobby>();

        public LobbyResponse CreateLobby(CreateLobbyRequestDTO request)
        {
            if (_activeLobbies.Values.Any(l => l.Name == request.Name))
            {
                return LobbyResponse.Failure(ErrorMessages.DuplicateLobbyName);
            }

            var lobby = new Lobby
            {
                Name = request.Name,
                IsPrivate = request.IsPrivate,
                Password = request.IsPrivate ? request.Password : null,
                Host = request.Username
            };

            lobby.AddPlayer(request.Username);

            _activeLobbies[lobby.LobbyId] = lobby;

            var lobbyDto = new LobbyDTO
            {
                LobbyId = lobby.LobbyId,
                Name = lobby.Name,
                IsPrivate = lobby.IsPrivate,
                CurrentPlayers = lobby.Players.Count,
                MaxPlayers = lobby.MaxPlayers,
                Host = lobby.Host,
                Players = new List<string>(lobby.Players)
            };

            return LobbyResponse.SuccessResult(lobbyDto);
        }


        public LobbyResponse JoinLobby(JoinLobbyRequestDTO request)
        {
            if (!_activeLobbies.TryGetValue(request.LobbyId, out var lobby))
            {
                return LobbyResponse.Failure(ErrorMessages.LobbyNotFound);
            }

            if (lobby.IsPrivate && lobby.Password != request.Password)
            {
                return LobbyResponse.Failure(ErrorMessages.InvalidLobbyPassword);
            }

            if (!lobby.CanJoin(request.Username, request.Password))
            {
                return LobbyResponse.Failure(ErrorMessages.LobbyFull);
            }

            lobby.AddPlayer(request.Username);

            var lobbyDto = new LobbyDTO
            {
                LobbyId = lobby.LobbyId,
                Name = lobby.Name,
                IsPrivate = lobby.IsPrivate,
                CurrentPlayers = lobby.Players.Count,
                MaxPlayers = lobby.MaxPlayers,
                Host = lobby.Host,
                Players = new List<string>(lobby.Players)
            };

            return LobbyResponse.SuccessResult(lobbyDto);
        }


        public LobbyResponse LeaveLobby(string lobbyId, string username)
        {
            if (!_activeLobbies.TryGetValue(lobbyId, out var lobby))
            {
                return LobbyResponse.Failure(ErrorMessages.LobbyNotFound);
            }

            lobby.RemovePlayer(username);

            if (lobby.IsEmpty())
            {
                _activeLobbies.Remove(lobbyId);
            }

            var lobbyDto = new LobbyDTO
            {
                LobbyId = lobby.LobbyId,
                Name = lobby.Name,
                IsPrivate = lobby.IsPrivate,
                CurrentPlayers = lobby.Players.Count,
                MaxPlayers = lobby.MaxPlayers,
                Host = lobby.Host,
                Players = new List<string>(lobby.Players)
            };

            return LobbyResponse.SuccessResult(lobbyDto);
        }


        public LobbyResponse KickPlayer(string lobbyId, string hostUsername, string targetUsername)
        {
            if (!_activeLobbies.TryGetValue(lobbyId, out var lobby))
            {
                return LobbyResponse.Failure(ErrorMessages.LobbyNotFound);
            }

            if (lobby.Host != hostUsername)
            {
                return LobbyResponse.Failure(ErrorMessages.NotLobbyHost);
            }

            if (!lobby.Players.Contains(targetUsername))
            {
                return LobbyResponse.Failure(ErrorMessages.PlayerNotInLobby);
            }

            lobby.RemovePlayer(targetUsername);

            var lobbyDto = new LobbyDTO
            {
                LobbyId = lobby.LobbyId,
                Name = lobby.Name,
                IsPrivate = lobby.IsPrivate,
                CurrentPlayers = lobby.Players.Count,
                MaxPlayers = lobby.MaxPlayers,
                Host = lobby.Host,
                Players = new List<string>(lobby.Players)
            };

            return LobbyResponse.SuccessResult(lobbyDto);
        }

        public List<LobbyDTO> GetAllLobbies()
        {
            return _activeLobbies.Values.Select(lobby => new LobbyDTO
            {
                LobbyId = lobby.LobbyId,
                Name = lobby.Name,
                IsPrivate = lobby.IsPrivate,
                CurrentPlayers = lobby.Players.Count,
                MaxPlayers = lobby.MaxPlayers,
                Host = lobby.Host,
                Players = new List<string>(lobby.Players)
            }).ToList();
        }
    }
}
