using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Week_3_Intern_Assignment.Models;


namespace Week_3_Intern_Assignment.Models
{
    public class ShoppingCartViewModel
    {
        public ShoppingCartProduct_table shoppingCart { get; set; }
        public Product_table product { get; set; }
        
    }
}