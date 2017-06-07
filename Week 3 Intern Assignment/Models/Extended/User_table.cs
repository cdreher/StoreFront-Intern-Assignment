using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace Week_3_Intern_Assignment.Models
{
    [MetadataType(typeof(UserMetadata))]
    public partial class User_table
    {
        public string ConfirmPassword { get; set; }
    }

    public class UserMetadata
    {
        [Display(Name = "User name")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "User name is required.")]
        public string UserName { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = "Password is required.")]
        [DataType(DataType.Password)]
        public string Password { get; set; }

        [Display(Name = "Confirm Password")]
        [DataType(DataType.Password)]
        [Compare("Password", ErrorMessage = "Confirm password and password do not match")]
        public string ConfirmPassword { get; set; }

        [Display(Name = "Email address")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Email address is required.")]
        public string EmailAddress { get; set; }
    }
}