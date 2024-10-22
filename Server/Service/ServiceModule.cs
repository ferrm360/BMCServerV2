using Autofac;
using DataAccess.Repositories;
using Service.Implements;
using DataAccess;
using Service.Contracts;

namespace Service
{
    public class ServiceModule : Module
    {
        protected override void Load(ContainerBuilder builder)
        {
            // Registrar el contexto de Entity Framework
            builder.RegisterType<BMCEntities>().AsSelf().InstancePerLifetimeScope();

            // Registrar los repositorios
            builder.RegisterType<PlayerRepository>().As<IPlayerRepository>().InstancePerLifetimeScope();
            builder.RegisterType<ProfileRepository>().As<IProfileRepository>().InstancePerLifetimeScope();
            builder.RegisterType<PlayerScoresRepository>().As<IPlayerScoresRepository>().InstancePerLifetimeScope();

            // Registrar los servicios
            builder.RegisterType<AccountService>().As<IAccountService>().InstancePerLifetimeScope();

            // Registrar cualquier otro servicio
            // builder.RegisterType<OtherService>().As<IOtherService>().InstancePerLifetimeScope();
        }
    }
}
