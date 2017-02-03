using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Instrument_Select : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string id = Context.Request.Params["id"];
        string newid = "";
        if (id != null)
        {
            for (int i = 1; i < id.Length - 1; i++)
                newid += id[i];
        }
        ids.Value = newid;
    }
}