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

public partial class crud_tables_plan_init_planRun_dtz : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string organization = Convert.ToString(Session["dm"]);
        Organization.Value = organization;
        if (!IsPostBack)
        {
            string id = Request.Params["id"];
            //string id = "44";
            DB db = new DB();
            DataTable dt = new DataTable();
            if (id != null && id != "")
            {
                string sql = "select PNAME,PSOURCE,SOLUCHIEF,to_char(SOLUCOMPDATE_P,'yyyy-mm-dd'),to_char(INSTCHECKDATE_P,'yyyy-mm-dd'),to_char(FACTCHECKDATE_P,'yyyy-mm-dd'),REMARK,PLANFLAG_DESIGN from T_PLANRUN_DTZ where PID=" + id;
                dt = db.GetDataTable(sql); //数据源    
            }
            hd_id.Value = id;
            if (dt.Rows.Count > 0)
            {
                PName.Value = dt.Rows[0]["PNAME"].ToString();
                PSource.Value = dt.Rows[0]["PSOURCE"].ToString();
                SoluChief.Value = dt.Rows[0]["SOLUCHIEF"].ToString();
                SOLUCOMPDATE_P.Value = dt.Rows[0]["to_char(SOLUCOMPDATE_P,'yyyy-mm-dd')"].ToString();
                INSTCHECKDATE_P.Value = dt.Rows[0]["to_char(INSTCHECKDATE_P,'yyyy-mm-dd')"].ToString();
                FACTCHECKDATE_P.Value = dt.Rows[0]["to_char(FACTCHECKDATE_P,'yyyy-mm-dd')"].ToString();
                Remark.Value = dt.Rows[0]["REMARK"].ToString();
                PLANFLAG_DESIGN.Value = dt.Rows[0]["PLANFLAG_DESIGN"].ToString();
            }
        }
    }
}
