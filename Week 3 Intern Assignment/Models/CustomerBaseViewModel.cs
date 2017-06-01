using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Week_3_Intern_Assignment.Models
{
    public class CustomerBaseViewModel
    {
        [Key]
        public string UserName { get; set; }
        public int UserID { get; set; }

    }
}