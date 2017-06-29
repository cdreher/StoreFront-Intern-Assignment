using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using StoreFront.Data;

namespace Week_3_Intern_Assignment.Controllers
{
    public class OrderController : Controller
    {
        StoreFrontEntities db = new StoreFrontEntities();
        // GET: Order
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Address()
        {
            var user = db.User_table.Where(a => a.UserName == HttpContext.User.Identity.Name).FirstOrDefault();
            var addresses = db.Address_table.Where(a => a.UserID == user.UserID);
            List<SelectListItem> li = new SelectList(addresses, "AddressID", "Address1").ToList();
            li.Add(new SelectListItem { Text = "Enter new address" });
            ViewBag.listAddresses = li;

            var states = db.State_table.ToList();
            ViewBag.listStates = new SelectList(states, "StateID", "StateName");
            return View();
        }

        [HttpPost]
        public ActionResult AddNewAddress(Address_table jawn)
        {
            var user = db.User_table.Where(a => a.UserName == HttpContext.User.Identity.Name).FirstOrDefault(); //get user
            jawn.UserID = user.UserID;
            db.Address_table.Add(jawn);
            db.SaveChanges();

            return RedirectToAction("Address", "Order");
        }

        public ActionResult ConfirmOrder(Address_table jawn)
        {
            //GET SHOPPING CART
            var user = db.User_table.Where(a => a.UserName == HttpContext.User.Identity.Name).FirstOrDefault(); //get user
            jawn.UserID = user.UserID;
            var temp = db.ShoppingCart_table.Where(a => a.UserID == user.UserID).FirstOrDefault();            //find shopping cart for userID
            var productList = db.ShoppingCartProduct_table.Where(a => a.ShoppingCartID == temp.ShoppingCartID).ToList();        //get product list

            //GET ADDRESS
            ViewBag.address = db.Address_table.Where(a => a.AddressID == jawn.AddressID).FirstOrDefault();
            return View(productList);
        }

        public ActionResult SubmitOrder(int addID, decimal totalPrice)
        {
            //Create Order
            var user = db.User_table.Where(a => a.UserName == HttpContext.User.Identity.Name).FirstOrDefault(); //get user
            Order_table order = new Order_table();
            order.UserID = user.UserID;
            order.AddressID = addID;
            order.OrderDate = DateTime.Now;

            var tempTotal = totalPrice;

            order.Total = totalPrice;
            order.StatusID = 1;
            order.DateCreated = DateTime.Now;
            order.DateModified = DateTime.Now;
            order.CreatedBy = HttpContext.User.Identity.Name;
            order.ModifiedBy = HttpContext.User.Identity.Name;
            db.Order_table.Add(order);
            db.SaveChanges();

            //Create Order_product
            var temp = db.Order_table.Where(a => a.UserID == user.UserID && a.Total == totalPrice).FirstOrDefault();     //get recently made order
            var cart = db.ShoppingCart_table.Where(a => a.UserID == user.UserID).FirstOrDefault();            //find shopping cart for userID
            var productList = db.ShoppingCartProduct_table.Where(a => a.ShoppingCartID == cart.ShoppingCartID).ToList();        //get product list
            for(int i = 0; i < productList.Count(); i++)
            {
                OrderProduct_table orderProduct = new OrderProduct_table();
                orderProduct.OrderID = temp.OrderID;
                orderProduct.ProductID = productList[i].ProductID;
                orderProduct.Quantity = (int)productList[i].Quantity;
                orderProduct.Price = productList[i].Product_table.Price;
                orderProduct.DateCreated = DateTime.Now;
                orderProduct.DateModified = DateTime.Now;
                orderProduct.CreatedBy = HttpContext.User.Identity.Name;
                orderProduct.ModifiedBy = HttpContext.User.Identity.Name;
                db.OrderProduct_table.Add(orderProduct);
                db.SaveChanges();

            }
            
            return View("Index");
        }

        public ActionResult OrdersAdmin()
        {
            var orderList = db.Order_table.ToList();
            return View(orderList);
        }
        public ActionResult OrderAdminDetails(int orderID)
        {
            return View(db.Order_table.Where(a => a.OrderID == orderID).FirstOrDefault());
        }

        public ActionResult General(int id)
        {
            return View(db.Order_table.Where(a => a.OrderID == id).FirstOrDefault());
        }

        public ActionResult OrderAddress(int id)
        {
            return View(db.Address_table.Where(a=> a.AddressID == id).FirstOrDefault());
        }

        public ActionResult Products(Order_table order)
        {
            var productList = db.OrderProduct_table.Where(a => a.OrderID == order.OrderID).ToList();
            return PartialView("~/Views/Order/Products.cshtml", productList);
        }

        public ActionResult IncreaseWorkflow(Order_table model)
        {
            var order = db.Order_table.Where(a => a.OrderID == model.OrderID).FirstOrDefault();
            order.StatusID++;
            db.SaveChanges();
            return PartialView("~/Views/Order/OrderAdminDetails.cshtml", order);
        }
        
        [HttpPost]
        [Authorize]
        public ActionResult UpdateQuantity(int orderID, int id, int quantity)
        {
            var order = db.Order_table.Where(a => a.OrderID == orderID).FirstOrDefault();
            var x = order.OrderProduct_table.Where(a => a.OrderProductID == id).FirstOrDefault();

            var subtotal = x.Price * x.Quantity;        //subtotal of current product quantity
            order.Total -= subtotal;                    //take away product subtotal
            x.Quantity = quantity;                      //set new product quantity
            order.Total += x.Price * x.Quantity;        //add back product BUT WITH NEW QUANTITY
            var total = order.Total;
            db.SaveChanges();
            return Json(new { quantity , total });
            //return PartialView("~/Views/Order/OrderAdminDetails.cshtml", order);
        }

        [HttpPost]
        [Authorize]
        public ActionResult Delete(int orderID, int id)
        {
            var order = db.Order_table.Where(a => a.OrderID == orderID).FirstOrDefault();
            var x = order.OrderProduct_table.Where(a => a.OrderProductID == id).FirstOrDefault();

            var productList = db.OrderProduct_table.Where(a => a.OrderID == orderID).ToList();
            db.OrderProduct_table.Remove(productList.Where(a => a.OrderProductID == id).FirstOrDefault());
            db.SaveChanges();

            //var newCart = db.ShoppingCartProduct_table.Where(a => a.ShoppingCartID == temp.ShoppingCartID).FirstOrDefault();
            var total = order.OrderProduct_table.Sum(a => a.Price * a.Quantity);

            productList = db.OrderProduct_table.Where(a => a.OrderID == orderID).ToList();        //get product list
            order.Total = total;
            db.SaveChanges();
            return Json(new { total });
            //return PartialView("~/Views/Order/OrderAdminDetails.cshtml", order);
        }
    }
}