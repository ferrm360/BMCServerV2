using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service.Email.Templates
{
    public class ChangePasswordTemplate
    {
        public static string GetSubject()
        {
            return "BMC - Change Your Password";
        }

        public static string GetBody(string username, string verificationCode)
        {
            return $@"
                Hi {username},

                You requested to change your password. Please use the verification code below to complete the process:

                Verification Code: {verificationCode}

                If you did not request this change, please ignore this email or contact support immediately.

                Thank you,
                Your Service Team";
        }
    }
}
