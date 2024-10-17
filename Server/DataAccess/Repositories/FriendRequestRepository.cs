using DataAccess.Utilities;
using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Data.SqlClient;
using System.Linq;


namespace DataAccess.Repositories
{
    public class FriendRequestRepository : IFriendRequestRepository
    {
        private readonly BMCEntities _context;

        public FriendRequestRepository(BMCEntities context)
        {
            _context = context;
        }

        public void AcceptRequest(int requestId)
        {
            try
            {
                var request = _context.FriendRequest.SingleOrDefault(r => r.RequestID == requestId);

                if (request == null)
                {
                    throw new InvalidOperationException($"No friend request found with ID {requestId}.");
                }

                request.RequestStatus = "Accepted";
                _context.SaveChanges();
            }
            catch (DbUpdateException ex)
            {
                throw new DataAccessException("Error occurred while updating the database during request acceptance.", ex);
            }
            catch (SqlException)
            {
                throw;
            }
            catch (Exception ex)
            {
                throw new DataAccessException("An unexpected error occurred while accepting the friend request.", ex);
            }
        }

        public IEnumerable<Player> GetAcceptedFriends(int playerId)
        {
            if (playerId <= 0)
            {
                throw new ArgumentException("Player ID must be greater than zero.", nameof(playerId));
            }

            try
            {
                var acceptedRequests = _context.FriendRequest
                    .Where(r => (r.SenderPlayerID == playerId || r.ReceiverPlayerID == playerId) && r.RequestStatus == "Accepted")
                    .Select(r => r.SenderPlayerID == playerId ? r.Player : r.Player1)
                    .ToList();

                return acceptedRequests;
            }
            catch (SqlException)
            {
                throw;
            }
            catch (InvalidOperationException ex)
            {
                throw new DataAccessException("Invalid operation while retrieving accepted friends.", ex);
            }
            catch (Exception ex)
            {
                throw new DataAccessException("An unexpected error occurred while retrieving accepted friends.", ex);
            }
        }

        public IEnumerable<FriendRequest> GetReceivedRequests(int receiverPlayerId)
        {
            try
            {
                return _context.FriendRequest.Where(r => r.ReceiverPlayerID == receiverPlayerId).ToList();
            }
            catch (SqlException)
            {
                throw;
            }
            catch (Exception ex)
            {
                throw new DataAccessException("An unexpected error occurred while retrieving received friend requests.", ex);
            }
        }

        public IEnumerable<FriendRequest> GetSentRequests(int senderPlayerId)
        {
            try
            {
                return _context.FriendRequest.Where(r => r.SenderPlayerID == senderPlayerId).ToList();
            }
            catch (SqlException)
            {
                throw;
            }
            catch (Exception ex)
            {
                throw new DataAccessException("An unexpected error occurred while retrieving sent friend requests.", ex);
            }
        }

        public bool IsFriendRequestPending(int senderPlayerId, int receiverPlayerId)
        {
            try
            {
                return _context.FriendRequest.Any(r =>
                    r.SenderPlayerID == senderPlayerId &&
                    r.ReceiverPlayerID == receiverPlayerId &&
                    r.RequestStatus == "Pending");
            }
            catch (SqlException)
            {
                throw;
            }
            catch (Exception ex)
            {
                throw new DataAccessException("An unexpected error occurred while checking for pending friend request.", ex);
            }
        }

        public void RejectRequest(int requestId)
        {
            try
            {
                var request = _context.FriendRequest.SingleOrDefault(r => r.RequestID == requestId);

                if (request == null)
                {
                    throw new InvalidOperationException($"No friend request found with ID {requestId}.");
                }

                request.RequestStatus = "Rejected";
                _context.SaveChanges();
            }
            catch (DbUpdateException ex)
            {
                throw new DataAccessException("Error occurred while updating the database during request rejection.", ex);
            }
            catch (SqlException)
            {
                throw;
            }
            catch (Exception ex)
            {
                throw new DataAccessException("An unexpected error occurred while rejecting the friend request.", ex);
            }
        }

        public void RemoveFriend(int userId, int friendId)
        {
            try
            {
                var acceptedRequest = _context.FriendRequest
                    .FirstOrDefault(r =>
                        ((r.SenderPlayerID == userId && r.ReceiverPlayerID == friendId) ||
                        (r.SenderPlayerID == friendId && r.ReceiverPlayerID == userId)) &&
                        r.RequestStatus == "Accepted");

                if (acceptedRequest == null)
                {
                    throw new InvalidOperationException("No accepted friend request found between these users.");
                }

                _context.FriendRequest.Remove(acceptedRequest);
                _context.SaveChanges();
            }
            catch (DbUpdateException ex)
            {
                throw new DataAccessException("Error occurred while updating the database during friend removal.", ex);
            }
            catch (SqlException)
            {
                throw;
            }
            catch (Exception ex)
            {
                throw new DataAccessException("An unexpected error occurred while removing the friend.", ex);
            }
        }

        public void SendFriendRequest(int senderPlayerId, int receiverPlayerId)
        {
            try
            {
                var newRequest = new FriendRequest
                {
                    SenderPlayerID = senderPlayerId,
                    ReceiverPlayerID = receiverPlayerId,
                    RequestStatus = "Pending"
                };

                _context.FriendRequest.Add(newRequest);
                _context.SaveChanges();
            }
            catch (DbUpdateException ex)
            {
                throw new DataAccessException("Error occurred while updating the database during friend request creation.", ex);
            }
            catch (SqlException)
            {
                throw;
            }
            catch (Exception ex)
            {
                throw new DataAccessException("An unexpected error occurred while creating the friend request.", ex);
            }
        }
    }
}
