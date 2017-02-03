using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class crud_tables_show_house : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string userlevel = Convert.ToString(Session["userlevel"]);
        userLevel.Value = userlevel;
        string DM = Convert.ToString(Session["dm"]);
        dm.Value = DM;
    }
}
