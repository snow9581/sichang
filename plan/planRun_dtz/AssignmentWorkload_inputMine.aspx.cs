using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class plan_planRun_dtz_AssignmentWorkload_input : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        hd_index.Value = Request.Params["index"].ToString();
        hd_pid.Value = Request.Params["pid"].ToString();
        string userlevel = Session["userlevel"].ToString();
        userLevel.Value= userlevel;
        if (userlevel != "3")
        {
            jurisdiction.Value = Request.Params["jurisdiction"].ToString();
        }
    }
}