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

public partial class plan_planRun_dtz_changeform_FullPlan : BasePage
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
            string sql = "select PNAME,PSOURCE,SOLUCHIEF,ESTIINVESTMENT,to_char(SOLUCOMPDATE_P,'yyyy-mm-dd'),to_char(SOLUCOMPDATE_R,'yyyy-mm-dd')," +
                "to_char(INSTCHECKDATE_P,'yyyy-mm-dd'),to_char(INSTCHECKDATE_R,'yyyy-mm-dd'),to_char(FACTCHECKDATE_P,'yyyy-mm-dd'),to_char(FACTCHECKDATE_R,'yyyy-mm-dd'),to_char(SOLUSUBMITDATE,'yyyy-mm-dd'),to_char(SOLUCHECKDATE,'yyyy-mm-dd'),to_char(SOLUADVICEREPLYDATE,'yyyy-mm-dd')," +
                "to_char(SOLUAPPROVEDATE,'yyyy-mm-dd'),PNUMBER,PLANINVESMENT,DESICONDITIONTABLE,SOLUAPPROVEFILE,FINALSOLUTIONFILE,DESICONDITIONTABLE_N,REMARK from T_PLANRUN_DTZ where pid=" + id;
            dt = db.GetDataTable(sql); //数据源    
            if (dt.Rows.Count > 0)
            {
                PNAME.Value=dt.Rows[0]["PNAME"].ToString();
                PSOURCE.Value=dt.Rows[0]["PSOURCE"].ToString();
                SOLUCHIEF.Value=dt.Rows[0]["SOLUCHIEF"].ToString();
                ESTIINVESTMENT.Value=dt.Rows[0]["ESTIINVESTMENT"].ToString();
                SOLUCOMPDATE_P.Value = dt.Rows[0]["to_char(SOLUCOMPDATE_P,'yyyy-mm-dd')"].ToString();
                SOLUCOMPDATE_R.Value = dt.Rows[0]["to_char(SOLUCOMPDATE_R,'yyyy-mm-dd')"].ToString();
                INSTCHECKDATE_P.Value = dt.Rows[0]["to_char(INSTCHECKDATE_P,'yyyy-mm-dd')"].ToString();
                INSTCHECKDATE_R.Value = dt.Rows[0]["to_char(INSTCHECKDATE_R,'yyyy-mm-dd')"].ToString();
                FACTCHECKDATE_P.Value = dt.Rows[0]["to_char(FACTCHECKDATE_P,'yyyy-mm-dd')"].ToString();
                FACTCHECKDATE_R.Value = dt.Rows[0]["to_char(FACTCHECKDATE_R,'yyyy-mm-dd')"].ToString();
                SOLUSUBMITDATE.Value = dt.Rows[0]["to_char(SOLUSUBMITDATE,'yyyy-mm-dd')"].ToString();
                SOLUCHECKDATE.Value = dt.Rows[0]["to_char(SOLUCHECKDATE,'yyyy-mm-dd')"].ToString();
                SOLUADVICEREPLYDATE.Value = dt.Rows[0]["to_char(SOLUADVICEREPLYDATE,'yyyy-mm-dd')"].ToString();
                SOLUAPPROVEDATE.Value = dt.Rows[0]["to_char(SOLUAPPROVEDATE,'yyyy-mm-dd')"].ToString();
                PNUMBER.Value = dt.Rows[0]["PNUMBER"].ToString();
                PLANINVESMENT.Value = dt.Rows[0]["PLANINVESMENT"].ToString();
                IN_DESICONDITIONTABLE_N.Value = dt.Rows[0]["DESICONDITIONTABLE_N"].ToString();
                IN_DESICONDITIONTABLE.Value = dt.Rows[0]["DESICONDITIONTABLE"].ToString();
                IN_SOLUAPPROVEFILE.Value = dt.Rows[0]["SOLUAPPROVEFILE"].ToString();
                IN_FINALSOLUTIONFILE.Value = dt.Rows[0]["FINALSOLUTIONFILE"].ToString();
                Remark.Value = dt.Rows[0]["REMARK"].ToString();
            }
        }

    }
}