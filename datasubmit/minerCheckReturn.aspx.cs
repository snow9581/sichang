using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class datasubmit_minerCheckReturn : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {

        string teamname = "";
        string km = "";
        if (Session["dept"] != null)
        {
            teamname = Session["dept"].ToString();
            km = GetKM(teamname);

        }
        if (Session["km"] != null) km = Session["km"].ToString();

        string id = Request.Params["id"];
        hd_id.Value = id;
        NAME.Value = Request.Params["name"];
        DB db = new DB();
        string sql2 = "select mineropinion from t_minerflow where id ='" + id + "' and minername = '" + km + "'";
        DataTable dt2 = db.GetDataTable(sql2);
        if (dt2.Rows.Count > 0)
        {
            this.SHYJ.Value = dt2.Rows[0][0].ToString();
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