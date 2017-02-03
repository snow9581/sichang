using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class datasubmit_minerSurvey : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string teamname = "";
        string km = "";
     
        if (Session["dm"] != null) teamname = Session["dm"].ToString();
        if(Session["km"]!=null) km=Session["km"].ToString();
        DB db = new DB();
        string sql = "select id,(select name from t_instituteinvestigationflow where id = t.id) as name from t_minerflow t where starttime is null and  minername = '" + km + "'";
        DataTable dt = new DataTable();
        dt = db.GetDataTable(sql); //数据源     
        Repeater1.DataSource = dt;
        Repeater1.DataBind();        

        //string sql2 = "select distinct id,(select name from t_instituteinvestigationflow where id = t.id) as name from t_minerflow t where MINERCHECK =0 and  minername = '" + km + "'";
        //DataTable dt2 = new DataTable();
        //dt2 = db.GetDataTable(sql2); //数据源     
        //Repeater2.DataSource = dt2;
        //Repeater2.DataBind();
    }

  
    protected void Button1_Click(object sender, EventArgs e)
    {

    }
}