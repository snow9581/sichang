<%@ WebHandler Language="C#" Class="RealDestroyPlanRun" %>

using System;
using System.Web;
using System.Data;
public class RealDestroyPlanRun :BaseHandler {

    public override void AjaxProcess(HttpContext context)
    {
        string ID = context.Request.Params["id"];
        DB db = new DB();
        string sql_file = "select * from T_PLANRUN_DTZ where PID='" + ID + "'";
        DataTable dt=new DataTable();
        dt = db.GetDataTable(sql_file);

        string DRAFTSOLUTIONFILE = dt.Rows[0]["DRAFTSOLUTIONFILE"].ToString();

        string FACTAPPRSOLUTIONFILE = dt.Rows[0]["FACTAPPRSOLUTIONFILE"].ToString();
      
        string WORKLOADFILE = dt.Rows[0]["WORKLOADFILE"].ToString();

        string DRAFTBUDGETFILE = dt.Rows[0]["DRAFTBUDGETFILE"].ToString();
        
        
        string sql = "delete from T_PLANRUN_DTZ where PID='" + ID + "'";
        bool result = db.ExecuteSQL(sql);
        if (result)
        {
            if (DRAFTSOLUTIONFILE != "" && DRAFTSOLUTIONFILE!="#")
            {
                try
                {
                    FTP ftp = new FTP();
                    ftp.Delete("ftp_planfile", DRAFTSOLUTIONFILE);
                }
                catch (Exception ex)
                {
                    SClog.insert("error", "ftp DRAFTSOLUTIONFILE delete failure" + ex.ToString());
                }
            }
            if (FACTAPPRSOLUTIONFILE != "" && FACTAPPRSOLUTIONFILE != "#")
            {
                try
                {
                    FTP ftp = new FTP();
                    ftp.Delete("ftp_planfile", FACTAPPRSOLUTIONFILE);
                }
                catch (Exception ex)
                {
                    SClog.insert("error", "ftp FACTAPPRSOLUTIONFILE delete failure" + ex.ToString());
                }
            }
           
            if (WORKLOADFILE != "" && WORKLOADFILE != "#")
            {
                try
                {
                    FTP ftp = new FTP();
                    ftp.Delete("ftp_planfile", WORKLOADFILE);
                }
                catch (Exception ex)
                {
                    SClog.insert("error", "ftp WORKLOADFILE delete failure" + ex.ToString());
                }
            }
            if (DRAFTBUDGETFILE != "" && DRAFTBUDGETFILE != "#")
            {
                try
                {
                    FTP ftp = new FTP();
                    ftp.Delete("ftp_planfile", DRAFTBUDGETFILE);
                }
                catch (Exception ex)
                {
                    SClog.insert("error", "ftp DRAFTBUDGETFILE delete failure" + ex.ToString());
                }
            }
            string state = "{\"success\":true}";

            context.Response.Write(state);
            context.Response.End();
        }
        else
        {
            context.Response.Write("<script>alert('  错误!\\n删除失败！');</script>");
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}