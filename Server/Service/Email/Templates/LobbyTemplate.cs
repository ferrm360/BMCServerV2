using Service.DTO;
using System;

namespace Service.Email.Templates
{
    public static class LobbyTemplate
    {
        public static string GetSubject()
        {
            return "You’ve Been Invited to Join a Game Lobby!";
        }

        public static string GetBody(EmailDTO emailDTO)
        {
            var body = $@"
                <html>
                    <body style='font-family: Arial, sans-serif; background-color: #f4f4f9; padding: 20px;'>
                        <table style='max-width: 600px; margin: auto; background-color: #ffffff; border-radius: 8px; padding: 20px;'>
                            <tr>
                                <td>
                                    <h2 style='color: #333333; text-align: center;'>Game Lobby Invitation</h2>
                                    <p style='font-size: 16px; color: #333333;'>Hi <strong>{emailDTO.Username}</strong>,</p>
                                    <p style='font-size: 16px; color: #333333;'>You have been invited to join a game lobby by <strong>{emailDTO.LobbyHost}</strong>.</p>
                                    <p style='font-size: 16px; color: #333333;'>Here are the details:</p>
                                    <table style='width: 100%; border-collapse: collapse; margin-top: 15px;'>
                                        <tr>
                                            <td style='font-size: 14px; color: #333333; padding: 10px 0;'><strong>Lobby Name:</strong> {emailDTO.LobbyName}</td>
                                        </tr>";

            if (!string.IsNullOrWhiteSpace(emailDTO.LobbyPassword))
            {
                body += $@"
                                        <tr>
                                            <td style='font-size: 14px; color: #333333; padding: 10px 0;'><strong>Password:</strong> {emailDTO.LobbyPassword}</td>
                                        </tr>";
            }

            body += $@"
                                    </table>
                                    <p style='font-size: 16px; color: #333333; margin-top: 20px;'>We hope you enjoy the game!</p>
                                    <p style='font-size: 16px; color: #333333;'>Best regards,</p>
                                    <p style='font-size: 16px; color: #333333;'><strong>The BMC Service Team</strong></p>
                                </td>
                            </tr>
                        </table>
                    </body>
                </html>";

            return body;
        }
    }
}
