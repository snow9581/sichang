<%@ WebHandler Language="C#" Class="get_SOLUCYCLE" %>
/////////获取模板周期
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;

public class get_SOLUCYCLE : BaseHandler {

    public override void AjaxProcess(HttpContext context)
    {

        string TEMPNAME = context.Request["name"];
        DB db = new DB();
        string sqlstr = "";
        sqlstr = "select * from T_PLANTEMPLATE where TEMPNAME='" + TEMPNAME + "'";
        DataTable dt = db.GetDataTable(sqlstr); //数据源 

        context.Response.ContentType = "text/json";
        context.Response.Write("{\"WIRTESOLUCYCLE\":" + dt.Rows[0]["WIRTESOLUCYCLE"] + ",\"INSTCHECKSOLUCYCLE\":" + dt.Rows[0]["INSTCHECKSOLUCYCLE"] + ",\"FACTCHECKSOLUCYCLE\":" + dt.Rows[0]["FACTCHECKSOLUCYCLE"] + "}");
        //context.Response.Write("{\"msg\":\"Hello World" + context.Request["name"] + "来自handler.ashx\"}");
        context.Response.End();
    } 
    public bool IsReusable {
        get {
            return false;
        }
    }

}