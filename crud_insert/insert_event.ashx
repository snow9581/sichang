<%@ WebHandler Language="C#" Class="insert_event" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.SessionState;
public class insert_event : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string json = "";
        string DM = Convert.ToString(context.Session["dm"]);
        string KM = Convert.ToString(context.Session["km"]);
        string CREATEDATE = DateTime.Now.ToString();
        string TIME = context.Request.Params["TIME"];
        string CONTENT = context.Request.Params["CONTENT"];
        string RECORDER = context.Request.Params["RECORDER"];
        string AUDITOR = context.Request.Params["AUDITOR"];
           
        string ID = "0";
        DB db = new DB();
        string sql_id = "select SEQ_EVENT.nextval from dual";
        System.Data.DataTable dt = db.GetDataTable(sql_id);
        if (dt.Rows.Count > 0) ID = dt.Rows[0][0].ToString();
        
        string sql = "insert into T_EVENT(ID,KM,DM,TIME,CONTENT,RECORDER,AUDITOR,CREATEDATE) values (" + ID + ",'"+
                     KM + "','" + DM + "', to_date('" + TIME + "','yyyy-mm-dd'),'" + 
                     T.preHandleSql(CONTENT) + "','" + T.preHandleSql(RECORDER) + "','" + T.preHandleSql(AUDITOR) + "',to_date('" + CREATEDATE + "','yyyy-mm-dd hh24:mi:ss'))"; //高俊涛修改 2014-09-07 把文件名filename存入数据库
        bool result = db.ExecuteSQL(sql);

        if (result)
        {
            Events events = new Events();
            events.ID = ID;
            events.KM = KM;
            events.DM = DM;
            events.CREATEDATE = CREATEDATE;
            events.TIME = T.ChangeDate(TIME);
            events.CONTENT = CONTENT.Replace("\r\n","<br/>");
            events.RECORDER = RECORDER;
            events.AUDITOR = AUDITOR;
            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(events);
            context.Response.Write(json);
            context.Response.End();
        }
        else
        {
            context.Response.Write("<script>alert('  错误!\\n添加失败！')</script>");
        }

    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}