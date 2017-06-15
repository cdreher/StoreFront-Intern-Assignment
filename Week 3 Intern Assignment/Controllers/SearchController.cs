using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Week_3_Intern_Assignment.Models;

namespace Week_3_Intern_Assignment.Controllers
{
    public class SearchController : Controller
    {
        // GET: Search
        private StoreFrontEntities6 db = new StoreFrontEntities6();
        public ActionResult Index()
        {
            ViewBag.listProducts = db.Product_table.ToList();
            return View();
        }

        public ActionResult Search(string searchString)
        {
            ViewBag.listProducts = db.Product_table.Where(x => x.ProdDescription == searchString).ToList();
            return View();
        }
    }
}