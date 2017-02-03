<%@ WebHandler Language="C#" Class="WhiteGraphCheck" %>

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

public class WhiteGraphCheck : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string id = context.Request.Params["HD_ID"];
        string username = Convert.ToString(context.Session["username"]);
        string userlevel = Convert.ToString(context.Session["userlevel"]);
        string date = context.Request.Params["WHITEGRAPHCHECKDATE_R"];
        string Remark = context.Request.Params["Remark"];
        
        string FileSwitch;
        FileSwitch = System.Configuration.ConfigurationSettings.AppSettings["FileSwitch"].ToString();
        DB db = new DB();
        string sql = "update T_PLANRUN_DTZ  set WHITEGRAPHCHECKDATE_R = to_date('" + T.preHandleSql(date) + "','yyyy-mm-dd'),REMARK='" + T.preHandleSql(Remark) + "' where PID=" + id;
        bool flag = db.ExecuteSQL(sql);
        
        //更新工程量信息表
        string ss = "update T_ASSIGNMENTWORKLOAD set TIMERANGE='施工图阶段' where pid=" + id;
        bool f = db.ExecuteSQL(ss);
        
        if (flag == true && f == true)
        {
            //////////存档/////////////
           
            if (FileSwitch == "1")
            {
                string FID = "p" + id;
                bool flag1=true;
                if (date != "" && date != null)
                {
                    DataTable dt1 = new DataTable();
                    string sql_id="select * from T_PROOFCHECK where ID='"+FID+"'";
                    dt1 = db.GetDataTable(sql_id);
                    if(dt1.Rows.Count == 0)
                    {
                        string sql_pname = "select PNAME,PNUMBER from T_PLANRUN_DTZ where PID=" + id + "";
                        dt1 = db.GetDataTable(sql_pname);
                        string sql_PROOFCHECK = "insert into T_PROOFCHECK(ID,PNAME,DESIGNRQ,PID)values ('" + FID + "','" + dt1.Rows[0]["PNAME"].ToString() + "',to_date('" + T.preHandleSql(date) + "','yyyy-mm-dd'),'" + dt1.Rows[0]["PNUMBER"].ToString() + "')";
                        flag1 = db.ExecuteSQL(sql_PROOFCHECK);//白图校审
                    }  
                    else
                    {   
                        string sql_PROOFCHECK = "update T_PROOFCHECK set DESIGNRQ=to_date('" + T.preHandleSql(date) + "','yyyy-mm-dd') where ID='" + FID + "'";
                        flag1 = db.ExecuteSQL(sql_PROOFCHECK);//校对审核记录文档
                    }
                }
                if (flag1)
                {
                    context.Response.Write("1");
                }
                else
                {
                    context.Response.Write("0");
                }
            }
            ///////////存档结束//////////////
            else
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