<%@ WebHandler Language="C#" Class="update_ComInfMain" %>

using System;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public class update_ComInfMain : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string json = "";
        string PNUMBER = context.Request.Params["PNUMBER"];
        string PNAME = context.Request.Params["PNAME"];
        string preTYPE = context.Request.Params["ptype"];
        string prePNUMBER = context.Request.Params["pnu"];
        string prePNAME = context.Request.Params["pna"];
        string QS="";
        if(prePNAME!=""&&prePNAME!=null)
            QS+=" and PNAME='"+prePNAME+"' ";
        if(prePNUMBER!=""&&prePNUMBER!=null)
            QS+=" and PNUMBER='"+prePNUMBER+"' ";
        string sql = "update T_COMMISSIONINFORMATION set PNUMBER='" + T.preHandleSql(PNUMBER) + "',PNAME='" + T.preHandleSql(PNAME) + "' where 1=1 "+QS;
        DB db = new DB();
        bool result = db.ExecuteSQL(sql);
        if (result)
        {
            CommissionInformation CommissionInformation = new CommissionInformation();
            CommissionInformation.PNUMBER = PNUMBER;
            CommissionInformation.PNAME = PNAME;
            CommissionInformation.FILETYPE = preTYPE;
           
            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(CommissionInformation);
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