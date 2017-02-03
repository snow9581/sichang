<%@ WebHandler Language="C#" Class="getMajorPerson" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;

public class getMajorPerson : BaseHandler
{

    public override void AjaxProcess(HttpContext context)
    {
        String jsonData = "";
        string major = context.Request.QueryString["major"];
        // km = context.Server.UrlDecode(km);
        DB db = new DB();
        string sqlstr = "";
        if (major != null && !"".Equals(major))
        {
            sqlstr = "select username from T_User where major='" + major + "'";

        }
        else
        {
            sqlstr = "select username from T_User";
        }
        DataTable dt = db.GetDataTable(sqlstr); //数据源             
        jsonData = T.ToJsonCombo(dt);

        context.Response.Write(jsonData);
        context.Response.End();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}