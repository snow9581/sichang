using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class datasubmit_minerTeamCheck : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string id = Request.Params["id"];
            string title = Request.Params["title"];
            TITLE.Value = title;
            TEAM.Value = Request.Params["team"].ToString();
            string starttime = "";
            string wordname = "";
            string excelname = "";
            DB db = new DB();
            DataTable dt = new DataTable();
            if (id != null && id != "")
            {
                string sql = "select starttime,wordname,excelname from t_team where rowid='" + id + "'";
                dt = db.GetDataTable(sql); //数据源    
            }
            if (dt.Rows.Count > 0)
            {
                starttime = dt.Rows[0]["starttime"].ToString();
                wordname = dt.Rows[0]["wordname"].ToString();
                excelname = dt.Rows[0]["excelname"].ToString();
            }
            hd_id.Value = id;
            RQ.Value = starttime;
         //   WORDNAME.Value = wordname;
            EXCELNAME.Value = excelname;

           
        }

    }

}
