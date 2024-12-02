using Service.DTO;
using Service.Results;
using System.Collections.Generic;
namespace Service.Utilities.Results
{
    public class ChatFriendResponse : OperationResponse
    {
        public List<MessageFriendDTO> Messages { get; private set; }

        public static ChatFriendResponse SuccessResult(List<MessageFriendDTO> messages) => new ChatFriendResponse
        {
            IsSuccess = true,
            Messages = messages
        };

        public static new ChatFriendResponse Failure(string errorKey) => new ChatFriendResponse
        {
            IsSuccess = false,
            ErrorKey = errorKey,
            Messages = new List<MessageFriendDTO>()
        };
    }
}
