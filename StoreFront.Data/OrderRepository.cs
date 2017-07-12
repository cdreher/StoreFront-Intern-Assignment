using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StoreFront.Data
{
    public class OrderRepository
    {
        public static Order_table GetOrder(int id)     //return an instance of "Order", which is the row in the table w/ the corresponding id
        {
            StoreFrontEntities db = new StoreFrontEntities();
            
            return db.Order_table.Where(a => a.OrderID == id).FirstOrDefault();
        }

        public static Order_table UpdateStatus(int id, int status)     //update status
        {
            StoreFrontEntities db = new StoreFrontEntities();
            var order = db.Order_table.Where(a => a.OrderID == id).FirstOrDefault();
            order.StatusID = status;
            db.SaveChanges();

            return order;
        }
    }
}
