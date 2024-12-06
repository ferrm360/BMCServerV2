using Moq;
using Service.Contracts;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.Text;
using System.Threading.Tasks;

namespace Service.Test
{
    public class OperationContextMock
    {
        public static OperationContext CreateMockOperationContext(ILobbyCallback callback)
        {
            var mockOperationContext = new Mock<OperationContext>();

            // Mocking GetCallbackChannel method to return the provided callback
            mockOperationContext
                .Setup(ctx => ctx.GetCallbackChannel<ILobbyCallback>())
                .Returns(callback);

            // Mocking Channel property to return a mock IContextChannel (necessary for OperationContext)
            var mockContextChannel = new Mock<IContextChannel>();
            mockOperationContext.Setup(ctx => ctx.Channel).Returns(mockContextChannel.Object);

            // Return the mocked OperationContext
            return mockOperationContext.Object;
        }
    }
}
