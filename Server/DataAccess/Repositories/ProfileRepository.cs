﻿using DataAccess.Utilities;
using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Repositories
{
    public class ProfileRepository : IProfileRepository
    {
        private readonly BMCEntities _context;

        public ProfileRepository(BMCEntities context)
        {
            _context = context ?? throw new ArgumentNullException(nameof(context), "Database context cannot be null.");
        }

        public Profile GetProfileByPlayerId(int playerId)
        {
            if (playerId <= 0)
            {
                throw new ArgumentException("Player ID must be greater than zero.", nameof(playerId));
            }

            try
            {
                return _context.Profile.SingleOrDefault(p => p.PlayerID == playerId);
            }
            catch (SqlException ex)
            {
                throw new DataAccessException("An error occurred while retrieving the profile by player ID.", ex);
            }
            catch (Exception ex)
            {
                throw new DataAccessException("Unexpected error while retrieving the profile.", ex);
            }
        }

        public void Add(Profile profile)
        {
            if (profile == null)
            {
                throw new ArgumentNullException(nameof(profile), "Profile cannot be null.");
            }

            try
            {
                _context.Profile.Add(profile);
            }
            catch (DbUpdateException ex)
            {
                throw new DataAccessException("Error occurred while creating the profile.", ex);
            }
            catch (SqlException ex)
            {
                throw new DataAccessException("SQL error occurred while creating the profile.", ex);
            }
            catch (Exception ex)
            {
                throw new DataAccessException("Unexpected error while creating the profile.", ex);
            }
        }

        public void Update(Profile profile)
        {
            if (profile == null)
            {
                throw new ArgumentNullException(nameof(profile), "Profile cannot be null.");
            }

            try
            {
                _context.Entry(profile).State = System.Data.Entity.EntityState.Modified;
            }
            catch (DbUpdateException ex)
            {
                throw new DataAccessException("Error occurred while updating the profile.", ex);
            }
            catch (SqlException ex)
            {
                throw new DataAccessException("SQL error occurred while updating the profile.", ex);
            }
            catch (Exception ex)
            {
                throw new DataAccessException("Unexpected error while updating the profile.", ex);
            }
        }

        public void SetLastVisit(int playerId, DateTime lastVisitDate)
        {
            if (playerId <= 0)
            {
                throw new ArgumentException("Player ID must be greater than zero.", nameof(playerId));
            }

            try
            {
                var profile = GetProfileByPlayerId(playerId);
                if (profile != null)
                {
                    profile.LastVisit = lastVisitDate;
                    Update(profile);
                }
            }
            catch (SqlException ex)
            {
                throw new DataAccessException("Error occurred while setting last visit date.", ex);
            }
        }

        public void SetStatus(int playerId, int statusId)
        {
            if (playerId <= 0)
            {
                throw new ArgumentException("Player ID must be greater than zero.", nameof(playerId));
            }

            try
            {
                var profile = GetProfileByPlayerId(playerId);
                if (profile != null)
                {
                    profile.StatusID = statusId;
                    Update(profile);
                }
            }
            catch (SqlException ex)
            {
                throw new DataAccessException("Error occurred while setting status ID.", ex);
            }
        }

        public void Save()
        {
            _context.SaveChanges();
        }
    }
}
