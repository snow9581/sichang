<%@ WebHandler Language="C#" Class="AssignmentWorkload_update" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.SessionState;

public class AssignmentWorkload_update : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string json = "";
        string username = context.Session["username"].ToString();
        string RECEIVER = context.Request.Params["RECEIVER"].Trim(',');
        string CONTENT = context.Request.Params["CONTENT"];
        string FEEDBACKINFORMATION=context.Request.Params["FEEDBACKINFORMATION"];
        string pid = context.Request.Params["hd_pid"];
        string id = context.Request.Params["ID"];
        DB db = new DB();
        string sql_select = "select * from T_PLANRUN_DTZ where pid='" + pid + "'";
        System.Data.DataTable dd = db.GetDataTable(sql_select);
        if (dd.Rows.Count > 0)
        {
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
            //更新数据到数据库
            string sql = "update T_ASSIGNMENTWORKLOAD set PNAME='" + dd.Rows[0]["PNAME"].ToString() + "',PNUMBER='" + dd.Rows[0]["PNUMBER"].ToString() + "',PID='" + dd.Rows[0]["PID"].ToString() + "',"
                + "SOLUCHIEF='" + dd.Rows[0]["SOLUCHIEF"].ToString() + "',DESICHIEF='" + dd.Rows[0]["DESICHIEF"].ToString() + "',BUDGETCHIEF='" + dd.Rows[0]["BUDGETCHIEF"].ToString() + "',RECEIVER='"
                + RECEIVER + "',CONTENT='" + CONTENT + "',TIMERANGE='" + TIMERANGE + "',FEEDBACKINFORMATION='" + FEEDBACKINFORMATION + "' where id=" + id;

            bool result = db.ExecuteSQL(sql);
            if (result)
            {
                string ss = "select * from T_ASSIGNMENTWORKLOAD where id="+id;
                System.Data.DataTable dt = db.GetDataTable(ss);
                AssignmentWorkload assignmentWorkload = new AssignmentWorkload();
                assignmentWorkload.ID = id;
                assignmentWorkload.PNAME = dd.Rows[0]["PNAME"].ToString();
                assignmentWorkload.PNUMBER = dd.Rows[0]["PNUMBER"].ToString();
                assignmentWorkload.PID = dd.Rows[0]["PID"].ToString();
                assignmentWorkload.SOLUCHIEF = dd.Rows[0]["SOLUCHIEF"].ToString();
                assignmentWorkload.DESICHIEF = dd.Rows[0]["DESICHIEF"].ToString();
                assignmentWorkload.BUDGETCHIEF = dd.Rows[0]["BUDGETCHIEF"].ToString();
                assignmentWorkload.RECEIVER = RECEIVER;
                assignmentWorkload.CONTENT = CONTENT;
                assignmentWorkload.SENDER = dt.Rows[0]["SENDER"].ToString();
                assignmentWorkload.CREATEDATE = dt.Rows[0]["CREATEDATE"].ToString();
                assignmentWorkload.TIMERANGE = TIMERANGE;
                assignmentWorkload.FEEDBACKINFORMATION = FEEDBACKINFORMATION;
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