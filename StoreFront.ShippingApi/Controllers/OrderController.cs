using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using StoreFront.Data;

namespace StoreFront.ShippingApi.Controllers
{
    public class OrderController : Controller
    {
        // GET: Order
        public ActionResult Index()
        {
            return View();
        }

        //This should return all order objects that have an "OrderDate" between the start and end dates.
        public List<Order_table> GetOrders(DateTime startDate, DateTime endDate)
        {
            StoreFrontEntities db = new StoreFrontEntities();
            List<Order_table> listOrders = new List<Order_table>();

            //if OrderDate is >= startDate && <= endDate
            listOrders = db.Order_table.Where(a => a.OrderDate.CompareTo(startDate) != -1 && a.OrderDate.CompareTo(endDate) != 1).ToList();
            return listOrders;
        }

        //This should change the status of an order to "Shipped"
        public Order_table MarkOrderShipped(int id)
        {
            StoreFrontEntities db = new StoreFrontEntities();
            Order_table order = new Order_table();
            order = OrderRepository.UpdateStatus(id, 3);        //mark as shipped
            return order;
        }
    }
}