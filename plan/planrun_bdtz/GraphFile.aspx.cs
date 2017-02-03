
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


public partial class plan_planRun_bdtz_GraphFile : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string id = Request.Params["id"];
            //string id = "4";

            DB db = new DB();
            DataTable dt = new DataTable();
            if (id != null && id != "")
            {
                string sql = "select * from T_PLANRUN_BDTZ where PID=" + id;
                dt = db.GetDataTable(sql); //数据源    
            }
            hd_id.Value = id;
            if (dt.Rows.Count > 0)
            {
                PName.Value = dt.Rows[0]["PNAME"].ToString();
                PNumber.Value = dt.Rows[0]["PNUMBER"].ToString();
                SOLUCHIEF.Value = dt.Rows[0]["SOLUCHIEF"].ToString();
                WorkloadFile.Value = dt.Rows[0]["INITDESIGNFILE"].ToString();
            }
        }
    }
}
