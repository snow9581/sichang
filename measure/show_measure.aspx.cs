using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class show_measure : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string userlevel = Convert.ToString(Session["userlevel"]);
        userLevel.Value = userlevel;
        string DM = Convert.ToString(Session["dm"]);
        dm.Value = DM;
       string KM = Convert.ToString(Session["km"]);
        km.Value = KM;        
            }
}
