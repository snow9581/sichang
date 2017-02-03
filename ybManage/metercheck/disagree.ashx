<%@ WebHandler Language="C#" Class="disagree" %>
//审核人不通过，批准人不通过，管理科不通过时执行
using System;
using System.Web;
using System.Data;
public class disagree : BaseHandler
{

    override public void AjaxProcess(HttpContext context)
    {
        string sql;
        string FROMID = context.Request.Params["FROMID"].ToString();
        string CONTENT = context.Request.Params["CONTENT"];//不同意原因
        DB db = new DB();
        DataTable dt = db.GetDataTable("select * from T_METER_CHECK where ID=" + FROMID);
        if (dt.Rows[0]["STATE"].ToString() == "1")
            sql = "update T_METER_CHECK set CONTENT='" + CONTENT + "',STATE='6',SHR='" + context.Session["username"].ToString() + "' where ID=" + FROMID;
        else if (dt.Rows[0]["STATE"].ToString() == "2")
            sql = "update T_METER_CHECK set CONTENT='" + CONTENT + "',STATE='6',PZR='" + context.Session["username"].ToString() + "' where ID=" + FROMID;
        else
            sql = "update T_METER_CHECK set CONTENT='" + CONTENT + "',STATE='6' where ID=" + FROMID;
        db.ExecuteSql(sql);
        context.Response.Write("1");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}