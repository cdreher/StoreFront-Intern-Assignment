using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Week_3_Intern_Assignment.Models;

namespace Week_3_Intern_Assignment.Models
{
    public class Item
    {
        private Product_table pr = new Product_table();
        public Product_table Pr
        {
            get { return pr; }
            set { pr = value; }

        }

        private int quantity;
        public int Quantity
        {
            get { return quantity; }
            set { quantity = value; }
        }

        public Item()
        { }

        public Item(Product_table product, int quantity)
        {
            this.pr = product;
            this.quantity = quantity;
        }

      
    }
}