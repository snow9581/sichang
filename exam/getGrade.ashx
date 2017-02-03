<%@ WebHandler Language="C#" Class="getGrade" %>

using System;
using System.Web;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;
using System.Web.SessionState;

public class getGrade : IHttpHandler, IRequiresSessionState
{
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        int page = Convert.ToInt32(context.Request.Params["page"]);//页索引
        int rows = Convert.ToInt32(context.Request.Params["rows"]);
        string dm = Convert.ToString(context.Session["dm"]);//获取队名
        string userlevel = Convert.ToString(context.Session["userlevel"]);//获取用户级别
        
        string sqlstr = "select * from(select t.*,rownum rn from(select * from T_EXAMSCORES ) t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + "";

        string sql = "select count(*) from T_EXAMSCORES";

        DB db = new DB();
        int Count = db.GetCount(sql);//获取总条数
        DataTable dt = db.GetDataTable(sqlstr); //获取当前页的数据                            
        String jsonData = T.ToJson(dt, Count);
        context.Response.Write(jsonData);
        context.Response.End();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}