using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace UserService.Database.Entities
{
    public class LoginResponse
    {
        public string ResponseCode { get; set; }
        public string ResponseMessage { get; set; }
        public User UserData { get; set; }
    }
}
