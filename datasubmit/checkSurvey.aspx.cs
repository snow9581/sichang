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
        if (!IsPostBack) {
            string id = Request.Params["id"];
            string name = "";
            string wordname = "";
            string excelname = "";
            string requirements = "";
            DB db = new DB();
            DataTable dt = new DataTable();
            if (id != null && id != "") {
                string sql = "select name,wordname,excelname,requirements from t_instituteinvestigationflow where id=" + id;
                dt = db.GetDataTable(sql); //数据源    
            }
            if (dt.Rows.Count > 0) {
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
        }
       
    }

    protected void Button1_Click(object sender, EventArgs e)
    {

    }
    protected void Button2_Click(object sender, EventArgs e)
    {
       
    }
}
