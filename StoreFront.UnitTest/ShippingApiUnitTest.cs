using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using StoreFront.ShippingApi;
using StoreFront.ShippingApi.Controllers;
using System.Web.Mvc;
using System.Web;
using System.Linq;

namespace StoreFront.UnitTest
{
    [TestClass]
    public class ShippingApiUnitTest
    {

        //-----------------------------------------------------------------------------------------------------------------------------
        //----- GetOrder() TEST ------------------------------------------------------------------------------------------------------------

        [TestMethod]
        public void GetOrders_Test()           //test GetOrders()
        {
            //ARRANGE
            OrderController controller = new OrderController();
            //ASSERT
            Assert.IsNotNull(controller.GetOrders(new DateTime(2017, 06, 27), new DateTime(2017, 07, 14)));
        }

//-----------------------------------------------------------------------------------------------------------------------------
//----- MarkOrderShipped() TEST ------------------------------------------------------------------------------------------------------------

        [TestMethod]
        public void MarkOrderShipped_Test()           //test MarkOrderShipped()
        {
            //ARRANGE
            OrderController controller = new OrderController();
            //ASSERT
            Assert.IsNotNull(controller.MarkOrderShipped(4));
        }
    }
}
