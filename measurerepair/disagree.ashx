<%@ WebHandler Language="C#" Class="disagree" %>

using System;
using System.Web;
using System.Web.SessionState;
public class disagree : BaseHandler {
    
    override public void AjaxProcess (HttpContext context) {
        string ID = context.Request.Params["ID"];
        string userlevel = context.Session["userlevel"].ToString();
        string CONTENT = System.Web.HttpUtility.UrlDecode(context.Request.Params["CONTENT"]);
        string sql;
        sql = "update T_measure_REPAIR set STATE='5',CONTENT='" + CONTENT + "' where ID=" + ID.Substring(1, ID.Length - 1);
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