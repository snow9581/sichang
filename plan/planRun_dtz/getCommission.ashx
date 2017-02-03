<%@ WebHandler Language="C#" Class="getCommission" %>

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

public class getCommission : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string userlevel = Convert.ToString(context.Session["userlevel"]);
        string username = Convert.ToString(context.Session["username"]);
        string DM = Convert.ToString(context.Session["dm"]);
        int page = Convert.ToInt32(context.Request.Params["page"]);//页索引
        int rows = Convert.ToInt32(context.Request.Params["rows"]);
        string PID = context.Request.Params["PID"];
        string type = context.Request.Params["type"];
        
        DB db = new DB();
        
        //判断用户是否为设计负责人或方案负责人
        string judgePerson = "select count(*) from T_PLANRUN_DTZ where SOLUCHIEF='" + username + "' or DESICHIEF='"+username+"'";
        int num = db.GetCount(judgePerson);
        
        ///条件查询 begin
        string Find_SENDEE = context.Request.Params["Find_SENDEE"];
        string QSentence = " where 1=1 ";  //定义一个查询子句，当有一个或多个条件不为空时，使用该子句
        if (userlevel == "6"&& num==0)
        {
            QSentence = QSentence + " and (CONSIGNER ='" + username + "' OR SENDEE='" + username + "')";
        }
        if (Find_SENDEE != null && Find_SENDEE != "")
        {
            QSentence = QSentence + " and SENDEE like '%" + T.preHandleSql(Find_SENDEE) + "%'";
        }
        if (type == "1")
            QSentence = QSentence + " and FILETYPE = '一次委托资料' ";
        else if (type == "2")
            QSentence = QSentence + " and FILETYPE = '二次委托资料' ";

        string psql = "select * from T_PLANRUN_DTZ where PID ='" + PID + "'";
        DataTable dd = db.GetDataTable(psql);
        if (dd.Rows.Count > 0)
        {
            QSentence = QSentence + " and pname = '" + dd.Rows[0]["PNAME"] + "' ";
            string sqlstr = "select * from(select t.*,rownum rn from(select * from T_COMMISSIONINFORMATION " + QSentence +") t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + "";
            string sql = "select count(*) from T_COMMISSIONINFORMATION " + QSentence;
            int Count = db.GetCount(sql);//获取总条数
            DataTable dt = db.GetDataTable(sqlstr); //获取当前页的数据                         

            String jsonData = T.ToJson_LongDate(dt, Count);
            context.Response.Write(jsonData);
            context.Response.End();
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}