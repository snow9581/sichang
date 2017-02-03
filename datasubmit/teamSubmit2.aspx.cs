using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class datasubmit_teamSubmit2 : BasePage
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
            
            if (wordname != "#") WORDNAME1.Value = wordname;
            else DG.Visible = false;

            EXCELNAME1.Value = excelname;
            if (requirements != "") REQUIREMENTS.Value = requirements;
            else
            {
                RT.Visible = false;
                REQUIREMENTS.Visible = false;
            }


            string teamname = "";
            string km = "";
            if (Session["dm"] != null) teamname = Session["dm"].ToString();
            if (Session["km"] != null) km = Session["km"].ToString();

            string sql2 = "select mineropinion from t_team where id ='" + id + "' and minername = '" + km + "' and teamname = '" + teamname + "'";
            DataTable dt2 = db.GetDataTable(sql2);
            if (dt2.Rows.Count > 0)
            {
                this.SHYJ.Value = dt2.Rows[0][0].ToString();
            }
            //this.TEAM.Value = "sdfsdf,sdfd,sadf,sdfsd";
        }


    }

    public string GetKM(string DM)
    {
        string km = "";
        DB db = new DB();
        string sql = "select km from t_dept where dm = '" + DM + "'";
        System.Data.DataTable dt = new System.Data.DataTable();
        dt = db.GetDataTable(sql);
        if (dt.Rows.Count > 0)
        {
            km = dt.Rows[0][0].ToString();
        }
        return km;

    }
}