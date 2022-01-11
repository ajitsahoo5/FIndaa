using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace UserService.Database.Entities
{
    public class User
    {
        public int UserId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string? MobileNo { get; set; }
        public string? EmailId { get; set; }
        public byte? SourceType { get; set; }
        public string Password { get; set; }
        public string City { get; set; }
        public string Locality { get; set; }
        public List<Token> Devices { get; set; }
        public bool IsCustomer { get; set; }
        public bool? IsActive { get; set; }
        public bool IsCompleted { get; set; } = false;
        public DateTime CreatedAt { get; set; }
    }
}
