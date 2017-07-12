using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StoreFront.Data
{
    public class InventoryRepository
    {
        public static List<Product_table> SearchProducts(String searchText)    //return a list of "Product", that have name or description containing "searchText"
        {
            StoreFrontEntities db = new StoreFrontEntities();
            List<Product_table> listProducts = new List<Product_table>();

            if (searchText == null)
            {
                listProducts = db.Product_table.ToList();
            }
            else
            {
                listProducts = db.Product_table.Where(x => x.ProductName.Contains(searchText) || x.ProdDescription.Contains(searchText)).ToList();
            }
            
            return listProducts;
        }

        public static Product_table GetProduct(int id)     //return an instance of "Product", which will have all the fields in the "Product" class. Populated inside the method & returned.
        {
            StoreFrontEntities db = new StoreFrontEntities();
            Product_table prod = new Product_table();

            prod = db.Product_table.Where(a => a.ProductID == id).FirstOrDefault();

            return prod;
        }
    }
}
