using System.Runtime.Serialization;

namespace Service.Results
{
    [DataContract]
    public class OperationResult
    {
        [DataMember]
        public bool IsSuccess { get; set; }

        [DataMember]
        public string ErrorKey { get; set; }

        [DataMember]
        public object Data { get; set; }

        public static OperationResult SuccessResult()
        {
            return new OperationResult { IsSuccess = true };
        }

        public static OperationResult SuccessResult(object data)
        {
            return new OperationResult { IsSuccess = true, Data = data };
        }

        public static OperationResult Failure(string errorKey)
        {
            return new OperationResult { IsSuccess = false, ErrorKey = errorKey };
        }
    }
}
