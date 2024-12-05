using Service.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataAccess.Repositories;


namespace Service.Email.Templates
{
    public class TemplateFactory
    {
        private IPlayerRepository _playerRepository;

        public TemplateFactory(IPlayerRepository playerRepository)
        {
            _playerRepository = playerRepository;
        }


        public (string Subject, string Body) GetTemplate(EmailDTO emailDto)
        {
            switch (emailDto.EmailType.ToLower())
            {
                case "changepassword":

                    return (
                        ChangePasswordTemplate.GetSubject(),
                        ChangePasswordTemplate.GetBody(emailDto.Username, emailDto.VerificationCode)
                    );

                case "lobbyinvite":
                    string playerEmail = GetPlayerEmailByUsername(emailDto.Username);
                    emailDto.Recipient = playerEmail;

                    return (
                        LobbyTemplate.GetSubject(),
                        LobbyTemplate.GetBody(emailDto)
                    );

                case "custom":
                    return (
                        "Custom Message",
                        emailDto.CustomBody ?? "No custom body provided."
                    );

                default:
                    throw new ArgumentException("Unsupported email type.");
            }
        }

        
        private string GetPlayerEmailByUsername(string username)
        {
            var player = _playerRepository.GetByUsername(username);
            if (player == null)
            {
                throw new ArgumentException($"Player with username {username} not found.");
            }
            return player.Email;
        }
        
    }
}
