<%@ WebHandler Language="C#" Class="init_planRun_dtz" %>

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

public class init_planRun_dtz : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string username = Convert.ToString(context.Session["username"]);
        string userlevel = Convert.ToString(context.Session["userlevel"]);
        string dm = Convert.ToString(context.Session["dm"]);
        string ID = context.Request.Params["hd_id"];
        string PName = context.Request.Params["PName"];
        string PSource = context.Request.Params["PSource"];
        string SoluChief = context.Request.Params["SoluChief"];
        string SOLUCOMPDATE_P = context.Request.Params["SOLUCOMPDATE_P"];
        string INSTCHECKDATE_P = context.Request.Params["INSTCHECKDATE_P"];
        string FACTCHECKDATE_P = context.Request.Params["FACTCHECKDATE_P"];
        string Remark = context.Request.Params["Remark"];
        string PLANFLAG_DESIGN = context.Request.Params["PLANFLAG_DESIGN"];
        int planflag = 0;
        if (dm == "矿区室")
        {
            planflag = 2;
        }
        DB db = new DB();
        string sql="";
        if(ID=="")
            sql = "insert into T_PLANRUN_DTZ(PID,PNAME,PSOURCE,SOLUCHIEF,SOLUCOMPDATE_P,INSTCHECKDATE_P,FACTCHECKDATE_P,REMARK,INITDATE,PLANFLAG,BUFFER,PLANFLAG_DESIGN)" +
            " values (SEQ_PLANRUN_DTZ.nextval,'" + T.preHandleSql(PName) + "','" + T.preHandleSql(PSource) + "','" + T.preHandleSql(SoluChief) + "',to_date('" + T.preHandleSql(SOLUCOMPDATE_P) + "','yyyy-mm-dd')," +
            "to_date('" + T.preHandleSql(INSTCHECKDATE_P) + "','yyyy-mm-dd')," + "to_date('" + T.preHandleSql(FACTCHECKDATE_P) + "','yyyy-mm-dd'),'" + T.preHandleSql(Remark) + "',to_date('" + DateTime.Now.ToString() + "','yyyy-mm-dd hh24:mi:ss'),'" + planflag + "',0," + PLANFLAG_DESIGN + ")";
        else
            sql = "update T_PLANRUN_DTZ set PNAME='" + T.preHandleSql(PName) + "',PSOURCE='" + T.preHandleSql(PSource) + "',SOLUCHIEF='" + T.preHandleSql(SoluChief)
                + "',SOLUCOMPDATE_P=to_date('" + SOLUCOMPDATE_P + "','yyyy-mm-dd'),INSTCHECKDATE_P=to_date('" + INSTCHECKDATE_P + "','yyyy-mm-dd'),FACTCHECKDATE_P=to_date('" + FACTCHECKDATE_P + "','yyyy-mm-dd'),REMARK='" + T.preHandleSql(Remark) + "',PLANFLAG_DESIGN='" + PLANFLAG_DESIGN + "' where PID=" + ID;
     
        bool flag=db.ExecuteSQL(sql);        
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