using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class exam_showExam : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string userlevel = Convert.ToString(Session["userlevel"]);
        userLevel.Value = userlevel;
        string sql = "select * from T_EXAMSTANDARD where E_MAJOR='" + Convert.ToString(Session["dm"]) + "'";
        DB db = new DB();
        int Count = db.GetCount(sql);
        if(Count==0)
            Standard.Value = "1";
    }
}