using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using StoreFront.Data;
using StoreFront.InventoryService;

namespace Week_3_Intern_Assignment
{
    public partial class Service1Test : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SearchProducts_Click(object sender, EventArgs e)
        {
            ServiceReference1.Service1Client service = new ServiceReference1.Service1Client();
            GridView1.DataSource = service.SearchProducts(searchText.Text);
            GridView1.DataBind();
        }
    }
}