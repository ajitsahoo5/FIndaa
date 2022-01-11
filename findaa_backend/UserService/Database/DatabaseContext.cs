using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using UserService.Database.Entities;

namespace UserService.Database
{
    public class DatabaseContext : DbContext
    {
        public DbSet<User> Users { get; set; }
        public DbSet<Token> UserTokens { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            //optionsBuilder.UseSqlServer(@"data source=AJIT-PC\SQLEXPRESS; initial catalog=FindaaDB;
            //    persist security info=True;user id=ajit;password=2548;");
            optionsBuilder.UseSqlServer(@"data source=ABHAY; initial catalog=FindaaDB;
                user id=sa;password=admin;");
        }
    }
}
