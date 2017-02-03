<%@ WebHandler Language="C#" Class="destroy_share" %>

using System;
using System.Web;

public class destroy_share : BaseHandler{

    public override void AjaxProcess (HttpContext context) {
        string ID = context.Request.Params["ID"];
        DB db = new DB();
        string sql = "delete from T_share where ID ='" + ID + "'";
        bool result = db.ExecuteSQL(sql);
        if(result)
        {
            string state = "{\"success\":true}";
            context.Response.Write(state);
            context.Response.End();
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}