using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StoreFront.Data
{
    public class InventoryRepository
    {
        public List<Product_table> SearchProducts(String searchText)    //return a list of "Product", that have name or description containing "searchText"
        {
            return null;
        }

        public Product_table GetProduct(int id)     //return an instance of "Product", which will have all the fields in the "Product" class. Populated inside the method & returned.
        {
            return null;
        }
    }
}
