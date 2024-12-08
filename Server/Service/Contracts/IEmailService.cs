using Service.DTO;
using Service.Results;
using System.ServiceModel;


namespace Service.Contracts
{
    /// <summary>
    /// Provides functionality for sending emails through the service.
    /// </summary>
    [ServiceContract]
    public interface IEmailService
    {
        /// <summary>
        /// Sends an email based on the provided email details.
        /// </summary>
        /// <param name="emailDTO">The email details, including recipient, subject, and content.</param>
        /// <returns>An <see cref="OperationResponse"/> indicating the success or failure of the operation.</returns>
        [OperationContract]
        OperationResponse SendEmail(EmailDTO emailDTO);
    }
}
