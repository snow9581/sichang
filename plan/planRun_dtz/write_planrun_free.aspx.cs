using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class plan_planRun_dtz_write_planrun_free : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string PID = Request.Params["id"];
            //string PID = "44";        
            DB db = new DB();
            string sql = "select PNAME,PSOURCE,SOLUCHIEF,to_char(FACTCHECKDATE_R,'yyyy-mm-dd'),"+
             "to_char(SOLUSUBMITDATE,'yyyy-mm-dd'),to_char(SOLUCHECKDATE,'yyyy-mm-dd'),to_char(SOLUADVICEREPLYDATE,'yyyy-mm-dd'),"+
             "to_char(SOLUAPPROVEDATE,'yyyy-mm-dd'), PLANINVESMENT,PNUMBER,INSTAPPRSOLUTIONFILE,FACTAPPRSOLUTIONFILE,SOLUAPPROVEFILE," +
             "FINALSOLUTIONFILE,REMARK,DESICONDITIONTABLE  from T_PLANRUN_DTZ where PID=" + PID;
            DataTable dt = db.GetDataTable(sql);
            ID.Value = PID;
            PName.Value = dt.Rows[0]["PNAME"].ToString();
            PSource.Value = dt.Rows[0]["PSOURCE"].ToString();
            SoluChief.Value = dt.Rows[0]["SOLUCHIEF"].ToString();
            SoluSubmitDate.Value = dt.Rows[0]["to_char(SOLUSUBMITDATE,'yyyy-mm-dd')"].ToString();
            SoluCheckDate.Value = dt.Rows[0]["to_char(SOLUCHECKDATE,'yyyy-mm-dd')"].ToString();
            PLANINVESMENT.Value = dt.Rows[0]["PLANINVESMENT"].ToString();
            SoluAdviceReplyDate.Value = dt.Rows[0]["to_char(SOLUADVICEREPLYDATE,'yyyy-mm-dd')"].ToString();
            SoluApproveDate.Value = dt.Rows[0]["to_char(SOLUAPPROVEDATE,'yyyy-mm-dd')"].ToString();
            PNumber.Value = dt.Rows[0]["PNUMBER"].ToString();
            
            in_FactApprSolutionFile.Value = dt.Rows[0]["FACTAPPRSOLUTIONFILE"].ToString();
            in_FinalSolutionFile.Value = dt.Rows[0]["FINALSOLUTIONFILE"].ToString();
            in_SoluApproveFile.Value = dt.Rows[0]["SOLUAPPROVEFILE"].ToString();
            IN_DESICONDITIONTABLE.Value = dt.Rows[0]["DESICONDITIONTABLE"].ToString();
            Remark.Value = dt.Rows[0]["REMARK"].ToString();
        }
    }
}