using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class input_measure : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string index = Request.Params["index"];
        hd_index.Value = index;
        string userlevel = Convert.ToString(Session["userlevel"]);
        userLevel.Value = userlevel;
   //    string KM = Convert.ToString(Session["km"]);
  //      kumi.Value = KM;
    }
}