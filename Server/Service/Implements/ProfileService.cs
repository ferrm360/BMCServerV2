using DataAccess;
using DataAccess.Repositories;
using Service.Contracts;
using Service.DTO;
using Service.Results;
using Service.Utilities.Constans;
using Service.Utilities.Helpers;
using Service.Utilities;
using System;
using System.Data.SqlClient;
using System.IO;
using Service.Utilities.Results;
using DataAccess.Utilities;

namespace Service.Implements
{
    /// <summary>
    /// Provides services related to user profiles, including updating profile data,
    /// managing profile pictures, and retrieving profile information.
    /// </summary>
    /// <remarks>
    /// This class interacts with repositories to handle profile and player data
    /// and ensures that operations like password updates, username changes,
    /// and profile picture management are performed securely.
    /// </remarks>
    public class ProfileService : IProfileService
    {
        private readonly IPlayerRepository _playerRepository;
        private readonly IProfileRepository _profileRepository;
        private readonly string _imageFolderPath;

        public ProfileService(IPlayerRepository playerRepository, IProfileRepository profileRepository)
        {
            _playerRepository = playerRepository;
            _profileRepository = profileRepository;
            _imageFolderPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "uploads", "avatars");

            if (!Directory.Exists(_imageFolderPath))
            {
                Directory.CreateDirectory(_imageFolderPath);
            }
        }

        /// <summary>
        /// Updates the password of a user.
        /// </summary>
        /// <param name="username">The username of the user.</param>
        /// <param name="newPassword">The new password to set.</param>
        /// <param name="oldPassword">The old password to verify.</param>
        /// <returns>An <see cref="OperationResponse"/> indicating success or failure.</returns>
        public OperationResponse UpdatePassword(string username, string newPassword, string oldPassword)
        {
            try
            {
                var player = _playerRepository.GetByUsername(username);
                bool isPasswordValid = PasswordHelper.VerifyPassword(oldPassword, player.PasswordHash);
                if (!isPasswordValid)
                {
                    return OperationResponse.Failure(ErrorMessages.DifferentPassword);
                }

                string passwordHash = PasswordHelper.HashPassword(newPassword);
                _playerRepository.UpdatePasswordHash(username, passwordHash);
                return OperationResponse.SuccessResult();
            }
            catch (SqlException ex)
            {
                CustomLogger.Error("", ex);
                string errorMessage = SqlErrorHandler.GetErrorMessage(ex);
                return OperationResponse.Failure(errorMessage);
            }
            catch (Exception ex)
            {
                CustomLogger.Error("", ex);
                return OperationResponse.Failure(ErrorMessages.GeneralException);
            }
        }

        /// <summary>
        /// Updates the profile picture of a user.
        /// </summary>
        /// <param name="username">The username of the user.</param>
        /// <param name="imageBytes">The binary data of the new image.</param>
        /// <param name="fileName">The name of the image file.</param>
        /// <returns>An <see cref="OperationResponse"/> indicating success or failure.</returns>
        public OperationResponse UpdateProfilePicture(string username, byte[] imageBytes, string fileName)
        {
            try
            {
                var player = _playerRepository.GetByUsername(username);
                if (player == null)
                {
                    return OperationResponse.Failure(ErrorMessages.UserNotFound);
                }

                var profile = _profileRepository.GetProfileByPlayerId(player.PlayerID);
                if (profile == null)
                {
                    return OperationResponse.Failure(ErrorMessages.ProfileNotFound);
                }

                string uniqueFileName = $"{player.Username}_{Guid.NewGuid()}{Path.GetExtension(fileName)}";
                string filePath = Path.Combine(_imageFolderPath, uniqueFileName);

                File.WriteAllBytes(filePath, imageBytes);

                string imageUrl = Path.Combine("/uploads/avatars", uniqueFileName);
                string absolutePath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, imageUrl.Replace('\\', '/'));


                profile.AvatarURL = absolutePath;
                _profileRepository.Update(profile);
                _profileRepository.Save();

                return OperationResponse.SuccessResult();
            }
            catch (SqlException ex)
            {
                CustomLogger.Error("", ex);
                string errorMessage = SqlErrorHandler.GetErrorMessage(ex);
                return OperationResponse.Failure(errorMessage);
            }
            catch (Exception ex)
            {
                CustomLogger.Error("", ex);
                return OperationResponse.Failure(ErrorMessages.ErrorWhileUpdatingProfilePicture);
            }
        }

        /// <summary>
        /// Updates the username of a user.
        /// </summary>
        /// <param name="currentUsername">The current username of the user.</param>
        /// <param name="newUsername">The new username to set.</param>
        /// <returns>An <see cref="OperationResponse"/> indicating success or failure.</returns>
        public OperationResponse UpdateUsername(string currentUsername, string newUsername)
        {
            try
            {
                if (_playerRepository.GetByUsername(newUsername) != null)
                {
                    return OperationResponse.Failure(ErrorMessages.DuplicateUsername);
                }

                var player = _playerRepository.GetByUsername(currentUsername);
                if (player == null)
                {
                    return OperationResponse.Failure(ErrorMessages.UserNotFound);
                }

                player.Username = newUsername;
                _playerRepository.Update(player);
                _playerRepository.Save();

                return OperationResponse.SuccessResult();
            }
            catch (Exception ex)
            {
                CustomLogger.Error("", ex);
                return OperationResponse.Failure(ErrorMessages.GeneralException);
            }
        }

        /// <summary>
        /// Updates the profile of a user with new data.
        /// </summary>
        /// <param name="username">The username of the user.</param>
        /// <param name="profile">The updated profile data.</param>
        /// <returns>An <see cref="OperationResponse"/> indicating success or failure.</returns>
        public OperationResponse UpdateProfile(string username, Profile profile)
        {
            try
            {
                if (profile == null)
                {
                    return OperationResponse.Failure(ErrorMessages.UserNotFound);
                }

                var player = _playerRepository.GetByUsername(username);
                if (player == null)
                {
                    return OperationResponse.Failure(ErrorMessages.ProfileNotFound);
                }

                profile.PlayerID = player.PlayerID;

                _profileRepository.Update(profile);

                return OperationResponse.SuccessResult();
            }
            catch (Exception ex)
            {
                CustomLogger.Error("Error retrieving profile by username", ex);
                return OperationResponse.Failure(ErrorMessages.GeneralException);
            }
        }

        /// <summary>
        /// Retrieves the profile of a user by their username.
        /// </summary>
        /// <param name="username">The username of the user.</param>
        /// <returns>A <see cref="ProfileResponse"/> containing the profile data or an error message.</returns>
        public ProfileResponse GetProfileByUsername(string username)
        {
            try
            {
                var player = _playerRepository.GetByUsername(username);
                if (player == null)
                {
                    return ProfileResponse.Failure(ErrorMessages.UserNotFound);
                }

                var profile = _profileRepository.GetProfileByPlayerId(player.PlayerID);
                if (profile == null)
                {
                    return ProfileResponse.Failure(ErrorMessages.ProfileNotFound);
                }

                byte[] imageBytes = ConvertImageUrlToBytes(profile.AvatarURL) ?? Array.Empty<byte>();

                var profileDTO = new PlayerProfileDTO
                {
                    FullName = profile.FullName ?? "Anonymous",
                    Bio = profile.Bio ?? "No bio available",
                    JoinDate = profile.JoinDate ?? DateTime.MinValue,
                    SingUpDate = profile.SignUpDate ?? DateTime.MinValue,
                    LastVisit = profile.LastVisit ?? DateTime.MinValue,
                    ProfileImage = imageBytes
                };

                return ProfileResponse.SuccessResult(profileDTO);
            }
            catch (Exception ex)
            {
                CustomLogger.Error("Error retrieving profile by username", ex);
                return ProfileResponse.Failure(ErrorMessages.GeneralException);
            }
        }

        /// <summary>
        /// Retrieves the profile image of a user by their username.
        /// </summary>
        /// <param name="username">The username of the user.</param>
        /// <returns>An <see cref="ImageResponse"/> containing the image data or an error message.</returns>
        public ImageResponse GetProfileImage(string username)
        {
            try
            {
                var player = _playerRepository.GetByUsername(username);
                if (player == null)
                {
                    return ImageResponse.Failure(ErrorMessages.UserNotFound);
                }

                var profile = _profileRepository.GetProfileByPlayerId(player.PlayerID);
                if (profile == null || string.IsNullOrEmpty(profile.AvatarURL))
                {
                    return ImageResponse.Failure(ErrorMessages.ProfileNotFound);
                }

                string normalizedAvatarUrl = profile.AvatarURL.Replace('\\', '/');
                string fileName = Path.GetFileName(normalizedAvatarUrl);
                string imagePath = Path.Combine(_imageFolderPath, fileName);

                if (!File.Exists(imagePath))
                {
                    return ImageResponse.Failure(ErrorMessages.ImageNotFound);
                }

                var imageBytes = File.ReadAllBytes(imagePath);

                if (imageBytes == null || imageBytes.Length == 0)
                {
                    return ImageResponse.Failure(ErrorMessages.EmptyImage);
                }

                return ImageResponse.Success(imageBytes, fileName, "image/jpeg");
            }
            catch (Exception ex)
            {
                CustomLogger.Error("Error retrieving profile image", ex);
                return ImageResponse.Failure(ErrorMessages.GeneralException);
            }
        }

        /// <summary>
        /// Converts an image URL to a byte array.
        /// </summary>
        /// <param name="imageUrl">The URL of the image to convert.</param>
        /// <returns>A byte array containing the image data.</returns>
        /// <exception cref="FileNotFoundException">Thrown if the file is not found.</exception>
        /// <exception cref="UnauthorizedAccessException">Thrown if access to the file is denied.</exception>
        /// <exception cref="IOException">Thrown for general I/O errors.</exception>
        public byte[] ConvertImageUrlToBytes(string imageUrl)
        {
            try
            {
                string filePath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, imageUrl);
                if (File.Exists(filePath))
                {
                    return File.ReadAllBytes(filePath);
                }
                else
                {
                    throw new FileNotFoundException(ErrorMessages.ImageNotFound);
                }
            }
            catch (Exception ex)
            {
                CustomLogger.Error("Error converting image to bytes", ex);
                throw new Exception(ErrorMessages.GeneralException);
            }
        }

        /// <summary>
        /// Updates the biography of a user.
        /// </summary>
        /// <param name="bio">The new biography text.</param>
        /// <param name="username">The username of the user.</param>
        /// <returns>An <see cref="OperationResponse"/> indicating success or failure.</returns>
        public OperationResponse UpdateBio(string bio, string username)
        {
            try
            {
                var player = _playerRepository.GetByUsername(username);
                var profile = _profileRepository.GetProfileByPlayerId(player.PlayerID);
                if (player == null)
                {
                    return OperationResponse.Failure(ErrorMessages.UserNotFound);
                }

                profile.Bio = bio;
                _profileRepository.Update(profile);
                _profileRepository.Save();

                return OperationResponse.SuccessResult();
            }
            catch (Exception ex)
            {
                CustomLogger.Error("", ex);
                return OperationResponse.Failure(ErrorMessages.GeneralException);
            }
        }

        /// <summary>
        /// Retrieves the biography of a user by their username.
        /// </summary>
        /// <param name="username">The username of the user.</param>
        /// <returns>The biography text, or an error message if not found.</returns>
        public string GetBioByUsername(string username)
        {
            try
            {
                var player = _playerRepository.GetByUsername(username);
                if (player == null)
                {
                    return "User not found.";
                }

                var profile = _profileRepository.GetProfileByPlayerId(player.PlayerID);
                if (profile == null)
                {
                    return "Profile not found.";
                }

                return profile.Bio ?? "No biography available.";
            }
            catch (Exception ex)
            {
                CustomLogger.Error("Error retrieving biography", ex);
                return "Error retrieving biography.";
            }
        }
    }
}
