using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class plan_planRun_dtz_ShowCommission : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        userName.Value = Session["username"].ToString();
        string id = Request.Params["id"];
        hd_id.Value = id;
        hd_type.Value = Request.Params["type"];
        DB db = new DB();
        DataTable dt = new DataTable();
        if (id != null && id != "")
        {
            string sql = "select MAJORDELEGATEDATE_R,SECONDCOMMISSIONDATE from T_PLANRUN_DTZ where PID=" + id;
            dt = db.GetDataTable(sql); //数据源        
        }
        if (dt.Rows.Count > 0)
        {
            firstComFlag.Value = dt.Rows[0]["MAJORDELEGATEDATE_R"].ToString() == "" ? "" : "1";
            secondComFlag.Value = dt.Rows[0]["SECONDCOMMISSIONDATE"].ToString() == "" ? "" : "1";
        }
        
    }
}