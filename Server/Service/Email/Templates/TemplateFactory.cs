using Service.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service.Email.Templates
{
    public static class TemplateFactory
    {
        public static (string Subject, string Body) GetTemplate(EmailDTO emailDto)
        {
            switch (emailDto.EmailType.ToLower())
            {
                case "changepassword":
                    return (
                        ChangePasswordTemplate.GetSubject(),
                        ChangePasswordTemplate.GetBody(emailDto.Username, emailDto.VerificationCode)
                    );

                case "lobbyinvite":
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
    }
}
