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

public partial class plan_planRun_dtz_WritePlan : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string id = Request.Params["id"];
            //string id = "44";
            string Name = "";
            string Source = "";
            
            DB db = new DB();
            DataTable dt = new DataTable();
            if (id != null && id != "")
            {
                string sql = "select PNAME,PSOURCE,ESTIINVESTMENT,DRAFTSOLUTIONFILE from T_PLANRUN_DTZ where PID=" + id;
                dt = db.GetDataTable(sql); //数据源    
            }
            if (dt.Rows.Count > 0)
            {
                Name = dt.Rows[0]["PNAME"].ToString();
                Source = dt.Rows[0]["PSOURCE"].ToString();
                EstiInvestment.Value = dt.Rows[0]["ESTIINVESTMENT"].ToString();
                hd_DraftSolutionFile.Value = dt.Rows[0]["DRAFTSOLUTIONFILE"].ToString();
            }
            hd_id.Value = id;
            H_PName.Value = Name;
            H_PSource.Value = Source;
            
        }
    }
}
