<%@ WebHandler Language="C#" Class="AssignmentWorkload_get" %>

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

public class AssignmentWorkload_get : BaseHandler {

    public override void AjaxProcess(HttpContext context)
    {
        int page = Convert.ToInt32(context.Request.Params["page"]);//页索引
        int rows = Convert.ToInt32(context.Request.Params["rows"]);
        string userlevel = Convert.ToString(context.Session["userlevel"]);//获取用户级别
        string km = Convert.ToString(context.Session["km"]);//获取用户名
        string PID = context.Request.Params["pid"];
        
        string Receiver = context.Request.Params["Receiver"];

        string QSentence = " where 1=1";
        if(PID!="")
        {
            QSentence += " and PID='" + PID + "' and Sender='规划室'";
        }
        else if (userlevel == "3")
        {
            QSentence += " and Receiver = '" + km + "'";
        } 
        if (Receiver != null && Receiver != "")///条件查询
        {
            QSentence = QSentence + " and Receiver like '%" + T.preHandleSql(Receiver) + "%'";
        }
        string sqlstr = "select * from(select t.*,rownum rn from(select * from T_ASSIGNMENTWORKLOAD " + QSentence + ") t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + "";

        string sql = "select count(*) from T_ASSIGNMENTWORKLOAD" + QSentence;

        DB db = new DB();
        int Count = db.GetCount(sql);//获取总条数
        DataTable dt = db.GetDataTable(sqlstr); //获取当前页的数据               
               
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