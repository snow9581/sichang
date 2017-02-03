<%@ WebHandler Language="C#" Class="DesignGraphDate" %>

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

public class DesignGraphDate : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string id = context.Request.Params["HD_ID"];
        string INITIALDESISUBMITDATE_P = context.Request.Params["INITIALDESISUBMITDATE_P"];
        string BLUEGRAPHDOCUMENT_P = context.Request.Params["BLUEGRAPHDOCUMENT_P"];
        DB db = new DB();
        string sql = "update T_PLANRUN_BDTZ set BLUEGRAPHDOCUMENT_P=to_date('" + BLUEGRAPHDOCUMENT_P + "','yyyy-mm-dd'),INITIALDESISUBMITDATE_P=to_date('" + INITIALDESISUBMITDATE_P + "','yyyy-mm-dd') where PID=" + id;
     
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