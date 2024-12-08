using Service.DTO;
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
    /// Defines operations for managing player profiles, including password updates, profile images, and bios.
    /// </summary>
    [ServiceContract]
    public interface IProfileService
    {
        /// <summary>
        /// Updates the player's password.
        /// </summary>
        /// <param name="username">The username of the player.</param>
        /// <param name="newPassword">The new password to be set.</param>
        /// <param name="oldPassword">The current password for validation.</param>
        /// <returns>An <see cref="OperationResponse"/> indicating the success or failure of the operation.</returns>
        [OperationContract]
        OperationResponse UpdatePassword(string username, string newPassword, string oldPassword);

        /// <summary>
        /// Updates the player's profile picture.
        /// </summary>
        /// <param name="username">The username of the player.</param>
        /// <param name="imageBytes">The image data as a byte array.</param>
        /// <param name="fileName">The name of the image file.</param>
        /// <returns>An <see cref="OperationResponse"/> indicating the success or failure of the operation.</returns>
        [OperationContract]
        OperationResponse UpdateProfilePicture(string username, byte[] imageBytes, string fileName);

        /// <summary>
        /// Updates the player's username.
        /// </summary>
        /// <param name="currentUsername">The current username of the player.</param>
        /// <param name="newUsername">The new username to be set.</param>
        /// <returns>An <see cref="OperationResponse"/> indicating the success or failure of the operation.</returns>
        [OperationContract]
        OperationResponse UpdateUsername(string currentUsername, string newUsername);

        /// <summary>
        /// Updates the player's bio information.
        /// </summary>
        /// <param name="bio">The new bio content.</param>
        /// <param name="username">The username of the player.</param>
        /// <returns>An <see cref="OperationResponse"/> indicating the success or failure of the operation.</returns>
        [OperationContract]
        OperationResponse UpdateBio(string bio, string username);

        /// <summary>
        /// Retrieves the player's profile information by username.
        /// </summary>
        /// <param name="username">The username of the player.</param>
        /// <returns>A <see cref="ProfileResponse"/> containing the player's profile data.</returns>
        [OperationContract]
        ProfileResponse GetProfileByUsername(string username);

        /// <summary>
        /// Retrieves the player's profile image by username.
        /// </summary>
        /// <param name="username">The username of the player.</param>
        /// <returns>An <see cref="ImageResponse"/> containing the image data and metadata.</returns>
        [OperationContract]
        ImageResponse GetProfileImage(string username);

        /// <summary>
        /// Retrieves the player's bio by username.
        /// </summary>
        /// <param name="username">The username of the player.</param>
        /// <returns>A string containing the player's bio.</returns>
        [OperationContract]
        string GetBioByUsername(string username);
    }
}
