using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class main_5 : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string username = (string)Session["username"].ToString();
        labelname.Text = username;
        string userlevel = Convert.ToString(Session["userlevel"]);
        userLevel.Value = userlevel;
    }
}