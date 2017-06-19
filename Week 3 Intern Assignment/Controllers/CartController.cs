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
        private StoreFrontEntities6 db = new StoreFrontEntities6();     //search-products table
        private ShoppingCartEntities shop_db = new ShoppingCartEntities();      //shopping cart tables
        private StoreFrontEntities5 user_db = new StoreFrontEntities5();        //user table

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

        public ActionResult OrderNow(int id)
        {
            if (id == 0)
            {
                return View("Cart");
            }

            var s = shop_db.ShoppingCart_table.Find(id);
            if (s == null)                      
            {
                ShoppingCart_table shopCart = new ShoppingCart_table();     //create new cart


                shop_db.ShoppingCart_table.Add(shopCart);
                shop_db.SaveChanges();
                s = shopCart;

                //List<Item> cart = new List<Item>();
                //cart.Add(new Item(db.Product_table.Find(id), 1));
                //Session["cart"] = cart;

            }

            var v = db.Product_table.Find(id);      //get selected product
            var x = shop_db.ShoppingCartProduct_table.Where(a => a.ProductID == id && a.ShoppingCartID == s.ShoppingCartID).FirstOrDefault();

            if (x == null)
            {
                ShoppingCartProduct_table cart = new ShoppingCartProduct_table();
                cart.ProductID = v.ProductID;       //store product ID in db
                cart.ShoppingCartID = s.ShoppingCartID;
                shop_db.ShoppingCartProduct_table.Add(cart);
                x = cart;
            }
            x.Quantity++;                    //add quantity of 1 to db
            shop_db.SaveChanges();


            //else
            //{
            //    List<Item> cart = (List<Item>)Session["cart"];
            //    int index = isExisting(id);
            //    if (index == -1)
            //        cart.Add(new Item(db.Product_table.Find(id), 1));
            //    else
            //    {
            //        cart[index].Quantity++;
            //    }
            //    Session["cart"] = cart;
            //}
            return View("Cart");
        }

    }
}