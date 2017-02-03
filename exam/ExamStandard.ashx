<%@ WebHandler Language="C#" Class="ExamStandard" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.SessionState;

public class ExamStandard : IHttpHandler, IRequiresSessionState
{
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string X_dif = context.Request.Params["X_dif"];
        string X_med = context.Request.Params["x_med"];
        string X_easy = context.Request.Params["X_easy"];
        string P_dif = context.Request.Params["P_dif"];
        string P_med = context.Request.Params["P_med"];
        string P_easy = context.Request.Params["P_easy"];
        string FlagStandard = context.Request.Params["Standard"];
        string X_score = context.Request.Params["X_score"];
        string P_score = context.Request.Params["P_score"];
        string TIME = context.Request.Params["TIME"];
        string STARTDATE = context.Request.Params["STARTDATE"];
        string ENDDATE = context.Request.Params["ENDDATE"];
        string major = Convert.ToString(context.Session["dm"]);
        
        DB db = new DB();
        string sql = "";
        if (FlagStandard == "1")
        {
            sql = "insert into T_EXAMSTANDARD (E_DIFFICULT,E_MEDIUM,E_EASY,E_SCORE,E_MAJOR,E_P_DIFFICULT,E_P_MEDIUM,E_P_EASY,E_P_SCORE,E_TIME,E_STARTDATE,E_ENDDATE) values ('" + X_dif + "','" + X_med + "','" + X_easy + "','" + X_score + "','" + major + "','" + P_dif + "','" + P_med + "','" + P_easy + "','" + P_score + "','"+TIME+"',to_date('" + STARTDATE + "','yyyy-mm-dd'),to_date('" + ENDDATE + "','yyyy-mm-dd')";
        }
        else
        {
            sql = "update T_EXAMSTANDARD set E_DIFFICULT='" + X_dif + "',E_MEDIUM='" + X_med + "',E_EASY='" + X_easy + "',E_SCORE='" + X_score + "',E_P_DIFFICULT='" + P_dif + "',E_P_MEDIUM='" + P_med + "',E_P_EASY='" + P_easy + "',E_P_SCORE='" + P_score + "',E_TIME='" + TIME + "',E_STARTDATE=to_date('" + STARTDATE + "','yyyy-mm-dd'),E_ENDDATE=to_date('" + ENDDATE + "','yyyy-mm-dd') where E_MAJOR='" + major + "'";
        }
        bool result = db.ExecuteSQL(sql);

        if (result)
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