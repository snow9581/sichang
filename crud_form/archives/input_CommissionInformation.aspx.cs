using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class crud_form_archives_input_CommissionInformation : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string index = Request.Params["index"];
        hd_index.Value = index;
        PNUMBER.Value = Request.Params["PNUMBER"];
        PNAME.Value = Request.Params["PNAME"];
        pre_type.Value = Request.Params["ptype"];
        string userlevel = Convert.ToString(Session["userlevel"]);
        userLevel.Value = userlevel;

    }
}