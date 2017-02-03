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

public partial class plan_planRun_dtz_changeform_FullDesign : BasePage
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
            string sql = "select DESICHIEF,MAJORPROOFREADER,to_char(MAJORDELEGATEDATE_R,'yyyy-mm-dd'),to_char(MAJORDELEGATEDATE_P,'yyyy-mm-dd'),PLANARRIVALFILENUMBER,to_char(PLANARRIVALDATE,'yyyy-mm-dd'),DESIAPPROVALARRIVALFILENUMBER,to_char(DESIAPPROVALARRIVALDATE,'yyyy-mm-dd')," +
                "to_char(WHITEGRAPHCHECKDATE_P,'yyyy-mm-dd'),to_char(WHITEGRAPHCHECKDATE_R,'yyyy-mm-dd'),to_char(BLUEGRAPHDOCUMENT_P,'yyyy-mm-dd'),to_char(BLUEGRAPHDOCUMENT_R,'yyyy-mm-dd'),DESIAPPRFILE,PLANARRIVALFILE,REMARK,to_char(SECONDCOMMISSIONDATE,'yyyy-mm-dd') from T_PLANRUN_DTZ where pid=" + id;
            dt = db.GetDataTable(sql); //数据源    
            if (dt.Rows.Count > 0)
            {
                DESICHIEF.Value = dt.Rows[0]["DESICHIEF"].ToString();
                MAJORPROOFREADER.Value = dt.Rows[0]["MAJORPROOFREADER"].ToString();
                PLANARRIVALFILENUMBER.Value = dt.Rows[0]["PLANARRIVALFILENUMBER"].ToString();
                PLANARRIVALDATE.Value = dt.Rows[0]["to_char(PLANARRIVALDATE,'yyyy-mm-dd')"].ToString();
                DESIAPPROVALARRIVALFILENUMBER.Value = dt.Rows[0]["DESIAPPROVALARRIVALFILENUMBER"].ToString();
                DESIAPPROVALARRIVALDATE.Value = dt.Rows[0]["to_char(DESIAPPROVALARRIVALDATE,'yyyy-mm-dd')"].ToString();
                WHITEGRAPHCHECKDATE_P.Value = dt.Rows[0]["to_char(WHITEGRAPHCHECKDATE_P,'yyyy-mm-dd')"].ToString();
                WHITEGRAPHCHECKDATE_R.Value = dt.Rows[0]["to_char(WHITEGRAPHCHECKDATE_R,'yyyy-mm-dd')"].ToString();
                BLUEGRAPHDOCUMENT_P.Value = dt.Rows[0]["to_char(BLUEGRAPHDOCUMENT_P,'yyyy-mm-dd')"].ToString();
                BLUEGRAPHDOCUMENT_R.Value = dt.Rows[0]["to_char(BLUEGRAPHDOCUMENT_R,'yyyy-mm-dd')"].ToString();
                MAJORDELEGATEDATE_P.Value = dt.Rows[0]["to_char(MAJORDELEGATEDATE_P,'yyyy-mm-dd')"].ToString();
                MAJORDELEGATEDATE_R.Value = dt.Rows[0]["to_char(MAJORDELEGATEDATE_R,'yyyy-mm-dd')"].ToString();
                SECONDCOMMISSIONDATE.Value = dt.Rows[0]["to_char(SECONDCOMMISSIONDATE,'yyyy-mm-dd')"].ToString();

                IN_DESIAPPRFILE.Value = dt.Rows[0]["DESIAPPRFILE"].ToString();
                IN_PLANARRIVALFILE.Value = dt.Rows[0]["PLANARRIVALFILE"].ToString();
                Remark.Value = dt.Rows[0]["REMARK"].ToString();
            }
        }
    }
}