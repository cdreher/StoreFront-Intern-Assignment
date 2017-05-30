using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Week_3_Intern_Assignment
{
    public partial class CustomersAdmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void AddUserDetailView_OnInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            CurrentUsersGrid.DataBind();
        }
    }
}