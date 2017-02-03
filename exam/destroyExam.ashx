<%@ WebHandler Language="C#" Class="destroyExam" %>

using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public class destroyExam : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string ID = context.Request.Params["ID"];
        DB db = new DB();
        string sql = "delete from T_EXAM where E_ID='" + ID + "'";
        bool result = db.ExecuteSQL(sql);

        if (result)
        {
            context.Response.Write("1");
            context.Response.End();
        }
        else
        {
            context.Response.Write("0");
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}