using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class datasubmit_minerTeamCheckTeam : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string id = Request.Params["id"];
        string title = Request.Params["name"];
        Title.Value = title;
        string km="";

        if (Session["km"] != null) km = Session["km"].ToString();

        DB db = new DB();
        string sql = "select rowid id,teamname name from t_team t where id ='" + id + "' and  type = '已填写调查报告' and minername='"+km+"'";
        DataTable dt = new DataTable();
        dt = db.GetDataTable(sql); //数据源     
        Repeater1.DataSource = dt;
        Repeater1.DataBind();
    }

    protected void Button1_Click(object sender, EventArgs e)
    {

    }
}