using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using StoreFront.Data;
using Week_3_Intern_Assignment.Controllers;
using System.Web.Mvc;
using System.Data.Entity;
using System.Web;
using System.Linq;

namespace StoreFront.UnitTest
{
    [TestClass]
    public class StoreFrontDataTest
    {
        StoreFrontEntities db = new StoreFrontEntities();
//-----------------------------------------------------------------------------------------------------------------------------
//----- CUSTOMERSADMIN & CUSTOMERADMINDETAILS TESTS ------------------------------------------------------------------------------------------------------------

        [TestMethod]
        public void spGetUsers_Test()           //test CustomersAdmin user list
        {
            //ASSERT
            Assert.IsNotNull(db.spGetUsers());
        }

        [TestMethod]
        public void spAddUser_Test()            //test CustomersAdmin add link
        {
            //ARRANGE
            var username = "UNIT_TEST";
            var email = "unittest@test.com";

            //ASSERT
            Assert.IsNotNull(db.spAddUser(username, email));
        }

        [TestMethod]    
        public void spGetUser_Test()            //test CustomersAdmin edit link (getUser) --> CustomerAdminDetails user info
        {
            //ARRANGE
            var id = 1;

            //ASSERT
            Assert.IsNotNull(db.spGetUser(id));
        }

        [TestMethod]
        public void spGetUserAddresses_Test()            //test CustomerAdminDetails user addresses list
        {
            //ARRANGE
            var id = 1;

            //ASSERT
            Assert.IsNotNull(db.spGetUserAddresses(id));
        }

        [TestMethod]
        public void spUpdateUser_Test()            //test CustomersAdminDetails update link
        {
            //ARRANGE
            var id = 1047;
            string username = "unit_test_updated";
            string email = "unittest_updated@test.com";

            //ASSERT
            Assert.IsNotNull(db.spUpdateUser(id, username, email));
        }

//-----------------------------------------------------------------------------------------------------------------------------
//----- PRODUCTSADMIN & PRODUCTADMINDETAILS TESTS ------------------------------------------------------------------------------------------------------------

        [TestMethod]
        public void spGetProducts_Test()           //test ProductsAdmin user list
        {
            //ASSERT
            Assert.IsNotNull(db.spGetProducts(0));
        }

        [TestMethod]
        public void spAddProduct_Test()            //test ProductsAdmin add link
        {
            //ARRANGE
            var prodname = "White Putter";
            var des = "Putter";
            var price = 400;

            //ASSERT
            Assert.IsNotNull(db.spAddProduct(prodname, des, false, price));
        }

        [TestMethod]
        public void spGetProduct_Test()            //test ProductsAdmin edit link (getProduct) --> ProductAdminDetails product info
        {
            //ARRANGE
            var id = 1;

            //ASSERT
            Assert.IsNotNull(db.spGetProduct(id));
        }

        [TestMethod]
        public void spUpdateProduct_Test()            //test ProductsAdminDetails update link
        {
            //ARRANGE
            var id = 1256;
            var prodname = "Titleist ProV1";
            var des = "Balls";
            var price = 49.99;

            //ASSERT
            Assert.IsNotNull(db.spUpdateProduct(id, prodname, des, false, (decimal)price));
        }

//-----------------------------------------------------------------------------------------------------------------------------
//----- USER CONTROLLER TESTS ------------------------------------------------------------------------------------------------------------

        [TestMethod]
        public void User_Registration_Test()            //test user registration
        {
            //ARRANGE
            UserController controller = new UserController();
            User_table user = new User_table();
            user.UserName = "thisisatestusername";
            user.Password = "test";
            user.ConfirmPassword = "test";
            user.EmailAddress = "cdreher1234@gmail.com";

            //ACT
            ActionResult actual = controller.Registration(user);

            //ASSERT
            Assert.IsNotNull(actual);
        }

//-----------------------------------------------------------------------------------------------------------------------------
//----- SEARCH TESTS ------------------------------------------------------------------------------------------------------------

        [TestMethod]
        public void Search_Test()                   //test product search
        {
            //ARRANGE
            SearchController controller = new SearchController();
            string option = "Name";
            string keyword = "TaylorMade";

            //ACT
            ActionResult actual = controller.Search(option, keyword);

            //ASSERT   
            Assert.IsNotNull(actual);
        }

//-----------------------------------------------------------------------------------------------------------------------------
//----- CART TESTS ------------------------------------------------------------------------------------------------------------

        [TestMethod]
        public void Cart_OrderNow_Test()            //test add to cart
        {
            //ARRANGE
            CartController controller = new CartController();
            int id = 1;
            string username = "thisisatestusername";

            //ACT
            ActionResult actual = controller.OrderNow(id, username);

            //ASSERT
            Assert.IsNotNull(actual);
        }

        [TestMethod]
        public void Cart_Test()                 //test display cart
        {
            //ARRANGE
            CartController controller = new CartController();

            //ACT
            ActionResult actual = controller.CartTest("thisisatestusername");

            //ASSERT
            Assert.IsNotNull(actual);
        }

        [TestMethod]
        public void Cart_GetQuantity_Test()         //test quantity display on cart icon
        {
            //ARRANGE
            CartController controller = new CartController();

            //ACT
            ActionResult actual = controller.GetQuantity("thisisatestusername");

            //ASSERT
            Assert.IsNotNull(actual);
        }

        [TestMethod]
        public void Cart_UpdateQuantity_Test()          //test update quantity button in cart
        {
            //ARRANGE
            CartController controller = new CartController();
            int id = 1;
            int quan = 1;

            //ACT
            ActionResult actual = controller.UpdateQuantity(id, quan, "thisisatestusername");

            //ASSERT
            Assert.IsNotNull(actual);
        }

//-----------------------------------------------------------------------------------------------------------------------------
//----- ORDER TESTS ------------------------------------------------------------------------------------------------------------

        [TestMethod]
        public void Address_Test()                   //test address list
        {
            //ARRANGE
            OrderController controller = new OrderController();
            string username = "cdreher26";

            //ACT
            ActionResult actual = controller.Address_test(username);

            //ASSERT   
            Assert.IsNotNull(actual);
        }

        [TestMethod]
        public void AddNewAddress_Test()                   //test add new address
        {
            //ARRANGE
            OrderController controller = new OrderController();
            string username = "thisisatestusername";
            Address_table address = new Address_table();
            address.Address1 = "918 Muirfield Drive";
            address.City = "Hummelstown";
            address.ZipCode = "17036";
            address.StateID = 39;


            //ACT
            ActionResult actual = controller.AddNewAddress(address, username);

            //ASSERT   
            Assert.IsNotNull(actual);
        }

        [TestMethod]
        public void ConfirmOrder_Test()                   //test confirm order
        {
            //ARRANGE
            OrderController controller = new OrderController();
            string username = "thisisatestusername";
            int addressID = 21;
            
            //ACT
            ActionResult actual = controller.ConfirmOrder(db.Address_table.Where(a => a.AddressID == addressID).FirstOrDefault(), username);

            //ASSERT   
            Assert.IsNotNull(actual);
        }

        [TestMethod]
        public void SubmitOrder_Test()                   //test submit order
        {
            //ARRANGE
            OrderController controller = new OrderController();
            string username = "thisisatestusername";
            int addressID = 21;

            //ACT
            ActionResult actual = controller.SubmitOrder(addressID, 0, username);

            //ASSERT   
            Assert.IsNotNull(actual);
        }

//-----------------------------------------------------------------------------------------------------------------------------
//----- DELETE TESTS ------------------------------------------------------------------------------------------------------------

        [TestMethod]
        public void Cart_Delete_Test()          //delete cart item
        {
            //ARRANGE
            CartController controller = new CartController();
            int itemID = 1;

            //ACT
            ActionResult actual = controller.Delete(itemID, "thisisatestusername");

            //ASSERT
            Assert.IsNotNull(actual);
        }
        
        [TestMethod]
        public void Order_Delete_Test()          //delete order item
        {
            //ARRANGE
            OrderController controller = new OrderController();
            int itemID = 27;
            int orderID = 18;

            //ACT
            ActionResult actual = controller.Delete(orderID, itemID);

            //ASSERT
            Assert.IsNotNull(actual);
        }
        
        [TestMethod]
        public void User_Delete_Test()          //delete user [admin page]
        {
            //ARRANGE
            int userID = 1047;
            
            //ASSERT
            Assert.IsNotNull(db.spDeleteUser(userID));
        }

        [TestMethod]
        public void Product_Delete_Test()          //delete product [admin page]
        {
            //ARRANGE
            int ID = 1256;

            //ASSERT
            Assert.IsNotNull(db.spDeleteProduct(ID));
        }
    }

}
