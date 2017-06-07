using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Week_3_Intern_Assignment.Models
{
    public class UserLogin
    {
        [Display(Name = "User name")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "User name is required.")]
        public string UserName { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage ="Password is required")]
        [DataType(DataType.Password)]
        public string Password { get; set; }

        [Display(Name ="Remember Me?")]
        public bool RememberMe { get; set; }
    }
}