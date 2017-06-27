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

            return View("Index");
        }

        public ActionResult ConfirmOrder(Address_table jawn)
        {
            var user = db.User_table.Where(a => a.UserName == HttpContext.User.Identity.Name).FirstOrDefault(); //get user
            jawn.UserID = user.UserID;
            return View("Index");
        }

    }
}