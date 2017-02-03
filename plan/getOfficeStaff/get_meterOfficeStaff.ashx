<%@ WebHandler Language="C#" Class="get_meterOfficeStaff" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;

public class get_meterOfficeStaff : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        String jsonData = "";
        DB db = new DB();
        string sqlstr = "";
        sqlstr = "select distinct(USERNAME) from T_USER where USERLEVEL=6 AND DM='仪表室'";
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