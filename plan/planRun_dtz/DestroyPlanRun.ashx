<%@ WebHandler Language="C#" Class="DestroyPlanRun" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public class DestroyPlanRun : BaseHandler {

    public override void AjaxProcess(HttpContext context)
    {
        string ID = context.Request.Params["id"];
        DB db = new DB();

        string sql = "update T_PLANRUN_DTZ set BUFFER=1 where PID='" + ID + "'";
        bool result = db.ExecuteSQL(sql);
        if (result)
        {
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