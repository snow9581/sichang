using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class datasubmit_minerTeamSubmit : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string id = Request.Params["id"];
        hd_id.Value = id;
        NAME.Value = Request.Params["name"];
    }
}