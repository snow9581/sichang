using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class plan_planRun_dtz_show_planRun_sj : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string userlevel = Convert.ToString(Session["userlevel"]);
        userLevel.Value = userlevel;
        string username = Convert.ToString(Session["username"]);
        userName.Value = username;
        string organization = Convert.ToString(Session["dm"]);
        Organization.Value = organization;
    }
}