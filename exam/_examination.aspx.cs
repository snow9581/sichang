using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class exam_examination : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        scoreX.Value = Request.Params["scoreX"];
        scoreP.Value = Request.Params["scoreP"];
        Etime.Value = Request.Params["time"];
    }
}