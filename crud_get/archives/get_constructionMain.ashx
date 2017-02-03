<%@ WebHandler Language="C#" Class="get_constructionMain" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;

public class get_constructionMain : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        int page = Convert.ToInt32(context.Request.Params["page"]);//页索引
        int rows = Convert.ToInt32(context.Request.Params["rows"]);
        //从计划运行获取的查询条件，查询与项目相关的记录
        string pna = context.Request.Params["pna"];
        string pnum = context.Request.Params["pnum"];
        DB db = new DB();

        string PID = context.Request.Params["PID"];
        string PNAME = context.Request.Params["PNAME"];
        string QSentence = " where 1=1 ";  //定义一个查询子句，当有一个或多个条件不为空时，使用该子句

        if (PID != "" && PID != null)
        {
            QSentence = QSentence + " and PID like '%" + T.preHandleSql(PID) + "%'";
        }
        if (PNAME != "" && PNAME != null)
        {
            QSentence = QSentence + " and PNAME like '%" + T.preHandleSql(PNAME) + "%'";
        }
        if (pna != "" && pna != null)
        {
            QSentence = QSentence + " and PNAME = '" + T.preHandleSql(pna) + "'";
        }
        if (pnum != "" && pnum != null)
        {
            QSentence = QSentence + " and PID = '" + T.preHandleSql(pnum) + "'";
        }
        string sqlstr = "select * from(select t.*,rownum rn from(select PID,PNAME,PLEADER from T_construction " + QSentence + " group by PID,PNAME,PLEADER) t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + "";

        ///条件查询 end
        string sql = "select count(*) from T_construction" + QSentence + " group by PID,PNAME,PLEADER";
        int Count = db.GetCount(sql);//获取总条数

        DataTable dt = db.GetDataTable(sqlstr); //数据源             
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