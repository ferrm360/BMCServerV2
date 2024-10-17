using DataAccess;
using Service.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service.Utilities.Mapper
{
    public class PlayerMapper
    {
        public static PlayerDTO ToDTO(Player player)
        {
            return new PlayerDTO
            {
                PlayerID = player.PlayerID,
                Username = player.Username,
                Email = player.Email
            };
        }

        public static Player ToEntity(PlayerDTO playerDTO, string passwordHash)
        {
            return new Player
            {
                PlayerID = playerDTO.PlayerID,
                Username = playerDTO.Username,
                Email = playerDTO.Email,
                PasswordHash = passwordHash
            };
        }
    }
}
