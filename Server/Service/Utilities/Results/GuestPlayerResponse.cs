using Service.Results;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service.Utilities.Results
{
    public class GuestPlayerResponse : OperationResponse
    {
        public string Username { get; set; }

        public static GuestPlayerResponse Success(string username)
        {
            return new GuestPlayerResponse
            {
                IsSuccess = true,
                Username = username
            };
        }

        public static GuestPlayerResponse Failure(string errorMessage)
        {
            return new GuestPlayerResponse
            {
                IsSuccess = false,
                ErrorKey = errorMessage
            };
        }
    }
}
