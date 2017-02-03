<%@ WebHandler Language="C#" Class="agree" %>

using System;
using System.Web;
using System.Web.SessionState;
public class agree : BaseHandler {
    
    override public void AjaxProcess (HttpContext context) {
        string ID = context.Request.Params["ID"];
        string userlevel = context.Session["userlevel"].ToString();
        string sql;
        if (userlevel == "2")
            sql = "update T_METER_REPAIR set STATE='3',WXR='" + System.Web.HttpUtility.UrlDecode(context.Request.Params["wxr"].ToString()) + "' where ID=" + ID.Substring(1, ID.Length - 1);
        else
            sql = "update T_METER_REPAIR set STATE='2' where ID=" + ID.Substring(1, ID.Length - 1);
        DB db = new DB();
        if (db.ExecuteSQL(sql))
            context.Response.Write("1");
        else
            context.Response.Write("0");
        context.Response.End();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}