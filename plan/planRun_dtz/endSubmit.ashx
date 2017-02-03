<%@ WebHandler Language="C#" Class="endSubmit" %>

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

public class endSubmit : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string id = context.Request.Params["HD_ID"];
        string commissionflag=context.Request.Params["commissionflag"];
        string workloadflag = context.Request.Params["workloadflag"];
        string blueGraphflag = context.Request.Params["blueGraphflag"];
        string type = context.Request.Params["type"];
        DB db = new DB();
        bool flag = false;
        if (workloadflag == "1")
        {
            string sql = "update T_PLANRUN_DTZ set WORKLOADSUBMITDATE_R = to_date('" + DateTime.Now.ToString() + "','yyyy-mm-dd hh24:mi:ss') where pid=" + id;
            flag = db.ExecuteSQL(sql);
        }
        if (commissionflag == "1")
        {
            if (type == "1")//一次委托资料结束时间
            {
                string sql = "update T_PLANRUN_DTZ set MAJORDELEGATEDATE_R= to_date('" + DateTime.Now.ToString() + "','yyyy-mm-dd hh24:mi:ss') where pid=" + id;
                flag = db.ExecuteSQL(sql);
            }
            else//二次委托资料结束时间
            {
                string sql = "update T_PLANRUN_DTZ set SECONDCOMMISSIONDATE= to_date('" + DateTime.Now.ToString() + "','yyyy-mm-dd hh24:mi:ss') where pid=" + id;
                flag = db.ExecuteSQL(sql);
            }
        }
        if (blueGraphflag == "1")
        {
            string sql = "update T_PLANRUN_DTZ set BLUEGRAPHDOCUMENT_R=to_date('" + DateTime.Now.ToString() + "','yyyy-mm-dd hh24:mi:ss') where pid=" + id;
            flag = db.ExecuteSQL(sql);
        }
        if (flag)
        {
            context.Response.Write("1");
        }
        else
            context.Response.Write("0"); 
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}