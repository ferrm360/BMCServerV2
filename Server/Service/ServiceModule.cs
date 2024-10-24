using Autofac;
using DataAccess.Repositories;
using Service.Implements;
using Service.Contracts;
using DataAccess;
using Service.Utilities.Validators;

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


            builder.RegisterType<PlayerRepository>().As<IPlayerRepository>().InstancePerLifetimeScope();
            builder.RegisterType<ProfileRepository>().As<IProfileRepository>().InstancePerLifetimeScope();
            builder.RegisterType<PlayerScoresRepository>().As<IPlayerScoresRepository>().InstancePerLifetimeScope();
            builder.RegisterType<FriendRequestRepository>().As<IFriendRequestRepository>().InstancePerLifetimeScope();

            builder.RegisterType<ValidationFriendshipService>().AsSelf().InstancePerLifetimeScope();

            builder.RegisterType<BMCEntities>().AsSelf().InstancePerLifetimeScope();
        }
    }
}
