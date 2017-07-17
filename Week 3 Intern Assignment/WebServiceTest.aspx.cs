using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using StoreFront.Data;
using System.Web.WebPages;

namespace Week_3_Intern_Assignment
{
    public partial class Service1Test : System.Web.UI.Page
    {
        ServiceReference1.InventoryServiceClient service = new ServiceReference1.InventoryServiceClient();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SearchProducts_Click(object sender, EventArgs e)
        {
            GridView1.DataSource = service.SearchProducts(searchText.Text);
            GridView1.DataBind();

            
        }

        protected void getProdDets_Click(object sender, EventArgs e)
        {
            int id = prodID.Text.AsInt();
            GridView2.DataSource = service.GetProductDetails(id);
            GridView2.DataBind();
        }
    }
}