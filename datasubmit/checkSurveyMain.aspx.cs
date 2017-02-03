using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class datasubmit_checkSurvey : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string username = "";
        if (Session["username"] != null)
        {
            username = Session["username"].ToString();
        }

        DB db = new DB();
        string sql = "select id,name from t_instituteinvestigationflow where leadercheck is null and leader = '" + username + "'";
        DataTable dt = new DataTable();
        dt = db.GetDataTable(sql); //数据源     
        Repeater1.DataSource = dt;
        Repeater1.DataBind();
    }

    protected void Button1_Click(object sender, EventArgs e)
    {

    }
}
