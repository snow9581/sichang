using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class plan_planRun_dtz_MainOfWhiteGraphAndBlueGraph : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string id = Request.Params["id"];
        hd_id.Value = id;
        DB db = new DB();
        DataTable dt = new DataTable();
        if (id != null && id != "")
        {
            string sql = "select WHITEGRAPHCHECKDATE_R,SECONDCOMMISSIONDATE from T_PLANRUN_DTZ where PID=" + id;
            dt = db.GetDataTable(sql); //数据源        
        }
        if (dt.Rows.Count > 0)
        {
            WHITEGRAPHCHECKDATE_R.Value = dt.Rows[0]["WHITEGRAPHCHECKDATE_R"].ToString();
            SECONDCOMMISSIONDATE.Value = dt.Rows[0]["SECONDCOMMISSIONDATE"].ToString();
        }
    }
}