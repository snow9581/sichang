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

public partial class plan_planRun_dtz_InitialDesiSubmit : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string id = Request.Params["id"];
            //string id = "44";

            DB db = new DB();
            DataTable dt = new DataTable();
            if (id != null && id != "")
            {
                string sql = "select PNAME,PNUMBER,WORKLOADFILE,DRAFTBUDGETFILE,REMARK,PLANFLAG,to_char(INITIALDESISUBMITDATE_R,'yyyy-mm-dd') from T_PLANRUN_DTZ where PID=" + id;
                dt = db.GetDataTable(sql); //数据源    
            }
            hd_id.Value = id;
            if (dt.Rows.Count > 0)
            {
                PName.Value = dt.Rows[0]["PNAME"].ToString();
                PNumber.Value = dt.Rows[0]["PNUMBER"].ToString();
                DraftBudgetFile.Value = dt.Rows[0]["DRAFTBUDGETFILE"].ToString();
                Remark.Value = dt.Rows[0]["REMARK"].ToString();
                hd_planflag.Value = dt.Rows[0]["PLANFLAG"].ToString();
                InitialDesiSubmitDate_R.Value = dt.Rows[0]["to_char(INITIALDESISUBMITDATE_R,'yyyy-mm-dd')"].ToString();
            }
        }
    }
}
