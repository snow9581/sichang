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

public partial class plan_planRun_dtz_init_planRun_free : BasePage
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
                string sql = "select PNAME,PSOURCE,REMARK,DESICHIEF,MAJORPROOFREADER,TEMPLATE_B,to_char(INITIALDESISUBMITDATE_P,'yyyy-mm-dd'),to_char(WORKLOADSUBMITDATE_P,'yyyy-mm-dd'),to_char(MAJORDELEGATEDATE_P,'yyyy-mm-dd') from T_PLANRUN_DTZ where PID=" + id;
                dt = db.GetDataTable(sql); //数据源    
            }
            if (dt.Rows.Count > 0)
            {
                PName.Value = dt.Rows[0]["PNAME"].ToString();
                PSource.Value = dt.Rows[0]["PSOURCE"].ToString();
                Remark.Value = dt.Rows[0]["REMARK"].ToString();
                DESICHIEF.Value = dt.Rows[0]["DESICHIEF"].ToString();
                MAJORPROOFREADER.Value = dt.Rows[0]["MAJORPROOFREADER"].ToString();
                MAJORDELEGATEDATE_P.Value = dt.Rows[0]["to_char(MAJORDELEGATEDATE_P,'yyyy-mm-dd')"].ToString();
                WORKLOADSUBMITDATE_P.Value = dt.Rows[0]["to_char(WORKLOADSUBMITDATE_P,'yyyy-mm-dd')"].ToString();
                INITIALDESISUBMITDATE_P.Value = dt.Rows[0]["to_char(INITIALDESISUBMITDATE_P,'yyyy-mm-dd')"].ToString();
                PTemplate.Value = dt.Rows[0]["TEMPLATE_B"].ToString();
            }

        }
    }
}