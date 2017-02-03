<%@ WebHandler Language="C#" Class="insert_NewLan" %>

using System;
using System.Web;
using System.Data;
using System.Web.Script.Serialization;
using System.Web.SessionState;

public class insert_NewLan : BaseHandler
{

    public override void AjaxProcess(HttpContext context)
    {
        string json = "";
        string SH_PROJECT = context.Request.Params["LANMU"];
        DB db = new DB();
        string sql_insert = "insert into T_LAN (LANMU) values('"+SH_PROJECT+"')";
        bool result = db.ExecuteSQL(sql_insert);
        if(result)
        {
            NewLan cs = new NewLan();
            cs.LANMU = SH_PROJECT;
            cs.count = "0";
            JavaScriptSerializer jss = new JavaScriptSerializer();  
            json = jss.Serialize(cs);
            context.Response.Write(json);
            context.Response.End();                        
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}