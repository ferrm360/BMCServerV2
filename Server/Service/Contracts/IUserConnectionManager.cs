using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

namespace Service.Contracts
{
    [ServiceContract]
    public interface IUserConnectionManager
    {
        [OperationContract]
        void Connect(string username);

        [OperationContract(IsOneWay = true)]
        void Disconnect();
    }
}
