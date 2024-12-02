using System.Runtime.Serialization;

namespace Service.Results
{
    [DataContract]
    public class ImageResponse
    {
        [DataMember]
        public bool IsSuccess { get; set; }
        [DataMember]
        public string ErrorKey { get; set; }
        [DataMember]
        public byte[] ImageData { get; set; }
        [DataMember]
        public string FileName { get; set; }
        [DataMember]
        public string MimeType { get; set; }

        public static ImageResponse Success(byte[] imageData, string fileName, string mimeType)
        {
            return new ImageResponse { IsSuccess = true, ImageData = imageData, FileName = fileName, MimeType = mimeType };
        }

        public static ImageResponse Failure(string errorKey)
        {
            return new ImageResponse { IsSuccess = false, ErrorKey = errorKey };
        }
    }
}
