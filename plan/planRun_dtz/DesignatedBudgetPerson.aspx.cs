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

public partial class plan_planRun_dtz_DesignatedBudgetPerson : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string id = Request.Params["id"];
            //string id = "44";
            hd_id.Value = id;
            DB db = new DB();
            DataTable dt = new DataTable();
            if (id != null && id != "")
            {
                string sql = "select PNAME,REMARK,BUDGETCHIEF,BUDGETTEMPLATE,to_char(INITIALDESISUBMITDATE_P,'yyyy-mm-dd'),to_char(BUDGETCOMPDATE_P,'yyyy-mm-dd') from T_PLANRUN_DTZ where PID=" + id;
                dt = db.GetDataTable(sql); //数据源    
            }
            if (dt.Rows.Count > 0)
            {
                PName.Value = dt.Rows[0]["PNAME"].ToString();
                Remark.Value = dt.Rows[0]["REMARK"].ToString();
                BUDGETCHIEF.Value = dt.Rows[0]["BUDGETCHIEF"].ToString();
                PTemplate.Value = dt.Rows[0]["BUDGETTEMPLATE"].ToString();
                BUDGETCOMPDATE_P.Value = dt.Rows[0]["to_char(BUDGETCOMPDATE_P,'yyyy-mm-dd')"].ToString();
                INITIALDESISUBMITDATE_P.Value = dt.Rows[0]["to_char(INITIALDESISUBMITDATE_P,'yyyy-mm-dd')"].ToString();
            }

        }
    }
}
