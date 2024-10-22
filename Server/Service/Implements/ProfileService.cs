using DataAccess;
using DataAccess.Repositories;
using Service.Contracts;
using Service.DTO;
using Service.Results;
using Service.Utilities.Constans;
using Service.Utilities.Helpers;
using Service.Utilities.Mapper;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service.Implements
{
    public class ProfileService : IProfileService
    {
        private readonly IPlayerRepository _playerRepository;
        private readonly IProfileRepository _profileRepository;
        private readonly string _imageFolderPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "uploads", "avatars");

        public ProfileService(IPlayerRepository playerRepository, IProfileRepository profileRepository)
        {
            _playerRepository = playerRepository;
            _profileRepository = profileRepository;

            if (!Directory.Exists(_imageFolderPath))
            {
                Directory.CreateDirectory(_imageFolderPath);
            }
        }

        public OperationResult UpdatePassword(string username, string newPassword, string oldPassword)
        {
            try
            {
                var player = _playerRepository.GetByUsername(username);
                bool isPasswordValid = PasswordHelper.VerifyPassword(oldPassword, player.PasswordHash);
                if (!isPasswordValid)
                {
                    return OperationResult.Failure(ErrorMessages.DifferentPassword);
                }
                PlayerDTO playerDTO = new PlayerDTO();
                playerDTO.Password = newPassword;
                string passwordHash = PasswordHelper.HashPassword(newPassword);
                _playerRepository.UpdatePasswordHash(username, passwordHash);
                return OperationResult.SuccessResult();

            }
            catch (SqlException ex)
            {
                string errorMessage = SqlErrorHandler.GetErrorMessage(ex);
                return OperationResult.Failure(errorMessage);
            }
            catch (Exception ex)
            {
                return OperationResult.Failure(ErrorMessages.GeneralException);
            }
            
        }

        public OperationResult UpdateProfilePicture(string username, byte[] imageBytes, string fileName)
        {
            try
            {
                var player = _playerRepository.GetByUsername(username);
                if (player == null)
                {
                    return OperationResult.Failure(ErrorMessages.UserNotFound);
                }

                var profile = _profileRepository.GetProfileByPlayerId(player.PlayerID);
                if (profile == null)
                {
                    return OperationResult.Failure(ErrorMessages.ProfileNotFound);
                }

                string uniqueFileName = $"{player.Username}_{Guid.NewGuid()}{Path.GetExtension(fileName)}";
                string filePath = Path.Combine(_imageFolderPath, uniqueFileName);

                File.WriteAllBytes(filePath, imageBytes);

                string imageUrl = Path.Combine("/uploads/avatars", uniqueFileName);

                profile.AvatarURL = imageUrl;
                _profileRepository.Update(profile);
                _profileRepository.Save();

                return OperationResult.SuccessResult();
            }
            catch (SqlException ex)
            {
                string errorMessage = SqlErrorHandler.GetErrorMessage(ex);
                return OperationResult.Failure(errorMessage);
            }
            catch (Exception ex)
            {
                return OperationResult.Failure("Error while updating profile picture: " + ex.Message);
            }
        }

        public OperationResult UpdateUsername(string currentUsername, string newUsername)
        {
            try
            {
                if (_playerRepository.GetByUsername(newUsername) != null)
                {
                    return OperationResult.Failure(ErrorMessages.DuplicateUsername);
                }

                var player = _playerRepository.GetByUsername(currentUsername);
                if (player == null)
                {
                    return OperationResult.Failure(ErrorMessages.UserNotFound);
                }

                player.Username = newUsername;
                _playerRepository.Update(player);
                _playerRepository.Save();

                return OperationResult.SuccessResult();
            }
            catch (Exception ex)
            {
                return OperationResult.Failure(ErrorMessages.GeneralException);
            }
        }

        public OperationResult UpdateProfile(string username, Profile profile)
        {
            try
            {
                if (profile == null)
                {
                    return OperationResult.Failure("Invalid profile data.");
                }

                var player = _playerRepository.GetByUsername(username);
                if (player == null)
                {
                    return OperationResult.Failure("User not found.");
                }

                profile.PlayerID = player.PlayerID;

                _profileRepository.Update(profile);

                return OperationResult.SuccessResult();
            }
            catch (Exception ex)
            {
                return OperationResult.Failure("Error while updating profile: " + ex.Message);
            }
        }
    }
}
