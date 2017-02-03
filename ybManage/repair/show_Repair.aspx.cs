using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ybManage_repair_show_Repair : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string userlevel = Convert.ToString(Session["userlevel"]);
        userLevel.Value = userlevel;
        string DM = Convert.ToString(Session["dm"]);
        dm.Value = DM;
        string x = Context.Request.Params["xx"];
        if (x == "1")
            xx.Value = Session["ID"].ToString();
    }
}