﻿using DataAccess;
using DataAccess.Repositories;
using Service.Contracts;
using Service.DTO;
using Service.Results;
using Service.Utilities.Helpers;
using Service.Utilities.Mapper;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service.Implements
{
    public class ProfileService : IProfileService
    {
        private readonly IPlayerRepository _playerRepository;

        public ProfileService() 
        {
            var context = new BMCEntities();
            _playerRepository = new PlayerRepository(context);
        }

       

        public OperationResult UpdatePassword(string username, string newPassword, string oldPassword)
        {
            try
            {
                var player = _playerRepository.GetByUsername(username);
                bool isPasswordValid = PasswordHelper.VerifyPassword(oldPassword, player.PasswordHash);
                if (!isPasswordValid)
                {
                    return OperationResult.Failure("Error.InvalidPassword");
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
            
        }

        public OperationResult UpdateProfilePicture(string url)
        {
            throw new NotImplementedException();
        }

        public OperationResult UpdateUsername(string currentUsername, string newUsername)
        {
            throw new NotImplementedException();
        }
    }
}
