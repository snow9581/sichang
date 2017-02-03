using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ybManage_calibrator_history : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        hd_BZQMC.Value = Request.Params["BZQMC"].ToString();
    }
}