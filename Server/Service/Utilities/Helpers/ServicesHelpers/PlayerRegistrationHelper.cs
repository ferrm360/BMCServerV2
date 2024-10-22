using DataAccess.Repositories;
using DataAccess;
using Service.DTO;
using Service.Utilities.Mapper;
using System;
using System.Transactions;


namespace Service.Utilities.Helpers.ServicesHelpers
{
    public class PlayerRegistrationHelper
    {
        private readonly IPlayerRepository _playerRepository;
        private readonly IProfileRepository _profileRepository;
        private readonly IPlayerScoresRepository _scoreRepository;

        public PlayerRegistrationHelper(
            IPlayerRepository playerRepository,
            IProfileRepository profileRepository,
            IPlayerScoresRepository scoreRepository)
        {
            _playerRepository = playerRepository;
            _profileRepository = profileRepository;
            _scoreRepository = scoreRepository;
        }

        public void RegisterPlayer(PlayerDTO playerDTO)
        {
            using (var transaction = new TransactionScope())
            {
                try
                {
                    string passwordHash = PasswordHelper.HashPassword(playerDTO.Password);
                    var playerEntity = PlayerMapper.ToEntity(playerDTO, passwordHash);
                    _playerRepository.Add(playerEntity);

                    _playerRepository.Save();

                    var profileEntity = new Profile
                    {
                        PlayerID = playerEntity.PlayerID,
                        JoinDate = DateTime.UtcNow,
                        StatusID = 1,
                    };
                    _profileRepository.Add(profileEntity);

                    var playerScoresEntity = new PlayerScores
                    {
                        PlayerID = playerEntity.PlayerID,
                        Wins = 0,
                        Losses = 0
                    };
                    _scoreRepository.AddPlayerScores(playerScoresEntity);

                    transaction.Complete();
                }
                catch (Exception ex)
                {
                    throw new InvalidOperationException("Error during player registration.", ex);
                }
            }
        }
    }
}
