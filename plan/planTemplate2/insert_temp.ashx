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
        string WORKLOADSUBMITCYCLE = context.Request.Params["WORKLOADSUBMITCYCLE"];
        string MAJORDELEGATECYCLE = context.Request.Params["MAJORDELEGATECYCLE"];
        string WHITEGRAPHPROOFCYCLE =context.Request.Params["WHITEGRAPHPROOFCYCLE"];
        string BLUEGRAPHSUBMITCYCLE =context.Request.Params["BLUEGRAPHSUBMITCYCLE"];
        DB db = new DB();

        string sql = "insert into T_PLANTEMPLATE_B(ID,TEMPNAME,WORKLOADSUBMITCYCLE,MAJORDELEGATECYCLE," +
              "WHITEGRAPHPROOFCYCLE,BLUEGRAPHSUBMITCYCLE) values (SEQ_TEMP_B.nextval,'" + T.preHandleSql(TEMPNAME) + "'," + T.preHandleSql(WORKLOADSUBMITCYCLE) + "," + T.preHandleSql(MAJORDELEGATECYCLE) + ","+ T.preHandleSql(WHITEGRAPHPROOFCYCLE) + "," + T.preHandleSql(BLUEGRAPHSUBMITCYCLE) + ")";
        bool result = db.ExecuteSQL(sql);
        
        if (result)
        {
            Temp temp = new Temp();
            temp.TEMPNAME = TEMPNAME;
            temp.WHITEGRAPHPROOFCYCLE = int.Parse(WHITEGRAPHPROOFCYCLE);
            temp.MAJORDELEGATECYCLE = int.Parse(MAJORDELEGATECYCLE);
            temp.WORKLOADSUBMITCYCLE = int.Parse(WORKLOADSUBMITCYCLE);
            temp.BLUEGRAPHSUBMITCYCLE = int.Parse(BLUEGRAPHSUBMITCYCLE);

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