using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service.Utilities.Helpers
{
    public static class SqlErrorHandler
    {
        public static string GetErrorMessage(SqlException ex)
        {
            switch (ex.Number)
            {
                case 18456:
                    return "DBInvalidCredentials";

                case 53:
                    return "DBConnectionFailed";

                case 4060:
                    return "DBDatabaseUnavailable";

                case 258:
                    return "DBTimeout";

                default:
                    return "DBGeneralError";
            }
        }
    }
}
