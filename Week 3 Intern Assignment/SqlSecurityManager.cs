using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Policy;
using System.Web;
using System.Web.Security;
using StoreFront.Data;
using System.ComponentModel.DataAnnotations;

namespace Week_3_Intern_Assignment
{
    public class SqlSecurityManager
    {
        [Display(Name = "User name")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "User name is required.")]
        public string UserName { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "Password is required")]
        [DataType(DataType.Password)]
        public string Password { get; set; }

        [Display(Name = "Remember Me?")]
        public bool RememberMe { get; set; }

        static StoreFrontEntities dc = new StoreFrontEntities();

        public static bool AuthenticateUser(string username, string password)
        {
            var v = dc.User_table.Where(a => a.UserName == username).FirstOrDefault();
            if (string.Compare(Crypto.Hash(password), v.Password) == 0)
            {
                return true;
            }

            return false;
        }

        public static bool IsAdmin(string username)
        {
            var user = dc.User_table.Where(a => a.UserName == username).FirstOrDefault();
            if (user.IsAdmin)
                return true;
            return false;
        }

        public static User_table LoadUser(string username)
        {
            User_table user = new User_table();
            user = dc.User_table.Where(a => a.UserName == username).FirstOrDefault();
            return user;
        }

        public static void SaveUser()
        {
            dc.SaveChanges();
        }

        public static void RegisterUser(User_table user)
        {
            //Password Hashing
            user.Password = Crypto.Hash(user.Password);
            user.ConfirmPassword = Crypto.Hash(user.ConfirmPassword);

            //Save to database
            dc.User_table.Add(user);
            SaveUser();
        }

        public static bool DeleteUser(string username)
        {
            var user = LoadUser(username);
            dc.User_table.Remove(user);
            SaveUser();
            return true;
        }
    }
}