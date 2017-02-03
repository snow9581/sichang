<%@ WebHandler Language="C#" Class="getExam" %>

using System;
using System.Web;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;
using System.Web.SessionState;

public class getExam : IHttpHandler, IRequiresSessionState
{
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        int page = Convert.ToInt32(context.Request.Params["page"]);//页索引
        int rows = Convert.ToInt32(context.Request.Params["rows"]);
        string dm = Convert.ToString(context.Session["dm"]);//获取队名
        string userlevel = Convert.ToString(context.Session["userlevel"]);//获取用户级别
        ///条件查询 begin
        string S_TITLE = context.Request.Params["S_TITLE"];
        string S_TYPE = context.Request.Params["S_TYPE"];
        string S_LEVEL = context.Request.Params["S_LEVEL"];

        string QSentence = " where 1=1 ";  //定义一个查询子句，当有一个或多个条件不为空时，使用该子句
        if (dm != "" && userlevel == "2")
        {
            QSentence = QSentence + " and E_MAJOR='" + dm + "'";
        }
        if (S_TITLE != null && S_TITLE != "")
        {
            QSentence = QSentence + " and E_TITLE like '%" + T.preHandleSql(S_TITLE) + "%'";
        }
        if (S_TYPE != null && S_TYPE != "")
        {
            QSentence = QSentence + " and E_TYPE like '%" + T.preHandleSql(S_TYPE) + "%'";
        }
        if (S_LEVEL != null && S_LEVEL != "")
        {
            QSentence = QSentence + " and E_LEVEL like '%" + T.preHandleSql(S_LEVEL) + "%'";
        }
        QSentence += "order by E_CREATEDATE desc";
        string sqlstr = "select * from(select t.*,rownum rn from(select * from T_EXAM " + QSentence + ") t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + "";

        string sql = "select count(*) from T_EXAM" + QSentence;

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