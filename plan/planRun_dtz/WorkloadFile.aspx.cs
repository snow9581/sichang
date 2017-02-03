using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public partial class plan_planRun_dtz_WorkloadFile : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string id = Request.Params["id"];
            string username = Session["username"].ToString();
            //string id = "44";

            DB db = new DB();
            DataTable dt = new DataTable();
            DataTable dd = new DataTable();
            if (id != null && id != "")
            {
                string sql = "select * from T_PLANRUN_DTZ where PID=" + id;
                dt = db.GetDataTable(sql); //数据源    
            }
            hd_id.Value = id;
            if (dt.Rows.Count > 0)
            {
                PName.Value = dt.Rows[0]["PNAME"].ToString();
                PNumber.Value = dt.Rows[0]["PNUMBER"].ToString();
                planflag.Value = dt.Rows[0]["PLANFLAG"].ToString();
                string sql_workload = "select W_FILE from T_WORKLOADSUBMIT where W_PID=" + id + " and W_NAME='" + username + "'";
                dd = db.GetDataTable(sql_workload); //数据源 
                if (dd.Rows.Count > 0)
                    hd_WorkloadFile.Value = dd.Rows[0]["W_FILE"].ToString();
            }
        }
    }
}
