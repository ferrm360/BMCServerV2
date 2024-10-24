using System.Runtime.Serialization;

namespace Service.Results
{
    [DataContract]
    public class OperationResponse
    {
        [DataMember]
        public bool IsSuccess { get; set; }

        [DataMember]
        public string ErrorKey { get; set; }

        [DataMember]
        public object Data { get; set; }

        public static OperationResponse SuccessResult()
        {
            return new OperationResponse { IsSuccess = true };
        }

        public static OperationResponse SuccessResult(object data)
        {
            return new OperationResponse { IsSuccess = true, Data = data };
        }

        public static OperationResponse Failure(string errorKey)
        {
            return new OperationResponse { IsSuccess = false, ErrorKey = errorKey };
        }
    }
}
