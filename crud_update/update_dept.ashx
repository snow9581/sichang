<%@ WebHandler Language="C#" Class="update_dept" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.SessionState;
public class update_dept : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string json = "";
        string ID = context.Request.Params["ID"];
        string DM = context.Request.Params["DM"];
        string KM = context.Request.Params["KM"];


        DB db = new DB();
        //KM = db.GetKM(DM);
        
        //string sql = "update T_USER set USERNAME='" + USERNAME + "',PASSWORD='" + PASSWORD + "',USERLEVEL='" + USERLEVEL +
        //              "',DEPT='" + DEPT + "'where id='" + ID + "'";

        string sql = "update T_DEPT set KM='"+ KM +"'， DM='" + DM + "'where id='" + ID + "'";
        
       bool result=db.ExecuteSQL(sql);
       if (result)
       {
            Dept dept = new Dept();
            dept.KM = KM;

            dept.DM = DM;

            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(dept);
            context.Response.Write(json);
            context.Response.End();
       }
       else
       {
           context.Response.Write("<script>alert('  错误!\\n更新失败！');</script>");
       }
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}