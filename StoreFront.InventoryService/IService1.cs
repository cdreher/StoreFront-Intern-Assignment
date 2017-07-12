using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using StoreFront.Data;

namespace StoreFront.InventoryService
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the interface name "IService1" in both code and config file together.
    [ServiceContract]
    public interface IService1
    {

        [OperationContract]
        List<StoreFront.Data.Product_table> SearchProducts(string text);

        [OperationContract]
        StoreFront.Data.Product_table GetProductDetails(int id);

        // TODO: Add your service operations here
    }


    // Use a data contract as illustrated in the sample below to add composite types to service operations.
    [DataContract]
    public class Product_table
    {
        int prodID = 0;
        string prodName = "";
        string des = "";
        decimal price = 0;
        string imageFile = "";
        

        [DataMember]
        public int ProdID 
        {
            get { return prodID; }
            set { prodID = value; }
        }

        [DataMember]
        public string ProdName
        {
            get { return prodName; }
            set { prodName = value; }
        }

        [DataMember]
        public string Des
        {
            get { return des; }
            set { des = value; }
        }

        [DataMember]
        public decimal Price
        {
            get { return price; }
            set { price = value; }
        }

        [DataMember]
        public string ImageFile
        {
            get { return imageFile; }
            set { imageFile = value; }
        }
    }
}
