using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class datasubmit_initSurveyReturn : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string id = Request.Params["id"];
        string name = "";
        string wordname = "";
        string excelname = "";
        string leader = "";
        string leaderopinion = "";
        string gykd = "";
        string requirements = "";
        DB db = new DB();
        DataTable dt = new DataTable();
        if (id != null && id != "")
        {
            string sql = "select name,wordname,excelname,requirements,leaderopinion,leader,gykd from t_instituteinvestigationflow where id=" + id;
            dt = db.GetDataTable(sql); //数据源    
        }
        if (dt.Rows.Count > 0)
        {
            name = dt.Rows[0]["name"].ToString();
            wordname = dt.Rows[0]["wordname"].ToString();
            excelname = dt.Rows[0]["excelname"].ToString();
            leader = dt.Rows[0]["leader"].ToString();
            leaderopinion = dt.Rows[0]["leaderopinion"].ToString();
            gykd = dt.Rows[0]["gykd"].ToString();
            requirements = dt.Rows[0]["requirements"].ToString();
        }
        hd_id.Value = id;
        NAME.Value = name;
        LEADER.Value = leader;
        SHYJ.Value = leaderopinion.Replace("\r\n","\n");
        if (wordname != "#") WORDNAME.Value = wordname;
        else DG.Visible = false;

        EXCELNAME.Value = excelname;

        if (requirements != "") REQUIREMENTS.Value = requirements.Replace("\r\n", "\n");
        else
        {
            RT.Visible = false;
            REQUIREMENTS.Visible = false;
        }
        string[] gykds = gykd.Split(',');
        for (int i = 0; i < gykds.Length; i++)
        {
            if (gykds[i].ToString() == "第一油矿")
            {
                GYKD1.Checked = true;
            }
            if (gykds[i].ToString() == "第二油矿")
            {
                GYKD2.Checked = true;
            }
            if (gykds[i].ToString() == "第三油矿")
            {
                GYKD3.Checked = true;
            }
            if (gykds[i].ToString() == "第四油矿")
            {
                GYKD4.Checked = true;
            }
            if (gykds[i].ToString() == "第五油矿")
            {
                GYKD5.Checked = true;
            }
            if (gykds[i].ToString() == "试验大队")
            {
                sy.Checked = true;
            }
        }
    }
}