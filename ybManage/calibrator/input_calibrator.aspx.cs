using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ybManage_calibrator_input_calibrator : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        hd_index.Value = Request.Params["index"];
    }
}