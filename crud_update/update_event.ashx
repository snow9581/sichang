<%@ WebHandler Language="C#" Class="update_event" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.SessionState;
public class update_event : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string json = "";
        string ID = context.Request.Params["ID"];
        string KM = context.Request.Params["KM"];
        string DM = context.Request.Params["DM"];
        string CREATEDATE = DateTime.Now.ToString();
        
        string TIME = Convert.ToDateTime(context.Request.Params["TIME"]).ToShortDateString();
        string CONTENT = context.Request.Params["CONTENT"];
        string RECORDER = context.Request.Params["RECORDER"];
        string AUDITOR = context.Request.Params["AUDITOR"];
       
        
        DB db = new DB();
        string sql = "update T_EVENT set TIME=to_date('" + TIME + "','yyyy-mm-dd'),CONTENT='" + T.preHandleSql(CONTENT) + "',RECORDER='" + T.preHandleSql(RECORDER) +
                      "',AUDITOR='" + T.preHandleSql(AUDITOR) + "',CREATEDATE =to_date('" + CREATEDATE + "','yyyy-mm-dd hh24:mi:ss') where id='" + ID + "'";
        
       
        bool result=db.ExecuteSQL(sql);
        if (result)
        {
            Events events = new Events();
            events.KM = KM;
            events.DM = DM;
            events.CREATEDATE = CREATEDATE;
            events.TIME = T.ChangeDate(TIME);
            events.CONTENT = CONTENT.Replace("\r\n", "<br/>");
            events.RECORDER = RECORDER;
            events.AUDITOR = AUDITOR;
            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(events);
            context.Response.Write(json);
            context.Response.End();
        }
        else
        {
            context.Response.Write("<script>alert('  错误!\\n更新失败！');</script>");
        }
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}