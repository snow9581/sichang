<%@ WebHandler Language="C#" Class="init_planRun_free" %>

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

 
public class init_planRun_free : BaseHandler
{
    public override void AjaxProcess(HttpContext context) 
    {
        string id = context.Request.Params["HD_ID"];
        string username = Convert.ToString(context.Session["username"]);
        string userlevel = Convert.ToString(context.Session["userlevel"]);
        string PName = context.Request.Params["PName"];
        string PSource = context.Request.Params["PSource"];
        string DESICHIEF = context.Request.Params["DESICHIEF"];
        string MAJORPROOFREADER = context.Request.Params["MAJORPROOFREADER"];
        string MAJORDELEGATEDATE_P = context.Request.Params["MAJORDELEGATEDATE_P"];
        string WORKLOADSUBMITDATE_P = context.Request.Params["WORKLOADSUBMITDATE_P"];
        string INITIALDESISUBMITDATE_P = context.Request.Params["INITIALDESISUBMITDATE_P"];
        string Remark = context.Request.Params["Remark"];
        string PTemplate = context.Request.Params["PTemplate"];
        DB db = new DB();
        string sql="";
        if (id == "")
            sql = "insert into T_PLANRUN_DTZ(PID,PNAME,PSOURCE,DESICHIEF,MAJORPROOFREADER,MAJORDELEGATEDATE_P,WORKLOADSUBMITDATE_P,INITIALDESISUBMITDATE_P,REMARK,TEMPLATE_B,INITDATE,PLANFLAG,PLANFLAG_DESIGN,BUFFER)" +
            " values (SEQ_PLANRUN_DTZ.nextval,'" + T.preHandleSql(PName) + "','" + T.preHandleSql(PSource) + "','" + T.preHandleSql(DESICHIEF) + "','" + T.preHandleSql(MAJORPROOFREADER) + "'," +
            "to_date('" + T.preHandleSql(MAJORDELEGATEDATE_P) + "','yyyy-mm-dd')," + "to_date('" + T.preHandleSql(WORKLOADSUBMITDATE_P) + "','yyyy-mm-dd')," + "to_date('" + T.preHandleSql(INITIALDESISUBMITDATE_P) + "','yyyy-mm-dd'),'" + T.preHandleSql(Remark) + "','" + T.preHandleSql(PTemplate) +"',to_date('" + DateTime.Now.ToString() + "','yyyy-mm-dd hh24:mi:ss'),1,0,0)";
        else
            sql = "update T_PLANRUN_DTZ  set PNAME='" + T.preHandleSql(PName) + "',PSOURCE='" + T.preHandleSql(PSource) + "',DESICHIEF='" + T.preHandleSql(DESICHIEF) + "', MAJORPROOFREADER='" + T.preHandleSql(MAJORPROOFREADER) +
           "',MAJORDELEGATEDATE_P=" + "to_date('" + T.preHandleSql(MAJORDELEGATEDATE_P) + "','yyyy-mm-dd')," +
           "WORKLOADSUBMITDATE_P=" + "to_date('" + T.preHandleSql(WORKLOADSUBMITDATE_P) + "','yyyy-mm-dd')," +
           "INITIALDESISUBMITDATE_P=" + "to_date('" + T.preHandleSql(INITIALDESISUBMITDATE_P) + "','yyyy-mm-dd'),TEMPLATE_B='" + T.preHandleSql(PTemplate) + "',REMARK='" + T.preHandleSql(Remark) + "' where PID=" + id;
        
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

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}