<%@ WebHandler Language="C#" Class="get_workLoad" %>

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

public class get_workLoad : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string userlevel = Convert.ToString(context.Session["userlevel"]);
        string username = Convert.ToString(context.Session["username"]);
        string DM = Convert.ToString(context.Session["dm"]);
        int page = Convert.ToInt32(context.Request.Params["page"]);//页索引
        int rows = Convert.ToInt32(context.Request.Params["rows"]);

        ///条件查询 begin
        string w_pid = context.Request.Params["w_pid"];
        string w_name = context.Request.Params["w_name"];
        string w_major = context.Request.Params["w_major"];
        string KSRQ = context.Request.Params["KSRQ"];
        string JSRQ = context.Request.Params["JSRQ"];
        string QSentence = " where W_PID="+w_pid;  //定义一个查询子句，当有一个或多个条件不为空时，使用该子句
        if (w_major != null && w_major != "")
        {
            QSentence = QSentence + " and W_MAJOR like '%" + T.preHandleSql(w_major) + "%'";
        }
        if (w_name != null && w_name != "")
        {
            QSentence = QSentence + " and W_NAME like '%" + T.preHandleSql(w_name) + "%'";
        }
        if (KSRQ != null && KSRQ != "")
        {
            QSentence = QSentence + " and W_DATE >= to_date('" + KSRQ + "','yyyy-mm-dd')";
        }
        if (JSRQ != null && JSRQ != "")
        {
            QSentence = QSentence + " and W_DATE <= to_date('" + JSRQ + "','yyyy-mm-dd')";
        }

        string sqlstr = "select W_ID,W_NAME,W_FILE,to_char(W_DATE,'yyyy-mm-dd hh24:mi:ss') AS W_DATE,W_PID,W_MAJOR from(select t.*,rownum rn from(select * from T_WORKLOADSUBMIT " + QSentence + ") t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + "";

        ///条件查询 end

        string sql = "select count(*) from T_WORKLOADSUBMIT" + QSentence;

        DB db = new DB();
        int Count = db.GetCount(sql);//获取总条数
        DataTable dt = db.GetDataTable(sqlstr); //获取当前页的数据                     

        String jsonData = T.ToJson_LongDate(dt, Count);
        context.Response.Write(jsonData);
        context.Response.End();

    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}