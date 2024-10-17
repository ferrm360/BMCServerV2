using log4net;
using log4net.Config;
using System;
using System.IO;

namespace Service.Utilities
{
    public static class Logger
    {
        private static readonly ILog logger = LogManager.GetLogger(typeof(Logger));

        static Logger()
        {
            XmlConfigurator.Configure();
        }

        public static void Info(string message)
        {
            if (logger.IsInfoEnabled)
            {
                logger.Info(message);
            }
        }

        public static void Warn(string message)
        {
            if (logger.IsWarnEnabled)
            {
                logger.Warn(message);
            }
        }

        public static void Error(string message, Exception ex = null)
        {
            if (logger.IsErrorEnabled)
            {
                if (ex != null)
                {
                    logger.Error($"{message} - Exception: {ex.Message}", ex);
                }
                else
                {
                    logger.Error(message);
                }
            }
        }

        public static void Debug(string message)
        {
            if (logger.IsDebugEnabled)
            {
                logger.Debug(message);
            }
        }

        public static void Fatal(string message, Exception ex = null)
        {
            if (logger.IsFatalEnabled)
            {
                if (ex != null)
                {
                    logger.Fatal($"{message} - Exception: {ex.Message}", ex);
                }
                else
                {
                    logger.Fatal(message);
                }
            }
        }
    }
}
