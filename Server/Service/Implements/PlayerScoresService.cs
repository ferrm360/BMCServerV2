using DataAccess.Repositories;
using Service.Contracts;
using Service.DTO;
using Service.Results;
using Service.Utilities.Constans;
using Service.Utilities.Helpers;
using Service.Utilities.Results;
using System;
using System.Data.SqlClient;

namespace Service.Implements
{
    public class PlayerScoresService : IPlayerScoresService
    {
        private readonly IPlayerScoresRepository _scoreRepository;
        private readonly IPlayerRepository _playerRepository;

        public PlayerScoresService(
            IPlayerScoresRepository scoreRepository,
            IPlayerRepository playerRepository)
        {
            _scoreRepository = scoreRepository;
            _playerRepository = playerRepository;
        }

        public PlayerScoresResponse GetScoresByUsername(string username)
        {
            try
            {
                var player = _playerRepository.GetByUsername(username);
                if (player == null)
                {
                    return PlayerScoresResponse.Failure(ErrorMessages.UserNotFound);
                }

                var scores = _scoreRepository.GetScoresByPlayerId(player.PlayerID);
                if (scores == null)
                {
                    return PlayerScoresResponse.Failure(ErrorMessages.ScoreNotFound);
                }

                var scoresDto = new PlayerScoresDTO
                {
                    PlayerId = scores.PlayerID,
                    Wins = scores.Wins,
                    Losses = scores.Losses
                };

                return PlayerScoresResponse.SuccessResult(scoresDto);
            }
            catch (SqlException ex)
            {
                string errorMessage = SqlErrorHandler.GetErrorMessage(ex);
                return PlayerScoresResponse.Failure(errorMessage);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Unexpected error: {ex.Message}");
                return PlayerScoresResponse.Failure(ErrorMessages.GeneralException);
            }
        }

        public OperationResponse IncrementWins(string username)
        {
            try
            {
                var player = _playerRepository.GetByUsername(username);
                if (player == null)
                {
                    return OperationResponse.Failure(ErrorMessages.UserNotFound);
                }

                _scoreRepository.IncrementWins(player.PlayerID);
                _scoreRepository.Save();

                return OperationResponse.SuccessResult("Win incremented successfully.");
            }
            catch (SqlException ex)
            {
                string errorMessage = SqlErrorHandler.GetErrorMessage(ex);
                return OperationResponse.Failure(errorMessage);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Unexpected error: {ex.Message}");
                return OperationResponse.Failure(ErrorMessages.GeneralException);
            }
        }

        public OperationResponse IncrementLosses(string username)
        {
            try
            {
                var player = _playerRepository.GetByUsername(username);
                if (player == null)
                {
                    return OperationResponse.Failure(ErrorMessages.UserNotFound);
                }

                _scoreRepository.IncrementLosses(player.PlayerID);
                _scoreRepository.Save();

                return OperationResponse.SuccessResult("Loss incremented successfully.");
            }
            catch (SqlException ex)
            {
                string errorMessage = SqlErrorHandler.GetErrorMessage(ex);
                return OperationResponse.Failure(errorMessage);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Unexpected error: {ex.Message}");
                return OperationResponse.Failure(ErrorMessages.GeneralException);
            }
        }
    }
}
