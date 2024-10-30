using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service.Entities
{
    public class Lobby
    {
        public string LobbyId { get; private set; } = Guid.NewGuid().ToString();
        public string Name { get; set; }
        public bool IsPrivate { get; set; }
        public string Password { get; set; }
        public List<string> Players { get; set; } = new List<string>();
        public int MaxPlayers { get; set; } = 2;
        public string Host { get; set; }


        public bool CanJoin(string username, string password = null)
        {
            if (Players.Count >= MaxPlayers) return false;
            if (IsPrivate && Password != password) return false;
            return !Players.Contains(username);
        }

        public void AddPlayer(string username)
        {
            if (Players.Count < MaxPlayers)
            {
                Players.Add(username);
            }
        }

        public void RemovePlayer(string username)
        {
            Players.Remove(username);
        }

        public bool IsEmpty()
        {
            return Players.Count == 0;
        }
    }
}
