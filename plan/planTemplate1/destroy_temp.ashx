<%@ WebHandler Language="C#" Class="destroy_temp" %>

using System;
using System.Web;

public class destroy_temp : BaseHandler {

    public override void AjaxProcess(HttpContext context)
    {
        
        string ID = context.Request.Params["ID"];
        DB db = new DB();
        string sql = "DELETE from T_PLANTEMPLATE WHERE ID='" + ID + "'";
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