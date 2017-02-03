<%@ WebHandler Language="C#" Class="AssignmentWorkload_insert" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.SessionState;

public class AssignmentWorkload_insert : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string json = "";
        string username = context.Session["username"].ToString();
        string userlevel = context.Session["userlevel"].ToString();
        string km = context.Session["km"].ToString();
        if (userlevel == "6" || userlevel == "2")
        {
            username = "规划室";
        }
        if (userlevel == "3")
        {
            username = km;
        }
        string CREATEDATE = DateTime.Now.ToString();
        string RECEIVER = context.Request.Params["RECEIVER"].Trim(',');
        string CONTENT = context.Request.Params["CONTENT"];
        string pid = context.Request.Params["hd_pid"];
        DB db = new DB();
        string sql_select = "select * from T_PLANRUN_DTZ where pid='"+pid+"'";
        System.Data.DataTable dd = db.GetDataTable(sql_select);
        if (dd.Rows.Count > 0)
        {
            string ID = "0";
            string sql_id = "select SEQ_ASSIGNMENTWORKLOAD.nextval from dual";
            System.Data.DataTable dt = db.GetDataTable(sql_id);
            if (dt.Rows.Count > 0) ID = dt.Rows[0][0].ToString();
            
            //判断时间节点
            string TIMERANGE = "";
            if (dd.Rows[0]["BLUEGRAPHARRIVALDATE"].ToString() != "" && dd.Rows[0]["SOLUAPPROVEDATE"].ToString() != "" && dd.Rows[0]["PNUMBER"].ToString() != "" && dd.Rows[0]["PLANINVESMENT"].ToString() != "")
            {
                TIMERANGE = "完成";
            }
            else if (dd.Rows[0]["DESICHIEF"].ToString() != "" && dd.Rows[0]["WHITEGRAPHCHECKDATE_R"].ToString() == "")
            {
                TIMERANGE = "设计阶段";
            }
            else if (dd.Rows[0]["WHITEGRAPHCHECKDATE_R"].ToString() != "" && dd.Rows[0]["BLUEGRAPHARRIVALDATE"].ToString() == "")
            {
                TIMERANGE = "施工图阶段";
            }
            else
            {
                TIMERANGE = "方案阶段";
            }
            //插入数据到数据库
            string sql = "insert into T_ASSIGNMENTWORKLOAD(ID,PNAME,PNUMBER,PID,SOLUCHIEF,DESICHIEF,BUDGETCHIEF,RECEIVER,CONTENT,TIMERANGE,SENDER,CREATEDATE) values (" + ID + ",'" +
                         dd.Rows[0]["PNAME"].ToString() + "','" + dd.Rows[0]["PNUMBER"].ToString() + "','" + dd.Rows[0]["PID"].ToString() + "','" + dd.Rows[0]["SOLUCHIEF"].ToString() + "','" + dd.Rows[0]["DESICHIEF"].ToString() + "','" +
                         dd.Rows[0]["BUDGETCHIEF"].ToString() + "','" + RECEIVER + "','" + CONTENT + "','"+TIMERANGE + "','" + username + "',to_date('" + CREATEDATE + "','yyyy-mm-dd hh24:mi:ss'))"; //高俊涛修改 2014-09-07 把文件名filename存入数据库

            bool result = db.ExecuteSQL(sql);
            if (result)
            {
                AssignmentWorkload assignmentWorkload = new AssignmentWorkload();
                assignmentWorkload.ID = ID;
                assignmentWorkload.PNAME = dd.Rows[0]["PNAME"].ToString();
                assignmentWorkload.PNUMBER = dd.Rows[0]["PNUMBER"].ToString();
                assignmentWorkload.PID = dd.Rows[0]["PID"].ToString();
                assignmentWorkload.SOLUCHIEF = dd.Rows[0]["SOLUCHIEF"].ToString();
                assignmentWorkload.DESICHIEF = dd.Rows[0]["DESICHIEF"].ToString();
                assignmentWorkload.BUDGETCHIEF = dd.Rows[0]["BUDGETCHIEF"].ToString();
                assignmentWorkload.RECEIVER = RECEIVER;
                assignmentWorkload.CONTENT = CONTENT;
                assignmentWorkload.TIMERANGE = TIMERANGE;
                assignmentWorkload.SENDER = username;
                assignmentWorkload.CREATEDATE = CREATEDATE;
                JavaScriptSerializer jss = new JavaScriptSerializer();
                json = jss.Serialize(assignmentWorkload);
                context.Response.Write(json);
                context.Response.End();
            }
            else
            {
                context.Response.ContentType = "text/html";
                context.Response.Write("<script>alert('  错误!\\n添加失败！');</script>");
            }
        }
        else
        {
            context.Response.ContentType = "text/html";
            context.Response.Write("<script>alert('  错误!\\n添加失败！');</script>");
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}