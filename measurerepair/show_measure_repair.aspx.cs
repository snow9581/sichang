using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class show_calibrator_repair : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string userlevel=userLevel.Value = Session["userlevel"].ToString();
        string DM = Session["DM"].ToString();
        if (DM == "仪表室" && userlevel == "2")//当前用户是仪表室主任时
        {
            searchtoolbar.Visible = true;
        }
        else
        {
            searchtoolbar.Visible = false;    
        }

        if (userlevel == "1")
            btn_new.Visible = true;
        else
            btn_new.Visible = false;
    }
}