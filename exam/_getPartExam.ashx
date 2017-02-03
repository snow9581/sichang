<%@ WebHandler Language="C#" Class="_getPartExam" %>

using System;
using System.Web;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;
using System.Web.SessionState;

public class _getPartExam : IHttpHandler, IRequiresSessionState
{
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string dm = Convert.ToString(context.Session["dm"]);//获取队名
        string userlevel = Convert.ToString(context.Session["userlevel"]);//获取用户级别
        string type = context.Request.Params["type"];
        string QSentence = " where 1=1 ";  //定义一个查询子句，当有一个或多个条件不为空时，使用该子句
        if (dm != "" && userlevel == "6")
        {
            QSentence = QSentence + " and E_MAJOR='" + dm + "'";
        } 
        DB db = new DB();
        string sqlStandard = "select * from T_EXAMSTANDARD where E_MAJOR='" + dm + "'";
        DataTable dd = db.GetDataTable(sqlStandard);
        if (dd.Rows.Count > 0)
        {
            string sqlstr = "";
            int count = 0;
            if (type == "X")
            {
                QSentence = QSentence + " and E_TYPE='选择'";
                sqlstr = "select  * FROM (select  * FROM T_EXAM " + QSentence + "and E_LEVEL='难' order by dbms_random.random)where rownum <=" + dd.Rows[0]["E_DIFFICULT"].ToString() + " union  all " +
                   "select  * FROM (select  * FROM T_EXAM " + QSentence + "and E_LEVEL='中等' order by dbms_random.random)where rownum <=" + dd.Rows[0]["E_MEDIUM"].ToString() + " union  all " +
                   "select  * FROM (select  * FROM T_EXAM " + QSentence + "and E_LEVEL='简单' order by dbms_random.random)where rownum <=" + dd.Rows[0]["E_EASY"].ToString();
                count=int.Parse(dd.Rows[0]["E_DIFFICULT"].ToString())+int.Parse(dd.Rows[0]["E_MEDIUM"].ToString())+int.Parse(dd.Rows[0]["E_EASY"].ToString());
            }
            if (type == "P")
            {
                QSentence = QSentence + " and E_TYPE='判断'";
                sqlstr = "select  * FROM (select  * FROM T_EXAM " + QSentence + "and E_LEVEL='难' order by dbms_random.random)where rownum <=" + dd.Rows[0]["E_P_DIFFICULT"].ToString() + " union  all " +
                                   "select  * FROM (select  * FROM T_EXAM " + QSentence + "and E_LEVEL='中等' order by dbms_random.random)where rownum <=" + dd.Rows[0]["E_P_MEDIUM"].ToString() + " union  all " +
                                   "select  * FROM (select  * FROM T_EXAM " + QSentence + "and E_LEVEL='简单' order by dbms_random.random)where rownum <=" + dd.Rows[0]["E_P_EASY"].ToString();
                count = int.Parse(dd.Rows[0]["E_P_DIFFICULT"].ToString()) + int.Parse(dd.Rows[0]["E_P_MEDIUM"].ToString()) + int.Parse(dd.Rows[0]["E_P_EASY"].ToString());
            }                  
            DataTable dt = db.GetDataTable(sqlstr); //获取当前页的数据
            if (dt.Rows.Count == count && count!=0)
            {
                DataColumn dc = new DataColumn("score");
                dt.Columns.Add(dc);
                if (type == "X")
                {
                    for (int i = 0; i < count; i++)
                    {
                        dt.Rows[i]["score"] = dd.Rows[0]["E_SCORE"].ToString();
                    }
                }
                else if (type == "P")
                {
                    for (int i = 0; i < count; i++)
                    {
                        dt.Rows[i]["score"] = dd.Rows[0]["E_P_SCORE"].ToString();
                    }
                }
                String jsonData = T.ToJson(dt, count);
                context.Response.Write(jsonData);
                context.Response.End();
            }
            else
                context.Response.Write("<script type='text/javascript'>alter('题库未完成！');</script>");
        }
        else
            context.Response.Write("<script type='text/javascript'>alter('未制定考试标准！');</script>");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}