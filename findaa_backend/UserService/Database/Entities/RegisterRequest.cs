using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace UserService.Database.Entities
{
    public class RegisterRequest
    {
        public User UserData { get; set; }
        public string UserToken { get; set; }
        public string Group { get; set; }
    }
}
