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
    [ServiceContract]
    public interface IGuestPlayerService
    {
        [OperationContract]
        OperationResponse RegisterGuestPlayer(string username);

        [OperationContract]
        OperationResponse LogoutGuestPlayer(string username);
    }
}
