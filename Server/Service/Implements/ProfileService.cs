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
                return OperationResponse.Failure("Error while updating profile picture: " + ex.Message);
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
                    return OperationResponse.Failure("Invalid profile data.");
                }

                var player = _playerRepository.GetByUsername(username);
                if (player == null)
                {
                    return OperationResponse.Failure("User not found.");
                }

                profile.PlayerID = player.PlayerID;

                _profileRepository.Update(profile);

                return OperationResponse.SuccessResult();
            }
            catch (Exception ex)
            {
                return OperationResponse.Failure("Error while updating profile: " + ex.Message);
            }
        }

        public ProfileResponse GetProfileByUsername(string username)
        {
            try
            {
                var player = _playerRepository.GetByUsername(username);
                if (player == null)
                {
                    return ProfileResponse.Failure("User not found.");
                }

                var profile = _profileRepository.GetProfileByPlayerId(player.PlayerID);
                if (profile == null)
                {
                    return ProfileResponse.Failure("Profile not found.");
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
                return ProfileResponse.Failure("An unexpected error occurred.");
            }
        }


        public ImageResponse GetProfileImage(string username)
        {
            try
            {
                var player = _playerRepository.GetByUsername(username);
                if (player == null)
                {
                    return ImageResponse.Failure("User not found.");
                }

                var profile = _profileRepository.GetProfileByPlayerId(player.PlayerID);
                if (profile == null || string.IsNullOrEmpty(profile.AvatarURL))
                {
                    return ImageResponse.Failure("Profile or Avatar not found.");
                }

                var imageBytes = ConvertImageUrlToBytes(profile.AvatarURL);
                if (imageBytes == null || imageBytes.Length == 0)
                {
                    return ImageResponse.Failure("Image not found or is empty.");
                }

                return ImageResponse.Success(imageBytes, Path.GetFileName(profile.AvatarURL), "image/jpeg");
            }
            catch (Exception ex)
            {
                CustomLogger.Error("Error retrieving profile image", ex);
                return ImageResponse.Failure("Error retrieving profile image.");
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
                    throw new FileNotFoundException("Image file not found.");
                }
            }
            catch (Exception ex)
            {
                CustomLogger.Error("Error converting image to bytes", ex);
                throw new Exception("Error converting image.");
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
