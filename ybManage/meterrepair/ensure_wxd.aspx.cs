using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ybManage_meterrepair_ensure_wxd : BasePage{
    protected void Page_Load(object sender, EventArgs e)
    {
        string id = Context.Request.Params["ID"];
        ID.Value = id;
        USERLEVEL.Value = Context.Session["userlevel"].ToString();
    }
}