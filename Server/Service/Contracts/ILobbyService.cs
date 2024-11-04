using Service.DTO;
using Service.Utilities.Results;
using System.Collections.Generic;
using System.ServiceModel;

namespace Service.Contracts
{
    [ServiceContract]
    public interface ILobbyService
    {
        [OperationContract]
        LobbyResponse CreateLobby(CreateLobbyRequestDTO request);
        [OperationContract]
        LobbyResponse JoinLobby(JoinLobbyRequestDTO request);
        [OperationContract]
        List<LobbyDTO> GetAllLobbies();
        [OperationContract]
        LobbyResponse LeaveLobby(string lobbyId, string username);
        [OperationContract]
        LobbyResponse KickPlayer(string lobbyId, string hostUsername, string targetUsername);
    }
}
