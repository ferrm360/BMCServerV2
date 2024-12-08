using System.ServiceModel;
using Service.DTO;
using Service.Results;
using Service.Utilities.Results;

namespace Service.Contracts
{
    /// <summary>
    /// Defines the contract for managing account-related operations, such as registration, login, and logout.
    /// </summary>
    [ServiceContract]
    public interface IAccountService
    {
        /// <summary>
        /// Registers a new player account.
        /// </summary>
        /// <param name="player">The player details required for registration.</param>
        /// <returns>An <see cref="OperationResponse"/> indicating success or failure of the registration.</returns>
        [OperationContract]
        OperationResponse Register(PlayerDTO player);

        /// <summary>
        /// Logs a player into their account.
        /// </summary>
        /// <param name="username">The username of the player attempting to log in.</param>
        /// <param name="password">The password of the player attempting to log in.</param>
        /// <returns>A <see cref="LoginResponse"/> containing the login result and any additional data.</returns>
        [OperationContract]
        LoginResponse Login(string username, string password);

        /// <summary>
        /// Logs a player out of their account.
        /// </summary>
        /// <param name="username">The username of the player attempting to log out.</param>
        /// <returns>An <see cref="OperationResponse"/> indicating success or failure of the logout operation.</returns>
        [OperationContract]
        OperationResponse Logout(string username); 
     }
}
