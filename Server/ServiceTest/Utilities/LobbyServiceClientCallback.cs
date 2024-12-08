using ServiceTest.LobbyService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service.Test.Utilities
{
    public class LobbyServiceClientCallback : ILobbyServiceCallback
    {
        public bool ReceivedPlayerJoinMessage { get; private set; }
        public bool ReceivedPlayerLeaveMessage { get; private set; }
        public bool ReceivedKickNotification { get; private set; }
        public bool ReceivedStartGameNotification { get; private set; }

        public void NotifyPlayerLeft(string playerName, string lobbyId)
        {
            Console.WriteLine($"{playerName} left lobby {lobbyId}");
            ReceivedPlayerLeaveMessage = true;
        }

        public void NotifyPlayerKicked()
        {
            Console.WriteLine("Player was kicked from the lobby");
            ReceivedKickNotification = true;
        }

        public void NotifyPlayerJoinedMessage(string message)
        {
            Console.WriteLine($"Join message: {message}");
            ReceivedPlayerJoinMessage = true;
        }

        public void NotifyPlayerLeftMessage(string message)
        {
            Console.WriteLine($"Leave message: {message}");
            ReceivedPlayerLeaveMessage = true;
        }

        public void StartGameNotification(string lobbyId)
        {
            Console.WriteLine($"Game started in lobby {lobbyId}");
            ReceivedStartGameNotification = true;
        }

        public void NotifyPlayerJoined(string playerName, string lobbyId)
        {
            throw new NotImplementedException();
        }
    }
}
