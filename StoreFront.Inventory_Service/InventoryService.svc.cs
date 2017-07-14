using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using StoreFront.Data;

namespace StoreFront.Inventory_Service
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "InventoryService" in code, svc and config file together.
    // NOTE: In order to launch WCF Test Client for testing this service, please select InventoryService.svc or InventoryService.svc.cs at the Solution Explorer and start debugging.
    public class InventoryService : IInventoryService
    {
        public int DoWork(int id)
        {
            return id;
        }

        public List<Product_Item> SearchProducts(string text)
        {
            List<StoreFront.Data.Product_table> listProducts = new List<StoreFront.Data.Product_table>();
            List<Product_Item> list1 = new List<Product_Item>();

            listProducts = InventoryRepository.SearchProducts(text);

            foreach (var item in listProducts)
            {
                Product_Item p = new Product_Item();
                p.ProdID = item.ProductID;
                p.ProdName = item.ProductName;
                p.Des = item.ProdDescription;
                p.Quantity = (int)item.Quantity;
                p.Price = item.Price;
                p.ImageFile = item.ImageFile;
                list1.Add(p);
            }
            return list1;
        }

        public List<Product_Item> GetProductDetails(int id)
        {
            StoreFront.Data.Product_table product = new StoreFront.Data.Product_table();
            List<Product_Item> list1 = new List<Product_Item>();

            product = InventoryRepository.GetProduct(id);

            Product_Item p = new Product_Item();
            p.ProdID = product.ProductID;
            p.ProdName = product.ProductName;
            p.Des = product.ProdDescription;
            p.Quantity = (int)product.Quantity;
            p.Price = product.Price;
            p.ImageFile = product.ImageFile;
            list1.Add(p);

            return list1;
        }
    }
}
