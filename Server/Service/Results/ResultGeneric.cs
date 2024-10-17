using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Service.Results
{
    [DataContract]
    public class OperationResult<T>
    {
        [DataMember]
        public bool Success { get; set; }

        [DataMember]
        public string ErrorKey { get; set; } // Solo usado si la operación falla

        [DataMember]
        public T Data { get; set; } // Datos opcionales en caso de éxito

        // Método para éxito con datos (sin mensaje)
        public static OperationResult<T> SuccessResult(T data)
        {
            return new OperationResult<T> { Success = true, Data = data };
        }

        // Método para éxito sin datos (para casos donde no devuelves datos)
        public static OperationResult<T> SuccessResult()
        {
            return new OperationResult<T> { Success = true };
        }

        // Método para fallo con ErrorKey (devolvemos solo el error)
        public static OperationResult<T> Failure(string errorKey)
        {
            return new OperationResult<T> { Success = false, ErrorKey = errorKey };
        }
    }
}
