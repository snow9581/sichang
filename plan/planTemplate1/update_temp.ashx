<%@ WebHandler Language="C#" Class="update_temp" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public class update_temp : BaseHandler {

    public override void AjaxProcess(HttpContext context)
    {
        string json = "";
        int ID = int.Parse(context.Request.Params["ID"]);
        string TEMPNAME = context.Request.Params["TEMPNAME"];
        int WIRTESOLUCYCLE = int.Parse(context.Request.Params["WIRTESOLUCYCLE"]);
        int INSTCHECKSOLUCYCLE = int.Parse(context.Request.Params["INSTCHECKSOLUCYCLE"]);
        int FACTCHECKSOLUCYCLE = int.Parse(context.Request.Params["FACTCHECKSOLUCYCLE"]);
      
        DB db = new DB();

        string sql = "update T_PLANTEMPLATE SET WIRTESOLUCYCLE=" + WIRTESOLUCYCLE + ",INSTCHECKSOLUCYCLE=" + INSTCHECKSOLUCYCLE + ",FACTCHECKSOLUCYCLE=" + FACTCHECKSOLUCYCLE + ",TEMPNAME='"+T.preHandleSql(TEMPNAME)+"' WHERE ID="+ID;
        bool result = db.ExecuteSQL(sql);

        if (result)
        {
            Temp temp = new Temp();
            temp.TEMPNAME = TEMPNAME;
           
            temp.WIRTESOLUCYCLE = WIRTESOLUCYCLE;
           
            temp.INSTCHECKSOLUCYCLE = INSTCHECKSOLUCYCLE;
            temp.FACTCHECKSOLUCYCLE = FACTCHECKSOLUCYCLE;
           
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