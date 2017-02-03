<%@ WebHandler Language="C#" Class="insert_temp" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public class insert_temp :BaseHandler {

    public override void AjaxProcess(HttpContext context)
    {
        string json = "";
        string TEMPNAME = context.Request.Params["TEMPNAME"];
        string BUDGETCYCLE = context.Request.Params["BUDGETCYCLE"];
        string BUDGETADJUSTCYCLE = context.Request.Params["BUDGETADJUSTCYCLE"];
        string INITDESICYCLE = context.Request.Params["INITDESICYCLE"];
        DB db = new DB();

        string sql = "insert into T_PLANTEMPLATE_C(ID,TEMPNAME,BUDGETCYCLE,BUDGETADJUSTCYCLE,INITDESICYCLE) values (" + "SEQ_TEMP_C.nextval" + ",'" + T.preHandleSql(TEMPNAME) + "'," + T.preHandleSql(BUDGETCYCLE) + "," + T.preHandleSql(BUDGETADJUSTCYCLE) + "," + T.preHandleSql(INITDESICYCLE) + ")";
        bool result = db.ExecuteSQL(sql);
        
        if (result)
        {
            Temp temp = new Temp();
            temp.TEMPNAME = TEMPNAME;
            temp.BUDGETCYCLE = int.Parse(BUDGETCYCLE);
            temp.BUDGETADJUSTCYCLE = int.Parse(BUDGETADJUSTCYCLE);
            temp.INITDESICYCLE = int.Parse(INITDESICYCLE);
            
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