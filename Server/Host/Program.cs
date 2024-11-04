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
                    // Iniciar AccountService
                    try
                    {
                        var accountServiceHost = new ServiceHost(typeof(AccountService));
                        accountServiceHost.AddDependencyInjectionBehavior<IAccountService>(scope);
                        accountServiceHost.Open();
                        Console.WriteLine("AccountService is running.");
                    }
                    catch (Exception ex)
                    {
                        logger.Error("Error setting up AccountService: " + ex.Message);
                    }

                    // Iniciar ProfileService
                    try
                    {
                        var profileServiceHost = new ServiceHost(typeof(ProfileService));
                        profileServiceHost.AddDependencyInjectionBehavior<IProfileService>(scope);
                        profileServiceHost.Open();
                        Console.WriteLine("ProfileService is running.");
                    }
                    catch (Exception ex)
                    {
                        logger.Error("Error setting up ProfileService: " + ex.Message);
                    }

                    // Iniciar FriendshipService
                    try
                    {
                        var friendshipServiceHost = new ServiceHost(typeof(FriendshipService));
                        friendshipServiceHost.AddDependencyInjectionBehavior<IFriendshipService>(scope);
                        friendshipServiceHost.Open();
                        Console.WriteLine("FriendshipService is running.");
                    }
                    catch (Exception ex)
                    {
                        logger.Error("Error setting up FriendshipService: " + ex.Message);
                    }

                    // Iniciar ChatService
                    try
                    {
                        var chatServiceHost = new ServiceHost(typeof(ChatService));
                        chatServiceHost.AddDependencyInjectionBehavior<IChatService>(scope);
                        chatServiceHost.Open();
                        Console.WriteLine("ChatService is running.");
                    }
                    catch (Exception ex)
                    {
                        logger.Error("Error setting up ChatService: " + ex.Message);
                    }

                    try
                    {
                        var lobbyServiceHost = new ServiceHost(typeof(LobbyService));
                        lobbyServiceHost.AddDependencyInjectionBehavior<ILobbyService>(scope);
                        lobbyServiceHost.Open();
                        Console.WriteLine("LobbyService is running.");
                    }
                    catch (Exception ex)
                    {
                        logger.Error("Error setting up LobbyService: " + ex.Message);
                    }

                    try
                    {
                        var chatFriendServiceHost = new ServiceHost(typeof(ChatFriendService));
                        chatFriendServiceHost.AddDependencyInjectionBehavior<IChatFriendService>(scope);
                        chatFriendServiceHost.Open();
                        Console.WriteLine("Friend chat service is running.");
                    }
                    catch (Exception ex)
                    {
                        logger.Error("Error setting up ChatFriendService: " + ex.Message);
                    }

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

        private static IContainer ConfigureAutofac()
        {
            var builder = new ContainerBuilder();
            builder.RegisterModule<ServiceModule>();
            return builder.Build();
        }
    }
}
