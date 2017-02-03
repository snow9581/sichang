<%@ WebHandler Language="C#" Class="DesignatedBudgetPerson" %>

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

public class DesignatedBudgetPerson : BaseHandler
{

    public override void AjaxProcess(HttpContext context)
    {
        string id = context.Request.Params["HD_ID"];
        string username = Convert.ToString(context.Session["username"]);
        string userlevel = Convert.ToString(context.Session["userlevel"]);
        string Remark = context.Request.Params["Remark"];
        string BUDGETCHIEF = context.Request.Params["BUDGETCHIEF"];
        string PTemplate = context.Request.Params["PTemplate"];
        string BUDGETCOMPDATE_P = context.Request.Params["BUDGETCOMPDATE_P"];
        string INITIALDESISUBMITDATE_P = context.Request.Params["INITIALDESISUBMITDATE_P"];
        DB db = new DB();
        string sql = "update T_PLANRUN_DTZ  set BUDGETCHIEF='" + T.preHandleSql(BUDGETCHIEF) + "',BUDGETTEMPLATE='" + T.preHandleSql(PTemplate) +
            "',BUDGETCOMPDATE_P=to_date('" + T.preHandleSql(BUDGETCOMPDATE_P) + "','yyyy-mm-dd'),INITIALDESISUBMITDATE_P=" + "to_date('" + T.preHandleSql(INITIALDESISUBMITDATE_P) + "','yyyy-mm-dd'),REMARK='" + T.preHandleSql(Remark) + "' where PID=" + id;
        bool flag = db.ExecuteSQL(sql);
        
        //更新工程量信息表
        string ss = "update T_ASSIGNMENTWORKLOAD set BUDGETCHIEF='" + BUDGETCHIEF + "' where pid=" + id;
        bool flag2 = db.ExecuteSQL(ss);

        if (flag == true && flag2 == true)
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