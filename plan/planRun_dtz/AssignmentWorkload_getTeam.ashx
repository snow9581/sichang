<%@ WebHandler Language="C#" Class="AssignmentWorkload_getTeam" %>

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

public class AssignmentWorkload_getTeam : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        int page = Convert.ToInt32(context.Request.Params["page"]);//页索引
        int rows = Convert.ToInt32(context.Request.Params["rows"]);
        string userlevel = Convert.ToString(context.Session["userlevel"]);//获取用户级别
        string username = Convert.ToString(context.Session["username"]);//获取用户名
        string PID = context.Request.Params["pid"];
        string DM = context.Request.Params["DM"];

        ///条件查询 begin
        string Receiver = context.Request.Params["Receiver"];

        string QSentence = " where 1=1";
        if (PID != ""&& DM!="")//当前用户为地面队长
        {
            QSentence += " and PID='" + PID + "' and Sender='" + DM + "'";
        }
        else if (userlevel == "1")//当前用户为小队
        {
            QSentence += " and Receiver='" + username + "'";
        }
        if (Receiver != null && Receiver != "")//查询条件
        {
            QSentence = QSentence + " and Receiver like '%" + T.preHandleSql(Receiver) + "%'";
        }
        string sqlstr = "select * from(select t.*,rownum rn from(select * from T_ASSIGNMENTWORKLOAD " + QSentence + ") t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + "";

        ///条件查询 end

        string sql = "select count(*) from T_ASSIGNMENTWORKLOAD" + QSentence;

        DB db = new DB();
        int Count = db.GetCount(sql);//获取总条数
        DataTable dt = db.GetDataTable(sqlstr); //获取当前页的数据   
        //增加列
        dt.Columns.Add("MINECONTENT");
        if (Count > 0)
        {
            string sql_mine = "select CONTENT from T_ASSIGNMENTWORKLOAD where RECEIVER='" + dt.Rows[0]["SENDER"].ToString() + "' and PID = '" + dt.Rows[0]["PID"].ToString() + "'";
            DataTable dd = db.GetDataTable(sql_mine);
            for (int i = 0; i < dd.Rows.Count; i++)
            {
                dt.Rows[i]["MINECONTENT"] = dd.Rows[0][0].ToString();
            }
        }          
        String jsonData = T.ToJson(dt, Count);
        context.Response.Write(jsonData);
        context.Response.End();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}