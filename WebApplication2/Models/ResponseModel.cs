namespace WebApplication2.Models
{
    public class ResponseModel
    {
        public int errorcode { get; set; }
        public string message { get; set; }
        public string acesstoken { get; set; }
        public object data { get; set; }

        public ResponseModel(int _errorcode, string _message)
        {
            errorcode = _errorcode;
            message = _message;
        }
        public ResponseModel(int _errorcode, string _message, object _data)
        {
            errorcode = _errorcode;
            message = _message;
            data = _data;
        }
        public ResponseModel(int _errorcode, string _message, object _data, string _accesstoken)
        {
            errorcode = _errorcode;
            message = _message;
            data = _data;
            acesstoken = _accesstoken;
        }
    }
}
