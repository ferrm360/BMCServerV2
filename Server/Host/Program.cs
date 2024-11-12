using System;
using System.ServiceModel;
using Autofac;
using Autofac.Integration.Wcf;
using log4net;
using log4net.Config;
using Service;
using Service.Contracts;
using Service.Implements;

namespace Host
{
    public class Program
    {
        private static readonly ILog logger = LogManager.GetLogger(typeof(Program));

        static void Main(string[] args)
        {
            XmlConfigurator.Configure();
            logger.Info("Initializing the service host.");
            Console.WriteLine("Initializing services, press Enter to continue...");
            Console.ReadLine();

            var container = ConfigureAutofac();

            try
            {
                using (var scope = container.BeginLifetimeScope())
                {
                    var services = new[]
                    {
                        new ServiceDefinition(typeof(AccountService), typeof(IAccountService), "AccountService"),
                        new ServiceDefinition(typeof(ProfileService), typeof(IProfileService), "ProfileService"),
                        new ServiceDefinition(typeof(FriendshipService), typeof(IFriendshipService), "FriendshipService"),
                        new ServiceDefinition(typeof(ChatService), typeof(IChatService), "ChatService"),
                        new ServiceDefinition(typeof(LobbyService), typeof(ILobbyService), "LobbyService"),
                        new ServiceDefinition(typeof(ChatFriendService), typeof(IChatFriendService), "ChatFriendService"),
                        new ServiceDefinition(typeof(PlayerScoresService), typeof(IPlayerScoresService), "PlayerScoresService")
                    };

                    StartServices(services, scope);

                    Console.WriteLine("All services are running. Press Enter to stop the services.");
                    Console.ReadLine();
                }
            }
            catch (Exception ex)
            {
                logger.Fatal("An unexpected error occurred: " + ex);
                Console.WriteLine("Error: " + ex.Message);
            }
            finally
            {
                logger.Info("The service host has been closed.");
                Console.WriteLine("Services terminated. Press Enter to exit.");
                Console.ReadLine();
            }
        }

        private static void StartServices(ServiceDefinition[] services, ILifetimeScope scope)
        {
            foreach (var service in services)
            {
                try
                {
                    var serviceHost = new ServiceHost(service.ServiceType);
                    serviceHost.AddDependencyInjectionBehavior(service.ContractType, scope);
                    serviceHost.Open();

                    Console.WriteLine($"{service.DisplayName} is running. ✓");
                }
                catch (Exception ex)
                {
                    logger.Error($"Error setting up {service.DisplayName}: {ex.Message}");
                    Console.WriteLine($"{service.DisplayName} failed to start. ✗");
                }
            }
        }

        private static IContainer ConfigureAutofac()
        {
            var builder = new ContainerBuilder();
            builder.RegisterModule<ServiceModule>();
            return builder.Build();
        }

        private class ServiceDefinition
        {
            public Type ServiceType { get; }
            public Type ContractType { get; }
            public string DisplayName { get; }

            public ServiceDefinition(Type serviceType, Type contractType, string displayName)
            {
                ServiceType = serviceType;
                ContractType = contractType;
                DisplayName = displayName;
            }
        }
    }
}
