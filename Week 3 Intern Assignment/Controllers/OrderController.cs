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
        // GET: Order
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult PlaceOrder()
        {
            return View();
        }
    }
}