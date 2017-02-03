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


public partial class plan_planrun_bdtz_ghs0_Datasubmit : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
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
            YCZLSubmitDate.Value = dt.Rows[0]["YCZLSUBMITDATE"].ToString();
            CYZLSubmitDate.Value = dt.Rows[0]["CYZLSUBMITDATE"].ToString();
            DMZLDelegateDate.Value = dt.Rows[0]["DMZLDELEGATEDATE"].ToString();
            in_YCZLFILE.Value = dt.Rows[0]["YCZLFILE"].ToString();
            in_CYZLFILE.Value = dt.Rows[0]["CYZLFILE"].ToString();
            in_DMZLFILE.Value = dt.Rows[0]["DMZLFILE"].ToString();

        }
    }
}