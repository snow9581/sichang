using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class plan_planRun_dtz_MainOfCommissionAndWorkload : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string id = Request.Params["id"];
        hd_id.Value = id;
        string username = Session["username"].ToString();
        DB db = new DB();
        DataTable dt = new DataTable();
        DataTable dd = new DataTable();
        if (id != null && id != "")
        {
            string sql = "select MAJORDELEGATEDATE_R from T_PLANRUN_DTZ where PID=" + id;
            dt = db.GetDataTable(sql); //数据源
        }
        if (dt.Rows.Count > 0)
        {
            commissionFlag.Value = dt.Rows[0]["MAJORDELEGATEDATE_R"].ToString() != "" ? "0" : "";
            string sql_workload = "select * from T_WORKLOADSUBMIT where W_PID=" + id + " and W_NAME='" + username + "'";
            dd = db.GetDataTable(sql_workload); //数据源 
            if (dd.Rows.Count > 0)
                selfWorkload.Value = "1";
            else
                selfWorkload.Value = "0";
        }
    }
}