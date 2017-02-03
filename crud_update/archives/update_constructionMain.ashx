<%@ WebHandler Language="C#" Class="update_constructionMain" %>

using System;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public class update_constructionMain : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string json = "";
        string PID = context.Request.Params["PID"];
        string PNAME = context.Request.Params["PNAME"];
        string PLEADER = context.Request.Params["PLEADER"];
        string prePNUMBER = context.Request.Params["pnu"];
        string prePNAME = context.Request.Params["pna"];
        string QS = "";
        if (prePNUMBER != "" && prePNUMBER != null)
            QS += " and PID='" + prePNUMBER + "' ";
        string sql = "update T_construction set PID='" + T.preHandleSql(PID) + "',PNAME='" + T.preHandleSql(PNAME) + "' where PNAME='" + prePNAME + "' " + QS;
        DB db = new DB();
        bool result = db.ExecuteSQL(sql);
        if (result)
        {
            Construction construction = new Construction();
            construction.PID = PID;
            construction.PNAME = PNAME;
            construction.PLEADER = PLEADER;
            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(construction);
            context.Response.Write(json);
            context.Response.End();
        }
        else
        {
            context.Response.ContentType = "text/html";
            context.Response.Write("<script>alert('  错误!\\n更新失败！');</script>");
        }

    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}