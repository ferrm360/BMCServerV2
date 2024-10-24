using Autofac;
using log4net;
using Service.Contracts;
using Service.Implements;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

namespace Host.Utilities
{
    public class ServiceManager
    {
        private static readonly ILog logger = LogManager.GetLogger(typeof(ServiceManager));
        private readonly ILifetimeScope _scope;
        private readonly List<ServiceHost> _serviceHosts = new List<ServiceHost>();

        public ServiceManager(ILifetimeScope scope)
        {
            _scope = scope;
        }

        public void StartServices()
        {
            TryStartService<IAccountService, AccountService>("AccountService");
            TryStartService<IChatService, ChatService>("ChatService");
            TryStartService<IProfileService, ProfileService>("ProfileService");
            TryStartService<IFriendshipService, FriendshipService>("FriendshipService");

            logger.Info("All services that could be started are now running.");
            Console.WriteLine("Services are up and running. Press Enter to stop the services.");
        }

        public void StopServices()
        {
            foreach (var serviceHost in _serviceHosts)
            {
                try
                {
                    if (serviceHost.State == CommunicationState.Opened)
                    {
                        serviceHost.Close();
                        logger.Info($"{serviceHost.Description.ServiceType.Name} has been closed.");
                    }
                }
                catch (Exception ex)
                {
                    logger.Warn($"Error while closing {serviceHost.Description.ServiceType.Name}: {ex}");
                }
            }
            logger.Info("All services have been stopped.");
        }

        // Método genérico para inicializar un servicio
        private void TryStartService<TServiceContract, TServiceImplementation>(string serviceName)
            where TServiceImplementation : TServiceContract
        {
            try
            {
                // Resolver la instancia del servicio desde Autofac
                var serviceInstance = _scope.Resolve<TServiceImplementation>();

                // Crear el ServiceHost usando la configuración de WCF desde app.config
                var serviceHost = new ServiceHost(serviceInstance);
                serviceHost.Open();
                _serviceHosts.Add(serviceHost);

                logger.Info($"{serviceName} started successfully.");
                Console.WriteLine($"{serviceName} is running...");
            }
            catch (Exception ex)
            {
                logger.Error($"{serviceName} failed to start: {ex}");
                Console.WriteLine($"{serviceName} failed to start: {ex.Message}");
            }
        }
    }
}
