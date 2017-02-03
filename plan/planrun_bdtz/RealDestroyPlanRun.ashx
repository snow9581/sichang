<%@ WebHandler Language="C#" Class="RealDestroyPlanRun" %>

using System;
using System.Web;
using System.Data;
public class RealDestroyPlanRun : BaseHandler {

    public override void AjaxProcess(HttpContext context)
    {
        string ID = context.Request.Params["id"];
        DB db = new DB();
        string sql_file = "select * from T_PLANRUN_BDTZ where PID='" + ID + "'";
        DataTable dt = new DataTable();
        dt = db.GetDataTable(sql_file);

        string DRAFTSOLUTIONFILE = dt.Rows[0]["DRAFTSOLUTIONFILE"].ToString();
        string APPRSOLUTIONFILE = dt.Rows[0]["APPRSOLUTIONFILE"].ToString();

        string DMZLFILE = dt.Rows[0]["DMZLFILE"].ToString();
        string CYZLFILE = dt.Rows[0]["CYZLFILE"].ToString();
        string YCZLFILE = dt.Rows[0]["YCZLFILE"].ToString();
        
        string sql = "delete from T_PLANRUN_BDTZ where PID='" + ID + "'";
        bool result = db.ExecuteSQL(sql);
        if (result)
        {
            if (DRAFTSOLUTIONFILE != "" && DRAFTSOLUTIONFILE != "#")
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
            if (APPRSOLUTIONFILE != "" && APPRSOLUTIONFILE != "#")
            {
                try
                {
                    FTP ftp = new FTP();
                    ftp.Delete("ftp_planfile", APPRSOLUTIONFILE);
                }
                catch (Exception ex)
                {
                    SClog.insert("error", "ftp APPRSOLUTIONFILE delete failure" + ex.ToString());
                }
            }
           
            if (DMZLFILE != "" && DMZLFILE != "#")
            {
                try
                {
                    FTP ftp = new FTP();
                    ftp.Delete("ftp_planfile", DMZLFILE);
                }
                catch (Exception ex)
                {
                    SClog.insert("error", "ftp DMZLFILE delete failure" + ex.ToString());
                }
            }
            if (CYZLFILE != "" && CYZLFILE != "#")
            {
                try
                {
                    FTP ftp = new FTP();
                    ftp.Delete("ftp_planfile", CYZLFILE);
                }
                catch (Exception ex)
                {
                    SClog.insert("error", "ftp CYZLFILE delete failure" + ex.ToString());
                }
            }
            if (YCZLFILE != "" && YCZLFILE != "#")
            {
                try
                {
                    FTP ftp = new FTP();
                    ftp.Delete("ftp_planfile", YCZLFILE);
                }
                catch (Exception ex)
                {
                    SClog.insert("error", "ftp YCZLFILE delete failure" + ex.ToString());
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