using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service.Utilities.Constans
{
    public static class ErrorMessages
    {
        public const string GeneralException = "Error.GeneralException";    
        public const string DuplicateUsername = "Error.DuplicateUsername";
        public const string DuplicateEmail = "Error.DuplicateEmail";
        public const string UserNotFound = "Error.UserNotFound";
        public const string InvalidPassword = "Error.InvalidPassword";
        public const string DifferentPassword = "Error.DifferentPassword";
        public const string ProfileNotFound = "Error.ProfileNotFound";
        public const string InvalidEmail = "Error.InvalidEmail";
        public const string InvalidUsername = "Error.InvalidUsername";
        public const string ImageNotFound = "Error.ImageNotFound";
        public const string EmptyImage = "Error.EmptyImage";
        public const string InvalidProfileData = "Error.InvalidProfileData";
        public const string ErrorWhileUpdatingProfile = "Error.ErrorWhileUpdatingProfile";
        public const string ErrorWhileUpdatingProfilePicture = "Error.ErrorWhileUpdatingProfilePicture";
        public const string InvalidBio = "Error.InvalidBio";
    }
}
