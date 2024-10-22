using System;
using System.Security.Cryptography;
using System.Text;

namespace Service.Utilities.Helpers
{
    public static class PasswordHelper
    {
        public static string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                return Convert.ToBase64String(bytes);
            }
        }

        public static bool VerifyPassword(string password, string hashedPassword)
        {
            string hashedInputPassword = HashPassword(password);
            return hashedInputPassword == hashedPassword;
        }
    }
}
