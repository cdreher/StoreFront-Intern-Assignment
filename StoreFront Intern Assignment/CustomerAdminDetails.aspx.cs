using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Week_3_Intern_Assignment
{
    public partial class CustomerAdminDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void UpdateUserDetailView_OnUpdate (object sender, DetailsViewUpdatedEventArgs e)
        {
            UserDetails.DataBind();
        }

        protected void DeleteUserDetailView_OnDelete(object sender, DetailsViewDeletedEventArgs e)
        {
            UserDetails.DataBind();
            UpdateUserDetailView.DataBind();
        }
    }
}