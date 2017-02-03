<%@ WebHandler Language="C#" Class="BudgetAjustDate_P" %>

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

public class BudgetAjustDate_P : BaseHandler
{

    public override void AjaxProcess(HttpContext context)
    {
        string id = context.Request.Params["HD_ID"];
        string username = Convert.ToString(context.Session["username"]);
        string userlevel = Convert.ToString(context.Session["userlevel"]);
        string Remark = context.Request.Params["Remark"];
        string BUDGETADJUSTDATE_P = context.Request.Params["BUDGETADJUSTDATE_P"];

        DB db = new DB();
        string sql = "update T_PLANRUN_DTZ  set BUDGETADJUSTDATE_P = to_date('" + T.preHandleSql(BUDGETADJUSTDATE_P) + "','yyyy-mm-dd'),REMARK='" + T.preHandleSql(Remark) + "' where PID=" + id;
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