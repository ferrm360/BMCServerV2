﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DataAccess
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class BMCEntities : DbContext
    {
        public BMCEntities()
            : base("name=BMCEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<ChatMessages> ChatMessages { get; set; }
        public virtual DbSet<FriendRequest> FriendRequest { get; set; }
        public virtual DbSet<GameLobby> GameLobby { get; set; }
        public virtual DbSet<GuestPlayers> GuestPlayers { get; set; }
        public virtual DbSet<LobbyPlayers> LobbyPlayers { get; set; }
        public virtual DbSet<PasswordResetRequests> PasswordResetRequests { get; set; }
        public virtual DbSet<Player> Player { get; set; }
        public virtual DbSet<Profile> Profile { get; set; }
        public virtual DbSet<UserScores> UserScores { get; set; }
    }
}
