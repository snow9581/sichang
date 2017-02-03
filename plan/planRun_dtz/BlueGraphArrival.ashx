<%@ WebHandler Language="C#" Class="BlueGraphArrival" %>

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

public class BlueGraphArrival : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string id = context.Request.Params["BID"];
        string pid = context.Request.Params["PID"];
        string endFlag = context.Request.Params["endFlag"];//true：是最后一个蓝图
        string nowDate = DateTime.Now.ToShortDateString();
        DB db = new DB();
        bool flag = true;
        bool flag1 = true;
        bool flag2 = true;
        
        string sql_arrivalBlueGraph = "update T_CONSTRUCTION set ARRIVALDATE=to_date('" + nowDate + "','yyyy-mm-dd') where ID='"+id+"'";
        flag = db.ExecuteSQL(sql_arrivalBlueGraph);
        if (endFlag == "true")
        {

            string sql = "update T_PLANRUN_DTZ  set BLUEGRAPHARRIVALDATE = to_date('" + nowDate + "','yyyy-mm-dd') where PID=" + pid;
            flag1= db.ExecuteSQL(sql);

            //更新工程量信息表
            string ss = "update T_ASSIGNMENTWORKLOAD set TIMERANGE='完成' where pid=" + pid;
            flag2 = db.ExecuteSQL(ss);
        }
        if (flag == true && flag1 == true && flag2 == true)
        {
            context.Response.Write(nowDate);
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