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
using System.Web.Script.Serialization;
public partial class plan_planRun_dtz_changeform_FullBudget : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string id = Request.Params["id"];
        hd_index.Value = id;
        string userlevel = Convert.ToString(Session["userlevel"]);
        userLevel.Value = userlevel;
        DB db = new DB();
        DataTable dt = new DataTable();
        if (id != null && id != "")
        {
            string sql = "select BUDGETCHIEF,to_char(WORKLOADSUBMITDATE_P,'yyyy-mm-dd'),to_char(WORKLOADSUBMITDATE_R,'yyyy-mm-dd'),to_char(BUDGETCOMPDATE_P,'yyyy-mm-dd')," +
                "to_char(BUDGETCOMPDATE_R,'yyyy-mm-dd'),to_char(BUDGETADJUSTDATE_P,'yyyy-mm-dd'),to_char(BUDGETADJUSTDATE_R,'yyyy-mm-dd'),"+
                "to_char(INITIALDESISUBMITDATE_P,'yyyy-mm-dd'),to_char(INITIALDESISUBMITDATE_R,'yyyy-mm-dd'),FINALBUDGETFILE,REMARK from T_PLANRUN_DTZ where pid=" + id;
            dt = db.GetDataTable(sql); //数据源    
            if (dt.Rows.Count > 0)
            {
                BUDGETCHIEF.Value = dt.Rows[0]["BUDGETCHIEF"].ToString();

                WORKLOADSUBMITDATE_P.Value = dt.Rows[0]["to_char(WORKLOADSUBMITDATE_P,'yyyy-mm-dd')"].ToString();
                WORKLOADSUBMITDATE_R.Value = dt.Rows[0]["to_char(WORKLOADSUBMITDATE_R,'yyyy-mm-dd')"].ToString();
                BUDGETCOMPDATE_P.Value = dt.Rows[0]["to_char(BUDGETCOMPDATE_P,'yyyy-mm-dd')"].ToString();
                BUDGETCOMPDATE_R.Value = dt.Rows[0]["to_char(BUDGETCOMPDATE_R,'yyyy-mm-dd')"].ToString();
                INITIALDESISUBMITDATE_P.Value = dt.Rows[0]["to_char(INITIALDESISUBMITDATE_P,'yyyy-mm-dd')"].ToString();
                INITIALDESISUBMITDATE_R.Value = dt.Rows[0]["to_char(INITIALDESISUBMITDATE_R,'yyyy-mm-dd')"].ToString();
                BUDGETADJUSTDATE_P.Value = dt.Rows[0]["to_char(BUDGETADJUSTDATE_P,'yyyy-mm-dd')"].ToString();
                BUDGETADJUSTDATE_R.Value = dt.Rows[0]["to_char(BUDGETADJUSTDATE_R,'yyyy-mm-dd')"].ToString();
                Remark.Value = dt.Rows[0]["REMARK"].ToString();
                IN_FINALBUDGETFILE.Value = dt.Rows[0]["FINALBUDGETFILE"].ToString();  
            }
        }
    }
}