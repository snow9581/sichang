<%@ WebHandler Language="C#" Class="updateExam" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.SessionState;

public class updateExam : IHttpHandler, IRequiresSessionState
{
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        
        string ID = context.Request.Params["ID"];
        string E_TITLE = context.Request.Params["E_TITLE"].Replace("\r\n", "");
        string E_TYPE = context.Request.Params["E_TYPE"];
        string E_ANSWER = E_TYPE == "选择" ? context.Request.Params["E_X_ANSWER"].Trim().ToUpper() : context.Request.Params["E_P_ANSWER"];
        string E_LEVEL = context.Request.Params["E_LEVEL"];
        string E_CREATEDATE = DateTime.Now.ToString();
        
        DB db = new DB();

        string sql = "update T_EXAM set E_TITLE='" + E_TITLE + "',E_ANSWER='" + E_ANSWER + "',E_TYPE='" + E_TYPE + "',E_LEVEL='" + E_LEVEL + "',E_CREATEDATE=to_date('" + E_CREATEDATE + "','yyyy-mm-dd hh24:mi:ss') where E_ID=" + ID;

        bool result = db.ExecuteSQL(sql);

        if (result)
        {
            Exam exam = new Exam();
            exam.E_ID = ID;
            exam.E_TITLE = E_TITLE.Replace("&nbsp;", " ");
            exam.E_ANSWER = E_ANSWER;
            exam.E_TYPE = E_TYPE;
            exam.E_LEVEL = E_LEVEL;
            exam.E_CREATEDATE = E_CREATEDATE;
            
            JavaScriptSerializer jss = new JavaScriptSerializer();
            string json = jss.Serialize(exam);
            context.Response.Write(json);
            context.Response.End();
        }
        else
        {
            context.Response.ContentType = "text/html";
            context.Response.Write("<script>alert('  错误!\\n添加失败！');</script>");
        }

    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}