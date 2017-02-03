<%@ WebHandler Language="C#" Class="DesignatedDesignPerson" %>

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

public class DesignatedDesignPerson : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string id = context.Request.Params["HD_ID"];
        string username = Convert.ToString(context.Session["username"]);
        string userlevel = Convert.ToString(context.Session["userlevel"]);
        string DESICHIEF = context.Request.Params["DESICHIEF"];
        string MAJORPROOFREADER = context.Request.Params["MAJORPROOFREADER"];
        string MAJORDELEGATEDATE_P = context.Request.Params["MAJORDELEGATEDATE_P"];
        string WORKLOADSUBMITDATE_P = context.Request.Params["WORKLOADSUBMITDATE_P"];
        
        string PTemplate = context.Request.Params["PTemplate"];
        string Remark = context.Request.Params["Remark"];
        DB db = new DB();
        string sql = "update T_PLANRUN_DTZ  set DESICHIEF='" + T.preHandleSql(DESICHIEF) + "', MAJORPROOFREADER='" +T.preHandleSql(MAJORPROOFREADER) +
            "',MAJORDELEGATEDATE_P=" + "to_date('" + T.preHandleSql(MAJORDELEGATEDATE_P) + "','yyyy-mm-dd'),"+
            "WORKLOADSUBMITDATE_P=" + "to_date('" + T.preHandleSql(WORKLOADSUBMITDATE_P) + "','yyyy-mm-dd')," +
            "TEMPLATE_B='" + T.preHandleSql(PTemplate) + "',REMARK='" + T.preHandleSql(Remark) + "' where PID=" + id;
        bool flag1 = db.ExecuteSQL(sql);
        //更新工程量信息表
        string ss = "update T_ASSIGNMENTWORKLOAD set DESICHIEF='" + DESICHIEF + "',TIMERANGE='设计阶段' where pid="+id;
        bool flag2 = db.ExecuteSQL(ss);
        
        if (flag1 == true && flag2 == true)
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