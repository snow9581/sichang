<%@ WebHandler Language="C#" Class="InitialDesiSubmit" %>

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

public class InitialDesiSubmit : BaseHandler
{

    public override void AjaxProcess(HttpContext context)
    {
        string id = context.Request.Params["HD_ID"];
        string username = Convert.ToString(context.Session["username"]);
        string userlevel = Convert.ToString(context.Session["userlevel"]);
        string InitialDesiSubmitDate_R = context.Request.Params["InitialDesiSubmitDate_R"];
        string Remark = context.Request.Params["Remark"];
        DB db = new DB();
        string sql = "update T_PLANRUN_DTZ  set INITIALDESISUBMITDATE_R = to_date('" + T.preHandleSql(InitialDesiSubmitDate_R) + "','yyyy-mm-dd'),REMARK='"+T.preHandleSql(Remark)+"' where PID=" + id;
        bool flag = db.ExecuteSQL(sql);

        if (flag == true)
        {
            //////////存档/////////////
            string FileSwitch;
            FileSwitch = System.Configuration.ConfigurationSettings.AppSettings["FileSwitch"].ToString();
            if (FileSwitch == "1")
            {
                string FID = "p" + id;
                bool flag1 = true;
                if (InitialDesiSubmitDate_R != "")
                {
                    DataTable dt1 = new DataTable();
                    string sql_id = "select * from T_INITPLAN where ID='" + FID + "'";
                    dt1 = db.GetDataTable(sql_id);
                    if (dt1.Rows.Count == 0)
                    {
                        DataTable dt = new DataTable();
                        string sql_pleader = "select SOLUCHIEF,PNUMBER,PNAME from T_PLANRUN_DTZ where PID=" + id + "";
                        dt = db.GetDataTable(sql_pleader);
                        if (dt.Rows.Count > 0)
                        {
                            string sql_PLANREPLY_issued = "insert into T_INITPLAN (ID,PID,PNAME,INITRQ,PLEADER) values('" + FID + "','" + dt.Rows[0]["PNUMBER"].ToString() + "','" + dt.Rows[0]["PNAME"].ToString()
                                + "',to_date('" + InitialDesiSubmitDate_R + "','yyyy-mm-dd'),'" + dt.Rows[0]["SOLUCHIEF"].ToString() + "')";
                            flag1 = db.ExecuteSQL(sql_PLANREPLY_issued);//初设上报
                        }
                    }
                    else
                    {
                        string sql_INITPLAN = "update T_INITPLAN set INITRQ=to_date('" + InitialDesiSubmitDate_R + "','yyyy-mm-dd') where id='" + FID + "'";
                        flag1 = db.ExecuteSQL(sql_INITPLAN);//初设上报
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
            //////////存档结束/////////////  
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