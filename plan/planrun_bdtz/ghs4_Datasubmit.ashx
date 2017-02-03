<%@ WebHandler Language="C#" Class="ghs4_Datasubmit" %>

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

public class ghs4_Datasubmit : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string id = context.Request.Params["HD_ID"];
        string SoluCompDate_P = context.Request.Params["SoluCompDate_P"];
        string SoluCheckDate_P = context.Request.Params["SoluCheckDate_P"];
        DB db = new DB();
        string sql = "update T_PLANRUN_BDTZ set SOLUCOMPDATE_P=to_date('" + SoluCompDate_P + "','yyyy-mm-dd'),SOLUCHECKDATE_P=to_date('" + SoluCheckDate_P + "','yyyy-mm-dd') where PID=" + id;
     
        bool flag=db.ExecuteSQL(sql);        
        
        if (flag == true)
        {
            context.Response.Write("1");
        }
        else {
            context.Response.Write("0");
        }
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}