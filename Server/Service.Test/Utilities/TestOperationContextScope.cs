using Service.Contracts;
using System;
using System.ServiceModel;
using System.ServiceModel.Channels;

namespace Service.Test.Utilities
{
    public class TestOperationContextScope : IDisposable
    {
        private readonly OperationContext _originalContext;

        public TestOperationContextScope(IContextChannel channel)
        {
            _originalContext = OperationContext.Current;

            var context = new OperationContext(channel);
            OperationContext.Current = context;
        }

        public void Dispose()
        {
            OperationContext.Current = _originalContext;
        }

        public class FakeContextChannel : IContextChannel, ILobbyCallback
        {
            public CommunicationState State => CommunicationState.Opened;
            public event EventHandler Closed;
            public event EventHandler Closing;
            public event EventHandler Faulted;
            public event EventHandler Opened;
            public event EventHandler Opening;

            public void Abort() { }
            public IAsyncResult BeginClose(AsyncCallback callback, object state) => null;
            public IAsyncResult BeginOpen(AsyncCallback callback, object state) => null;
            public void Close() { }
            public void Close(TimeSpan timeout) { }
            public void EndClose(IAsyncResult result) { }
            public void EndOpen(IAsyncResult result) { }
            public void Open() { }
            public void Open(TimeSpan timeout) { }
            public T GetProperty<T>() where T : class => null;
            public IAsyncResult BeginClose(TimeSpan timeout, AsyncCallback callback, object state) => null;
            public IAsyncResult BeginOpen(TimeSpan timeout, AsyncCallback callback, object state) => null;

            public TimeSpan OperationTimeout { get; set; }
            public IInputSession InputSession => null;
            public IOutputSession OutputSession => null;
            public InstanceContext InstanceContext => null;
            public Uri ListenUri => null;
            public EndpointAddress LocalAddress => null;
            public EndpointAddress RemoteAddress => null;
            public string SessionId => Guid.NewGuid().ToString();
            public bool AllowOutputBatching { get => false; set { } }
            public IExtensionCollection<IContextChannel> Extensions => null;

            public void NotifyPlayerJoined(string playerName, string lobbyId) { }
            public void NotifyPlayerLeft(string playerName, string lobbyId) { }
            public void StartGameNotification(string lobbyId) { }

            public void NotifyPlayerJoinedMessage(string message)
            {
            }

            public void NotifyPlayerLeftMessage(string message)
            {
            }
        }
    }
}
