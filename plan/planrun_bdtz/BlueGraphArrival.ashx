<%@ WebHandler Language="C#" Class="BlueGraphArrival" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;
using System.Web.SessionState;
using System.Configuration;
using System.IO;

public class BlueGraphArrival : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string id = context.Request.Params["HD_ID"];
         DB db = new DB();
         string sql = "update T_PLANRUN_BDTZ  set BLUEGRAPHARRIVALDATE = to_date('" + DateTime.Now.ToString() + "','yyyy-mm-dd hh24:mi:ss') where PID=" + id;
        bool flag = db.ExecuteSQL(sql);

        if (flag == true)
        {
            context.Response.Write("1");
        }
        else
        {
            context.Response.Write("0");
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}