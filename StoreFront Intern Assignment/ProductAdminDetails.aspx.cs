using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Week_3_Intern_Assignment
{
    public partial class ProductAdminDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void UpdateProductDetailView_OnUpdate(object sender, DetailsViewUpdatedEventArgs e)
        {
            ProductDetails.DataBind();
        }

        protected void DeleteProductDetailView_OnDelete(object sender, DetailsViewDeletedEventArgs e)
        {
            ProductDetails.DataBind();
            UpdateProductDetailView.DataBind();
        }
    }
}