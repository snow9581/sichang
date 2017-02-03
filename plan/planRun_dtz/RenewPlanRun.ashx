<%@ WebHandler Language="C#" Class="RenewPlanRun" %>
//将"废弃流程库"中的流程恢复到"计划运行"中
using System;
using System.Web;

public class RenewPlanRun : BaseHandler {

    public override void AjaxProcess(HttpContext context)
    {
        string ID = context.Request.Params["id"];
        DB db = new DB();

        string sql = "update T_PLANRUN_DTZ set BUFFER=0 where PID='" + ID + "'";
        bool result = db.ExecuteSQL(sql);
        if (result)
        {
            string state = "{\"success\":true}";
            context.Response.Write(state);
            context.Response.End();
        }
        else
        {
            context.Response.Write("<script>alert('  错误!\\还原失败！');</script>");
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}