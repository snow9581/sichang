<%@ WebHandler Language="C#" Class="insert_temp" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public class insert_temp : BaseHandler {

    public override void AjaxProcess(HttpContext context)
    {
        string json = "";
        string TEMPNAME = context.Request.Params["TEMPNAME"];
        string WIRTESOLUCYCLE = context.Request.Params["WIRTESOLUCYCLE"];
        string INSTCHECKSOLUCYCLE = context.Request.Params["INSTCHECKSOLUCYCLE"];
        string FACTCHECKSOLUCYCLE = context.Request.Params["FACTCHECKSOLUCYCLE"];
        
        DB db = new DB();

        string sql = "insert into T_PLANTEMPLATE(ID,TEMPNAME,WIRTESOLUCYCLE,INSTCHECKSOLUCYCLE,FACTCHECKSOLUCYCLE) values ("+"SEQ_TEMP.nextval"+",'"+T.preHandleSql(TEMPNAME)+"',"+T.preHandleSql(WIRTESOLUCYCLE)+","+T.preHandleSql(INSTCHECKSOLUCYCLE)+","+T.preHandleSql(FACTCHECKSOLUCYCLE)+")";
        bool result = db.ExecuteSQL(sql);
        
        if (result)
        {
            Temp temp = new Temp();
            temp.TEMPNAME = TEMPNAME;
            temp.WIRTESOLUCYCLE = int.Parse(WIRTESOLUCYCLE);
            temp.INSTCHECKSOLUCYCLE =int.Parse(INSTCHECKSOLUCYCLE);
            temp.FACTCHECKSOLUCYCLE = int.Parse(FACTCHECKSOLUCYCLE);
            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(temp);
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