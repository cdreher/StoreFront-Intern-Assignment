using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using StoreFront.Data;
using System.Data.Entity;

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

        protected void SqlDataSource10_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }

        protected void uploadImageButton_Click(object sender, EventArgs e)
        {
            StoreFrontEntities db = new StoreFrontEntities();
            string fileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
            FileUpload1.PostedFile.SaveAs(Server.MapPath("~/Images/") + fileName);

            db.Database.ExecuteSqlCommand("UPDATE Product_table SET ImageFile = {0} WHERE(ProductID = {1})", "../../Images/" + fileName, Request.QueryString["ProductID"]);
            //Response.Redirect(Request.Url.AbsoluteUri);
            ProductDetails.DataBind();
            UpdateProductDetailView.DataBind();
        }
    }
}