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
        //private StoreFrontEntities6 db = new StoreFrontEntities6();     //search-products table
        //private ShoppingCartEntities shop_db = new ShoppingCartEntities();      //shopping cart tables
        //private StoreFrontEntities5 user_db = new StoreFrontEntities5();        //user table

        // GET: Cart
        public ActionResult Index()
        {
            return View();
        }


        //public ActionResult Delete(int id)
        //{
        //    int index = isExisting(id);
        //    List<Item> cart = (List<Item>)Session["cart"];
        //    cart.RemoveAt(index);
        //    Session["cart"] = cart;
        //    return View("Cart");
        //}

        //public ActionResult ViewCart(int userID)
        //{

        //}

        public ActionResult OrderNow(int id, String userName)
        {
            if (id == 0)
            {
                return View("Cart");
            }

            var test = db.User_table.Where(a => a.UserName == userName).FirstOrDefault();        //find user
            int userid = test.UserID;       //get userID
            var s = db.ShoppingCart_table.Where(a => a.UserID == userid).FirstOrDefault();            //find shopping cart for userID


            if (s == null)          //if user doesn't have shopping cart, create new one                   
            {
                ShoppingCart_table shopCart = new ShoppingCart_table();     //create new cart


                db.ShoppingCart_table.Add(shopCart);           //add new cart to DB
                db.SaveChanges();
                s = shopCart;

            }

            var v = db.Product_table.Find(id);      //get selected product
            var x = db.ShoppingCartProduct_table.Where(a => a.ProductID == id && a.ShoppingCartID == s.ShoppingCartID).FirstOrDefault();       

            if (x == null)      
            {
                ShoppingCartProduct_table cart = new ShoppingCartProduct_table();
                cart.ProductID = v.ProductID;       //store product ID in db
                cart.ShoppingCartID = s.ShoppingCartID;
                db.ShoppingCartProduct_table.Add(cart);
                x = cart;
            }
            x.Quantity++;                    //add quantity of 1 to db
            db.SaveChanges();

            var viewModel = new ShoppingCartViewModel
            {
                shoppingCart = x,
                product = db.Product_table.Find(id)
            };
            
            return View("Cart", viewModel);
        }

    }
}