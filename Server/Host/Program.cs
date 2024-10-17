using System;
using System.IO;
using System.ServiceModel;
using log4net;
using log4net.Config;
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

            try
            {
                using (ServiceHost accountServiceHost = new ServiceHost(typeof(AccountService)))
                using (ServiceHost chatServiceHost = new ServiceHost(typeof(ChatService)))
                {
                    accountServiceHost.Open();
                    Console.WriteLine("AccountService is running...");

                    chatServiceHost.Open();
                    logger.Info("ChatService started successfully.");
                    Console.WriteLine("ChatService is running...");

                    logger.Info("Both services are up and running.");
                    Console.WriteLine("Services are up and running.");
                    Console.WriteLine("Press Enter to terminate the services.");
                    Console.ReadLine();
                }
            }
            catch (AddressAccessDeniedException ex)
            {
                logger.Error("Address access error. Make sure the application has the necessary permissions." + ex.ToString());
                Console.WriteLine("Error: " + ex.ToString());
            }
            catch (CommunicationObjectFaultedException ex)
            {
                logger.Error("Communication object faulted." + ex.ToString());
                Console.WriteLine("Error: " + ex.ToString());
            }
            catch (TimeoutException ex)
            {
                logger.Error("Timeout while opening ChatService." + ex.ToString());
                Console.WriteLine("Timeout: " + ex.Message);
            }
            catch (Exception ex)
            {
                logger.Fatal("Unexpected error in the host. "+ ex.ToString());
                Console.WriteLine("Fatal error: " + ex.ToString());
            }
            finally
            {
                logger.Info("The service host has been closed.");
                Console.WriteLine("Services terminated. Press Enter to exit.");
                Console.ReadLine();
            }
        }
    }
}
