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
            // Configuración del log4net
            XmlConfigurator.Configure();
            logger.Info("Initializing the service host.");
            Console.WriteLine("Initializing services, press Enter to continue...");
            Console.ReadLine();

            // Configurar Autofac
            var container = ConfigureAutofac();

            // Iniciar los servicios con el container de Autofac
            try
            {
                using (var scope = container.BeginLifetimeScope())
                {
                    // Inicializar y abrir AccountService
                    try
                    {
                        var accountServiceHost = new ServiceHost(typeof(AccountService));
                        accountServiceHost.AddDependencyInjectionBehavior<IAccountService>(scope);
                        accountServiceHost.Open();
                        Console.WriteLine("AccountService is running...");
                        logger.Info("AccountService started successfully.");
                    }
                    catch (Exception ex)
                    {
                        logger.Error("AccountService failed to start: " + ex.Message);
                        Console.WriteLine("AccountService failed to start: " + ex.Message);
                    }

                    // Inicializar y abrir ProfileService
                    try
                    {
                        var profileServiceHost = new ServiceHost(typeof(ProfileService));
                        profileServiceHost.AddDependencyInjectionBehavior<IProfileService>(scope);
                        profileServiceHost.Open();
                        Console.WriteLine("ProfileService is running...");
                        logger.Info("ProfileService started successfully.");
                    }
                    catch (Exception ex)
                    {
                        logger.Error("ProfileService failed to start: " + ex.Message);
                        Console.WriteLine("ProfileService failed to start: " + ex.Message);
                    }

                    // Inicializar y abrir FriendshipService
                    try
                    {
                        var friendshipServiceHost = new ServiceHost(typeof(FriendshipService));
                        friendshipServiceHost.AddDependencyInjectionBehavior<IFriendshipService>(scope);
                        friendshipServiceHost.Open();
                        Console.WriteLine("FriendshipService is running...");
                        logger.Info("FriendshipService started successfully.");
                    }
                    catch (Exception ex)
                    {
                        logger.Error("FriendshipService failed to start: " + ex.Message);
                        Console.WriteLine("FriendshipService failed to start: " + ex.Message);
                    }

                    // Inicializar y abrir ChatService
                    try
                    {
                        var chatServiceHost = new ServiceHost(typeof(ChatService));
                        chatServiceHost.AddDependencyInjectionBehavior<IChatService>(scope);
                        chatServiceHost.Open();
                        Console.WriteLine("ChatService is running...");
                        logger.Info("ChatService started successfully.");
                    }
                    catch (Exception ex)
                    {
                        logger.Error("ChatService failed to start: " + ex.Message);
                        Console.WriteLine("ChatService failed to start: " + ex.Message);
                    }

                    Console.WriteLine("All services that could be started are running. Press Enter to stop the services.");
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

        // Método para configurar Autofac
        private static IContainer ConfigureAutofac()
        {
            var builder = new ContainerBuilder();
            builder.RegisterModule<ServiceModule>(); 
            return builder.Build();
        }
    }
}
