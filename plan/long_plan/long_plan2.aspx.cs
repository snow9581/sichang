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

public partial class long_plan_long_plan2 : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {

        string PID = Request.Params["id"];
        DB db = new DB();
        string sql = "select PNAME,SOLUCHIEF,to_char(SoluCompDate_R,'yyyy-mm-dd')," +
         "to_char(SoluSubmitDate,'yyyy-mm-dd'),to_char(InstCheckDate_R,'yyyy-mm-dd'),to_char(FactCheckDate_R,'yyyy-mm-dd')," +
         "to_char(SoluCheckDate,'yyyy-mm-dd'),to_char(SoluAdviceReplyDate,'yyyy-mm-dd'),to_char(SoluApproveDate,'yyyy-mm-dd')," +
         "DraftSolutionFile,InstApprSolutionFile,FACTAPPRSOLUTIONFILE,FinalSolutionFile from T_PLANRUN_ZCQ where PID=" + PID;
        DataTable dt = db.GetDataTable(sql);
        ID.Value = PID;
        PName.Value = dt.Rows[0]["PNAME"].ToString();
        SoluChief.Value = dt.Rows[0]["SoluChief"].ToString();
        //SoluCompDate_R.Value = dt.Rows[0]["to_char(SoluCompDate_R,'yyyy-mm-dd')"].ToString();
        //InstCheckDate_R.Value = dt.Rows[0]["to_char(InstCheckDate_R,'yyyy-mm-dd')"].ToString();
        //FactCheckDate_R.Value = dt.Rows[0]["to_char(FactCheckDate_R,'yyyy-mm-dd')"].ToString();
        in_DraftSolutionFile.Value = dt.Rows[0]["DraftSolutionFile"].ToString();
        in_InstApprSolutionFile.Value = dt.Rows[0]["InstApprSolutionFile"].ToString();
        in_FactAppSolutionFile.Value = dt.Rows[0]["FACTAPPRSOLUTIONFILE"].ToString();
    }
}