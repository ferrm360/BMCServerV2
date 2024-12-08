using Service.Results;
using Service.Utilities.Results;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

namespace Service.Contracts
{
    /// <summary>
    /// Defines operations for managing guest players within the service.
    /// </summary>
    [ServiceContract]
    public interface IGuestPlayerService
    {
        /// <summary>
        /// Registers a guest player in the system.
        /// </summary>
        /// <param name="username">The username to register as a guest player.</param>
        /// <returns>An <see cref="OperationResponse"/> indicating the success or failure of the operation.</returns>
        [OperationContract]
        OperationResponse RegisterGuestPlayer(string username);

        /// <summary>
        /// Logs out a guest player from the system.
        /// </summary>
        /// <param name="username">The username of the guest player to log out.</param>
        /// <returns>An <see cref="OperationResponse"/> indicating the success or failure of the operation.</returns>
        [OperationContract]
        OperationResponse LogoutGuestPlayer(string username);
    }
}
