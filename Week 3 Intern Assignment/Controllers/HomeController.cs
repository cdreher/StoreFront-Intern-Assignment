﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Week_3_Intern_Assignment.Models;

namespace Week_3_Intern_Assignment.Controllers
{
    public class HomeController : Controller
    {
        
        // GET: Home
        [Authorize]
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult HomePage()
        {
            return View();
        }

       
    }
}