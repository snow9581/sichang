using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class easyui_crud_demo_show_form : BasePage
{
   
    protected void Page_Load(object sender, EventArgs e)
    {
        string index = Request.Params["index"];        
        hd_index.Value = index;

        string userlevel = Convert.ToString(Session["userlevel"]);
        userLevel.Value = userlevel;
        PID.Value = Request.Params["PNUMBER"];
        PNAME.Value = Request.Params["PNAME"];
        PLEADER.Value = Request.Params["PLEADER"];
    }



   
}
