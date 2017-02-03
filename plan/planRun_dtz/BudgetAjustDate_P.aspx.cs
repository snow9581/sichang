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

public partial class plan_planRun_dtz_BudgetAjustDate_P : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string id = Request.Params["id"];
            //string id = "44";

            DB db = new DB();
            DataTable dt = new DataTable();
            DataTable t_dt = new DataTable();
            if (id != null && id != "")
            {
                string sql = "select * from T_PLANRUN_DTZ where PID=" + id;
                dt = db.GetDataTable(sql); //数据源 
                string t_sql = "select BUDGETADJUSTCYCLE from T_PLANTEMPLATE_C where TEMPNAME='" + dt.Rows[0]["BUDGETTEMPLATE"].ToString()+"'";
                t_dt = db.GetDataTable(t_sql); //数据源 
            }
            hd_id.Value = id;
            if (dt.Rows.Count > 0)
            {
                PName.Value = dt.Rows[0]["PNAME"].ToString();
                PNumber.Value = dt.Rows[0]["PNUMBER"].ToString();
                Remark.Value = dt.Rows[0]["REMARK"].ToString();
                planflag.Value = dt.Rows[0]["PLANFLAG"].ToString();
            }
            if (t_dt.Rows.Count > 0)
            {
                BUDGETADJUSTDATE_P.Value = DateTime.Now.AddDays(int.Parse(t_dt.Rows[0]["BUDGETADJUSTCYCLE"].ToString())).ToShortDateString().Replace("/", "-");
            }
        }
    }
}