using Service.Contracts;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service.Test
{
    public class LobbyCallbackMock : ILobbyCallback
    {
        public List<string> PlayerJoinedMessages { get; private set; } = new List<string>();
        public List<string> PlayerLeftMessages { get; private set; } = new List<string>();
        public List<string> StartGameMessages { get; private set; } = new List<string>();

        public void NotifyPlayerJoined(string playerName, string lobbyId)
        {
            PlayerJoinedMessages.Add($"{playerName} joined the lobby {lobbyId}");
        }

        public void NotifyPlayerJoinedMessage(string message)
        {
            PlayerJoinedMessages.Add(message);
        }

        public void NotifyPlayerLeft(string playerName, string lobbyId)
        {
            PlayerLeftMessages.Add($"{playerName} left the lobby {lobbyId}");
        }

        public void NotifyPlayerLeftMessage(string message)
        {
            PlayerLeftMessages.Add(message);
        }

        public void StartGameNotification(string lobbyId)
        {
            StartGameMessages.Add($"Game started in lobby {lobbyId}");
        }

        public void NotifyPlayerKicked()
        {
            // Implementación para simular un jugador expulsado, si es necesario
        }
    }
}
