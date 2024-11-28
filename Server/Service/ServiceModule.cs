using Autofac;
using DataAccess.Repositories;
using Service.Implements;
using Service.Contracts;
using DataAccess;
using Service.Utilities.Validators;
using Service.Connection.Managers;

namespace Service
{
    public class ServiceModule : Module
    {
        protected override void Load(ContainerBuilder builder)
        {
            builder.RegisterType<ProfileService>().As<IProfileService>().InstancePerLifetimeScope();
            builder.RegisterType<AccountService>().As<IAccountService>().InstancePerLifetimeScope();
            builder.RegisterType<FriendshipService>().As<IFriendshipService>().InstancePerLifetimeScope();
            builder.RegisterType<ChatService>().As<IChatService>().SingleInstance();
            builder.RegisterType<LobbyService>().As<ILobbyService>().SingleInstance();
            builder.RegisterType<ChatFriendService>().As<IChatFriendService>().SingleInstance();
            builder.RegisterType<PlayerScoresService>().As<IPlayerScoresService>().InstancePerLifetimeScope();
            builder.RegisterType<GameService>().As<IGameService>().SingleInstance();
            builder.RegisterType<ChatLobbyService>().As<IChatLobbyService>().SingleInstance();


            builder.RegisterType<PlayerRepository>().As<IPlayerRepository>().InstancePerLifetimeScope();
            builder.RegisterType<ProfileRepository>().As<IProfileRepository>().InstancePerLifetimeScope();
            builder.RegisterType<PlayerScoresRepository>().As<IPlayerScoresRepository>().InstancePerLifetimeScope();
            builder.RegisterType<FriendRequestRepository>().As<IFriendRequestRepository>().InstancePerLifetimeScope();
            builder.RegisterType<ChatMessagesRepository>().As<IChatMessagesRepository>().InstancePerLifetimeScope();
            builder.RegisterType<PlayerScoresRepository>().As<IPlayerScoresRepository>().InstancePerLifetimeScope();
            builder.RegisterType<GuestPlayerService>().As<IGuestPlayerService>().InstancePerLifetimeScope();



            builder.RegisterType<ValidationFriendshipService>().AsSelf().InstancePerLifetimeScope();

            builder.RegisterType<BMCEntities>().AsSelf().InstancePerLifetimeScope();

            builder.RegisterType<ConnectionManager>().AsSelf().SingleInstance();

            builder.RegisterType<ConnectionEventHandler>().AsSelf().SingleInstance();
        }
    }
}
