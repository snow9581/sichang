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
        if (!IsPostBack)
        {
            string id = Request.Params["id"];
            string name = "";
            string wordname = "";
            string excelname = "";
            string requirements = "";
            DB db = new DB();
            DataTable dt = new DataTable();
            if (id != null && id != "")
            {
                string sql = "select name,wordname,excelname,requirements from t_instituteinvestigationflow where id=" + id;
                dt = db.GetDataTable(sql); //数据源    
            }
            if (dt.Rows.Count > 0)
            {
                name = dt.Rows[0]["name"].ToString();
                wordname = dt.Rows[0]["wordname"].ToString();
                excelname = dt.Rows[0]["excelname"].ToString();
                requirements = dt.Rows[0]["requirements"].ToString();
            }
            hd_id.Value = id;
            NAME.Value = name;
            
            if (wordname != "#") WORDNAME.Value = wordname;
            else DG.Visible = false;

            EXCELNAME.Value = excelname;

            if (requirements != "") REQUIREMENTS.Value = requirements;
            else
            {
                RT.Visible = false;
                REQUIREMENTS.Visible = false;
            }

            //this.TEAM.Value = "sdfsdf,sdfd,sadf,sdfsd";
            //已接收
            string receiveTime = DateTime.Now.ToString();
            string update_sql = "update T_MINERFLOW set MINERTEAMCHECK='2', RECEIVETIME=to_date('" + receiveTime + "','yyyy-mm-dd hh24:mi:ss') where id=" + id + " and MINERNAME='" + Session["km"] + "'";
            bool flag=db.ExecuteSQL(update_sql);
           
            
        }
    }
}