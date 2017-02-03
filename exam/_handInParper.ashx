<%@ WebHandler Language="C#" Class="_handInParper" %>
//交卷
using System;
using System.Web;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;
using System.Web.SessionState;

public class _handInParper : IHttpHandler, IRequiresSessionState
{
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string dm = Convert.ToString(context.Session["dm"]);//获取队名
        string name = Convert.ToString(context.Session["username"]);//获取姓名
        string score = context.Request.Params["Score"];
        string FullScore = context.Request.Params["FullScore"];
        string sql = "insert into T_EXAMSCORES(E_ID,E_EXAMINEE,E_MAJOR,E_SCORE,E_DATE,E_FULLSCORE) values(SEQ_EXAMSCORES.nextval,'" + name + "','" + dm + "','" + score + "',to_date('" + DateTime.Now.ToString() + "','yyyy-mm-dd hh24:mi:ss'),'"+FullScore+"')";
        DB db = new DB();
        bool flag = db.ExecuteSQL(sql);
        if (flag == true)
        {
            context.Response.Write("1");
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