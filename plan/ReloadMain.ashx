<%@ WebHandler Language="C#" Class="ReloadMain" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;
using System.Web.SessionState;

public class ReloadMain : IHttpHandler, IRequiresSessionState
{
    public void ProcessRequest(HttpContext context)
    {
        C_haveNumber number = new C_haveNumber();
        string userlevel = Convert.ToString(context.Session["userlevel"]);
        string username = Convert.ToString(context.Session["username"]);
        string organization = Convert.ToString(context.Session["dm"]);
        number.Organization = organization;
        number.userlevel =userlevel;
        number.userName = username;
        int dtz = number.dtz_number();
        int bdtz = number.bdtz_number();
        int zcq = number.zcq_number();
        string x = dtz.ToString() + "," + bdtz.ToString() + "," + zcq.ToString();       
        context.Response.Write(x);
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}