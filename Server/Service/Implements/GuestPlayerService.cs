using DataAccess.Repositories;
using Service.Connection.Managers;
using Service.Results;
using Service.Utilities.Constans;
using Service.Utilities.Helpers;
using Service.Utilities;
using Service.Utilities.Results;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;
using Service.Contracts;

namespace Service.Implements
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.PerSession, ConcurrencyMode = ConcurrencyMode.Multiple)]
    public class GuestPlayerService : IGuestPlayerService
    {
        private readonly IPlayerRepository _playerRepository;
        private readonly ConnectionManager _connectionManager;
        private readonly ConnectionEventHandler _connectionEventHandler;


        public GuestPlayerService(
            IPlayerRepository playerRepository,
            ConnectionManager connectionManager,
            ConnectionEventHandler connectionEventHandler)
        {
            _playerRepository = playerRepository;
            _connectionManager = connectionManager;
            _connectionEventHandler = connectionEventHandler;
        }

        public OperationResponse RegisterGuestPlayer(string username)
        {
            if (string.IsNullOrWhiteSpace(username))
                return OperationResponse.Failure(ErrorMessages.InvalidUsername);

            if (_connectionManager.IsUserRegistered(username))
                return OperationResponse.Failure(ErrorMessages.UserAlreadyConnected);

            try
            {
                var existingPlayer = _playerRepository.GetByUsername(username);
                if (existingPlayer != null)
                    return OperationResponse.Failure(ErrorMessages.DuplicateUsername);

                if (OperationContext.Current?.Channel is IContextChannel channel)
                {
                    bool registered = _connectionManager.RegisterUser(username, channel);
                    if (!registered)
                        return OperationResponse.Failure(ErrorMessages.UserAlreadyConnected);

                    _connectionEventHandler.RegisterChannelEvents(username, channel);
                }

                return OperationResponse.SuccessResult();
            }
            catch (SqlException ex)
            {
                CustomLogger.Error("SQL error during guest player registration", ex);
                string errorMessage = SqlErrorHandler.GetErrorMessage(ex);
                return OperationResponse.Failure(errorMessage);
            }
            catch (Exception ex)
            {
                CustomLogger.Fatal("Unexpected error during guest player registration", ex);
                return OperationResponse.Failure(ErrorMessages.GeneralException);
            }
        }

    }
}
