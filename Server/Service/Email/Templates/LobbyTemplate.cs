using Service.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service.Email.Templates
{
    public static class LobbyTemplate
    {
        public static string GetSubject()
        {
            return "Invite to lobby";
        }

        public static string GetBody(EmailDTO emailDTO) {
            var lobbyDetails = $@"
                Hi {emailDTO.Username},

                You have been invited to join a game lobby by {emailDTO.LobbyHost}.
                
                Lobby Name: {emailDTO.LobbyName}";

            if (!string.IsNullOrWhiteSpace(emailDTO.LobbyPassword))
            {
                lobbyDetails += $@"
                Password: {emailDTO.LobbyPassword}";
            }

            lobbyDetails += @"

                Enjoy the game!

                Regards,
                BMC Service Team";

            return lobbyDetails;
        }
    }
}
