using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Week_3_Intern_Assignment.Models;

namespace Week_3_Intern_Assignment.Controllers
{
    public class CartController : Controller
    {
        private STOREFRONTEntitiesALL db = new STOREFRONTEntitiesALL();
        

        // GET: Cart
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        [Authorize]
        public ActionResult Delete(int id)
        {
       
            var user = db.User_table.Where(a => a.UserName == HttpContext.User.Identity.Name).FirstOrDefault();
            var temp = db.ShoppingCart_table.Where(a => a.UserID == user.UserID).FirstOrDefault();            //find shopping cart for userID
            var productList = db.ShoppingCartProduct_table.Where(a => a.ShoppingCartID == temp.ShoppingCartID).ToList();        //get product list
            db.ShoppingCartProduct_table.Remove(productList.Where(i => i.ProductID == id).FirstOrDefault());
            db.SaveChanges();

            //var newCart = db.ShoppingCartProduct_table.Where(a => a.ShoppingCartID == temp.ShoppingCartID).FirstOrDefault();
            var total = temp.ShoppingCartProduct_table.Sum(a => a.Product_table.Price * a.Quantity);

            productList = db.ShoppingCartProduct_table.Where(a => a.ShoppingCartID == temp.ShoppingCartID).ToList();        //get product list
            return Json(new { total });
            //return Redirect("~/Cart/Cart");
        }

        [HttpPost]
        [Authorize]
        public ActionResult UpdateQuantity(int id, int quantity)
        {
            var user = db.User_table.Where(a => a.UserName == HttpContext.User.Identity.Name).FirstOrDefault();
            var temp = db.ShoppingCart_table.Where(a => a.UserID == user.UserID).FirstOrDefault();            //find shopping cart for userID
            var x = db.ShoppingCartProduct_table.Where(a => a.ProductID == id && a.ShoppingCartID == temp.ShoppingCartID).FirstOrDefault();

            x.Quantity = quantity;
            var subtotal = db.ShoppingCartProduct_table.Where(a => a.ProductID == id).FirstOrDefault().Product_table.Price * x.Quantity;
            var total = temp.ShoppingCartProduct_table.Sum(a => a.Product_table.Price * a.Quantity);
            db.SaveChanges();
            return Json(new { quantity, subtotal, total });
        }

        [HttpPost]
        [Authorize]
        public ActionResult GetQuantity()
        {
            var user = db.User_table.Where(a => a.UserName == HttpContext.User.Identity.Name).FirstOrDefault();
            var temp = db.ShoppingCart_table.Where(a => a.UserID == user.UserID).FirstOrDefault();            //find shopping cart for userID
            var amount = temp.ShoppingCartProduct_table.Sum(a => a.Quantity);
            return Json(amount);
        }

        public ActionResult Cart()
        {
            var user = db.User_table.Where(a => a.UserName == User.Identity.Name).FirstOrDefault();
            var temp = db.ShoppingCart_table.Where(a => a.UserID == user.UserID).FirstOrDefault();            //find shopping cart for userID
            var productList = db.ShoppingCartProduct_table.Where(a => a.ShoppingCartID == temp.ShoppingCartID).ToList();        //get product list
            return View(productList);
        }

        [HttpPost]
        [Authorize]
        public ActionResult OrderNow(int id)
        {
            
            var test = db.User_table.Where(a => a.UserName == HttpContext.User.Identity.Name).FirstOrDefault();        //find user
            int userid = test.UserID;       //get userID
            var s = db.ShoppingCart_table.Where(a => a.UserID == userid).FirstOrDefault();            //find shopping cart for userID


            if (s == null)          //if user doesn't have shopping cart, create new one                   
            {
                ShoppingCart_table shopCart = new ShoppingCart_table();     //create new cart
                shopCart.UserID = userid;
                shopCart.ModifieidBy = HttpContext.User.Identity.Name;
                shopCart.CreatedBy = HttpContext.User.Identity.Name;
                shopCart.DateCreated = DateTime.Now;
                shopCart.DateModified = DateTime.Now;
                //shopCart.ShoppingCartID = userid;
                db.ShoppingCart_table.Add(shopCart);           //add new cart to DB
                db.SaveChanges();

                s = shopCart;

            }

            var v = db.Product_table.Find(id);      //get selected product
            var x = db.ShoppingCartProduct_table.Where(a => a.ProductID == id && a.ShoppingCartID == s.ShoppingCartID).FirstOrDefault();

            if (x == null)      //check to see if product already exists in cart
            {
                ShoppingCartProduct_table cart = new ShoppingCartProduct_table();
                cart.ProductID = v.ProductID;       //store product in db
                cart.ShoppingCartID = s.ShoppingCartID;
                cart.ShoppingCartProductID = s.ShoppingCartID + 1;
                cart.Quantity = 0;
                db.ShoppingCartProduct_table.Add(cart);
                x = cart;
            }
            x.Quantity++;                    //add quantity of 1 to db
            db.SaveChanges();

            var amount = s.ShoppingCartProduct_table.Sum(a => a.Quantity);

            return Json(new { amount });
        }

    }
}