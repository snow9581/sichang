using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class plan_planRun_dtz_AssignmentWorkload_team : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        userName.Value = Session["username"].ToString();
        string userlevel= Session["userlevel"].ToString();
        userLevel.Value =userlevel;
        if (userlevel != "1")
        {
            string pid = Request.Params["id"].ToString();
            PID.Value = pid;
            DM.Value = Request.Params["DM"].ToString();
        }
        else
        {
            PID.Value = "";
            DM.Value = "";
        }
    }
}