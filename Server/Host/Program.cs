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
                    try
                    {
                        var lazyAccountService = new Lazy<ServiceHost>(() =>
                        {
                            var host = new ServiceHost(typeof(AccountService));
                            host.AddDependencyInjectionBehavior<IAccountService>(scope);
                            host.Open();
                            return host;
                        });
                        Console.WriteLine("AccountService will be started when accessed.");
                    }
                    catch (Exception ex)
                    {
                        logger.Error("Error setting up AccountService: " + ex.Message);
                    }

                    try
                    {
                        var lazyProfileService = new Lazy<ServiceHost>(() =>
                        {
                            var host = new ServiceHost(typeof(ProfileService));
                            host.AddDependencyInjectionBehavior<IProfileService>(scope);
                            host.Open();
                            return host;
                        });
                        Console.WriteLine("ProfileService will be started when accessed.");
                    }
                    catch (Exception ex)
                    {
                        logger.Error("Error setting up ProfileService: " + ex.Message);
                    }

                    try
                    {
                        var lazyFriendshipService = new Lazy<ServiceHost>(() =>
                        {
                            var host = new ServiceHost(typeof(FriendshipService));
                            host.AddDependencyInjectionBehavior<IFriendshipService>(scope);
                            host.Open();
                            return host;
                        });
                        Console.WriteLine("FriendshipService will be started when accessed.");
                    }
                    catch (Exception ex)
                    {
                        logger.Error("Error setting up FriendshipService: " + ex.Message);
                    }

                    Console.WriteLine("Services are ready. Press Enter to stop the services.");
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
