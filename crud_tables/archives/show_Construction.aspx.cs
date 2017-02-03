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
        HDpname.Value = Request.Params["pname"].ToString();
        HDpnumber.Value = Request.Params["pnumber"].ToString();
        HDpleader.Value = Request.Params["pleader"].ToString();
    }
}
