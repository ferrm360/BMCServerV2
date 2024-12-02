using Autofac;
using Service;

namespace Host.Utilities
{
    public static class AutofacContainer
    {
        public static IContainer Configure()
        {
            var builder = new ContainerBuilder();

            builder.RegisterModule<ServiceModule>();

            builder.RegisterType<ServiceManager>().AsSelf().InstancePerLifetimeScope();

            return builder.Build();
        }
    }
}
