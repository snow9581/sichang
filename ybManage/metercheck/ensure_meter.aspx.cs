using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Instrument_Table : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string userlevel = Convert.ToString(Session["userlevel"]);
        userLevel.Value = userlevel;
        string DM = Convert.ToString(Session["dm"]);
        dm.Value = DM;
        url.Value = Context.Request.Params["ID"].ToString();
    }
    
}