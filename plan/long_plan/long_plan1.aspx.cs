using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

public partial class long_plan_long_plan1 : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {

        string PID = Request.Params["id"];
        DB db = new DB();           
        string sql = "select PNAME,SOLUCHIEF,to_char(SoluCompDate_R,'yyyy-mm-dd')," +
         "to_char(SoluSubmitDate,'yyyy-mm-dd'),to_char(InstCheckDate_R,'yyyy-mm-dd'),to_char(FactCheckDate_R,'yyyy-mm-dd')," +
         "to_char(SoluCheckDate,'yyyy-mm-dd'),to_char(SoluAdviceReplyDate,'yyyy-mm-dd'),to_char(SoluApproveDate,'yyyy-mm-dd')," +
         "DraftSolutionFile,InstApprSolutionFile,FACTAPPRSOLUTIONFILE,FinalSolutionFile,APPROVEFILE from T_PLANRUN_ZCQ where PID=" + PID;
        DataTable dt = db.GetDataTable(sql);
        ID.Value = PID;
        PName.Value = dt.Rows[0]["PNAME"].ToString();
        SoluChief.Value = dt.Rows[0]["SoluChief"].ToString();
        SoluSubmitDate.Value = dt.Rows[0]["to_char(SoluSubmitDate,'yyyy-mm-dd')"].ToString();
        SoluCheckDate.Value = dt.Rows[0]["to_char(SoluCheckDate,'yyyy-mm-dd')"].ToString();
        SoluAdviceReplyDate.Value = dt.Rows[0]["to_char(SoluAdviceReplyDate,'yyyy-mm-dd')"].ToString();
        in_FinalSolutionFile.Value = dt.Rows[0]["FinalSolutionFile"].ToString();
        in_APPROVEFILE.Value = dt.Rows[0]["APPROVEFILE"].ToString();
    }
}
