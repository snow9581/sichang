using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ybManage_meter_input_meter : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string index = Request.Params["index"];
        hd_index.Value = index;
        string userlevel = Convert.ToString(Session["userlevel"]);
        userLevel.Value = userlevel;
        string DM = Convert.ToString(Session["dm"]);
        dm.Value = DM;
    }
}