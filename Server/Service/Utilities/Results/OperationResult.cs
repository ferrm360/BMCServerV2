using System.Runtime.Serialization;

namespace Service.Results
{
    [DataContract]
    public class OperationResult
    {
        [DataMember]
        public bool Success { get; set; }

        [DataMember]
        public string ErrorKey { get; set; }

        public static OperationResult SuccessResult()
        {
            return new OperationResult { Success = true };
        }

        public static OperationResult Failure(string errorKey)
        {
            return new OperationResult { Success = false, ErrorKey = errorKey };
        }
    }
}
