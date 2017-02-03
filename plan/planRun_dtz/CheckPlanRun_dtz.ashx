<%@ WebHandler Language="C#" Class="CheckPlanRun_dtz" %>
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

public class CheckPlanRun_dtz : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string id = context.Request.Params["HD_ID"];
        string username = Convert.ToString(context.Session["username"]);
        string userlevel = Convert.ToString(context.Session["userlevel"]);

        string CHECKOPINION = context.Request.Params["CHECKOPINION"];
        string InstApprSolutionFile = context.Request.Params["WORDNAME"];
        string LEADERCHECK = context.Request.Params["LEADERCHECK"];
        string INSTCHECKDATE_R = context.Request.Params["H_InstCheckDate_R"];
        string sql = "";
        if (LEADERCHECK == "0")//主管所长拒绝
        {
            sql = "update T_PLANRUN_DTZ  set CHECKOPINION='" + T.preHandleSql(CHECKOPINION) +"', CHECKSTATE=0";
        }
        else
        {
            sql = "update T_PLANRUN_DTZ  set INSTAPPRSOLUTIONFILE='" + T.preHandleSql(InstApprSolutionFile) + "', CHECKSTATE=2 , INSTCHECKDATE_R = to_date('" + DateTime.Now.ToString() + "','yyyy-mm-dd hh24:mi:ss')";
        }
        sql = sql + " where PID=" + id;
        DB db = new DB();
       
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