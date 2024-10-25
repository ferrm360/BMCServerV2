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

        // TODO: Poner en utilidades
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
    }
}
