using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Week_3_Intern_Assignment.Models;

namespace Week_3_Intern_Assignment.Models
{
    public class ShoppingCartViewModel
    {
        public ShoppingCart_table shoppingCart { get; set; }
        public IEnumerable<Product_table> products { get; set; }
    }
}