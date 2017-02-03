<%@ WebHandler Language="C#" Class="insertExam" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.SessionState;
using System.Data;
public class insertExam : IHttpHandler, IRequiresSessionState
{
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        
        string E_TITLE = context.Request.Params["E_TITLE"].Replace("\r\n","");
        string E_TYPE = context.Request.Params["E_TYPE"];
        string E_ANSWER = E_TYPE == "选择" ? context.Request.Params["E_X_ANSWER"].Trim().ToUpper() : context.Request.Params["E_P_ANSWER"];
        string E_LEVEL = context.Request.Params["E_LEVEL"];
        string E_CREATEDATE = DateTime.Now.ToString();
        string ID = "0";
        DB db = new DB();
        string sql_id = "select SEQ_EXAM.nextval from dual";
        System.Data.DataTable dt = db.GetDataTable(sql_id);
        if (dt.Rows.Count > 0) ID = dt.Rows[0][0].ToString();

        string sql = "insert into T_EXAM (E_ID,E_TITLE,E_ANSWER,E_TYPE,E_LEVEL,E_CREATEDATE) values (" + ID + ",'" + E_TITLE + "','" + E_ANSWER + "','" + E_TYPE + "','" + E_LEVEL + "',to_date('"+E_CREATEDATE+"','yyyy-mm-dd hh24:mi:ss'))";

        bool result = db.ExecuteSQL(sql);

        if (result)
        {
            Exam exam = new Exam();
            exam.E_ID = ID;
            exam.E_TITLE = E_TITLE.Replace("&nbsp;"," ");
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