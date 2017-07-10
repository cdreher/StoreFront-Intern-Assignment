using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using StoreFront.Data;
using Week_3_Intern_Assignment.Controllers;
using System.Web.Mvc;

namespace StoreFront.UnitTest
{
    [TestClass]
    public class StoreFrontDataTest
    {
        StoreFrontEntities db = new StoreFrontEntities();
        [TestMethod]
        public void User_Registration_Test()
        {
            //ARRANGE
            UserController controller = new UserController();
            User_table user = new User_table();
            user.UserName = "thisisatestusername";
            user.Password = "test";
            user.EmailAddress = "cdreher1234@gmail.com";
            //ACT
            ActionResult actual = controller.Registration(user);
            //ASSERT
            Assert.IsNotNull(actual);
        }
    }
}
