using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

namespace Service.Contracts
{
    /// <summary>
    /// Manages user connections for the service, allowing clients to connect and disconnect.
    /// </summary>
    [ServiceContract]
    public interface IUserConnectionManager
    {
        /// <summary>
        /// Connects a user to the service.
        /// </summary>
        /// <param name="username">The username of the user attempting to connect.</param>
        /// <remarks>
        /// This method registers the user as connected in the system.
        /// </remarks>
        [OperationContract]
        void Connect(string username);

        /// <summary>
        /// Disconnects the current user from the service.
        /// </summary>
        /// <remarks>
        /// This method unregisters the user and ensures proper cleanup of their connection state.
        /// It is one-way and does not return any result.
        /// </remarks>
        [OperationContract(IsOneWay = true)]
        void Disconnect();
    }
}
