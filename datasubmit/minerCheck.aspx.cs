using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class datasubmit_minerCheck : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string km = "";

            if (Session["km"] != null) km = Session["km"].ToString();

            string id = Request.Params["id"];
            string name = Request.Params["name"];
            NAME.Value = name;
            hd_id.Value = id;
            DB db = new DB();

            //  string wordname = "";
            string excelname = "";//汇总报告
            DataTable dt2 = new DataTable();
            if (id != null && id != "")
            {
                string sql2 = "select excelname from t_minerflow where id=" + id + " and minername ='" + km + "'";
                dt2 = db.GetDataTable(sql2); //数据源    
            }
            if (dt2.Rows.Count > 0)
            {
                //    wordname = dt2.Rows[0]["wordname"].ToString();
                excelname = dt2.Rows[0]["excelname"].ToString();
            }
            // WORDNAME.Value = wordname;
            // EXCELNAME.Value = excelname;
            string sql = "select teamname,excelname from t_team where id = " + id + " and minername = '" + km + "'";
            DataTable dt = new DataTable();
            dt = db.GetDataTable(sql); //数据源 

            if (excelname != "#")
            {
                dt.Clear();
                DataRow newRow;
                newRow = dt.NewRow();
                newRow["teamname"] = "汇总";
                newRow["excelname"] = excelname;
                dt.Rows.Add(newRow);
            }

            Repeater1.DataSource = dt;
            Repeater1.DataBind();
            //已接收
            string minercheck = "";
            string update_sql = "";
            string sql_minercheck = "select MINERCHECK from T_MINERFLOW where id=" + id + " and MINERNAME='" + km + "'";
            DataTable dt1 = new DataTable();
            if (id != null && id != "")
            {
                dt1 = db.GetDataTable(sql_minercheck); //数据源    

            }
            if (dt1.Rows.Count > 0)
            {
                minercheck = dt1.Rows[0]["MINERCHECK"].ToString();
            }
            if (minercheck != "0" && minercheck != "1")
                update_sql = "update T_MINERFLOW set MINERCHECK='2' where id=" + id + " and MINERNAME='" + km + "'";
            bool flag = db.ExecuteSQL(update_sql);
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {

    }

  
}