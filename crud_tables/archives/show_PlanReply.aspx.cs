using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class crud_tables_show_event : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string userlevel = Convert.ToString(Session["userlevel"]);
        userLevel.Value = userlevel;
        if(Request.Params["pname"]!=null)
            HDpname.Value = Request.Params["pname"].ToString();
        if (Request.Params["pnumber"] != null)
            HDpnumber.Value = Request.Params["pnumber"].ToString();
        if (Request.Params["ptype"] != null)
            HDptype.Value = Request.Params["ptype"].ToString();
    }
}
