using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class plan_planRun_dtz_ShowBlueGraph : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string id = Request.Params["id"];
        string username = Session["username"].ToString();
        b_pid.Value = id;
        //string id = "44";

        DB db = new DB();
        DataTable dt = new DataTable();
        DataTable dd = new DataTable();
        if (id != null && id != "")
        {
            string sql = "select * from T_PLANRUN_DTZ where PID=" + id;
            dt = db.GetDataTable(sql); //数据源    
        }
        if (dt.Rows.Count > 0)
        {
            PName.Value = dt.Rows[0]["PNAME"].ToString();
            blueGraphFlag.Value = dt.Rows[0]["BLUEGRAPHDOCUMENT_R"].ToString() == "" ? "0" : "1";
        }
    }
}