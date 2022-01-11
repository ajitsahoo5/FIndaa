using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace UserService.Database.Entities
{
    public class LoginRequest
    {
        public string Mobile { get; set; }
        public string Password { get; set; }
    }
}
