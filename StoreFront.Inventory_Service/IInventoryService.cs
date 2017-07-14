using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

namespace StoreFront.Inventory_Service
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IInventoryService" in both code and config file together.
    [ServiceContract]
    public interface IInventoryService
    {
        [OperationContract]
        int DoWork(int id);

        [OperationContract]
        List<Product_Item> SearchProducts(string text);

        [OperationContract]
        List<Product_Item> GetProductDetails(int id);
    }

    // Use a data contract as illustrated in the sample below to add composite types to service operations.
    [DataContract]
    public class Product_Item
    {
        [DataMember]
        public int ProdID { get; set; }

        [DataMember]
        public string ProdName { get; set; }

        [DataMember]
        public string Des { get; set; }

        [DataMember]
        public int Quantity { get; set; }

        [DataMember]
        public decimal Price { get; set; }

        [DataMember]
        public string ImageFile { get; set; }
    }
}
