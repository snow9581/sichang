<%@ WebHandler Language="C#" Class="get_ComInfMain" %>

using System;
using System.Web;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;

public class get_ComInfMain : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        int page = Convert.ToInt32(context.Request.Params["page"]);//页索引
        int rows = Convert.ToInt32(context.Request.Params["rows"]);
        //从计划运行获取的查询条件，查询与项目相关的记录
        string pna = context.Request.Params["pna"];
        string pnum = context.Request.Params["pnum"];
        string ptype = context.Request.Params["ptype"];
        
        DB db = new DB();

        ///条件查询 begin
        string PNUMBER = context.Request.Params["PNUMBER"];
        string PNAME = context.Request.Params["PNAME"];

        string QSentence = " where 1=1 ";  //定义一个查询子句，当有一个或多个条件不为空时，使用该子句
        //双击某一条记录的查询条件
        if (pna != "" && pna != null)
        {
            QSentence = QSentence + " and PNAME = '" + T.preHandleSql(pna) + "'";
        }
        if (pnum != "" && pnum != null)
        {
            QSentence = QSentence + " and PNUMBER = '" + T.preHandleSql(pnum) + "'";
        }
        if (ptype != "" && ptype != null)
        {
            QSentence = QSentence + " and FILETYPE = '" + T.preHandleSql(ptype) + "'";
        }
        else//搜索条件
        {
            if (PNUMBER != "" && PNUMBER != null)
            {
                QSentence = QSentence + " and PNUMBER like '%" + T.preHandleSql(PNUMBER) + "%'";
            }
            if (PNAME != "" && PNAME != null)
            {
                QSentence = QSentence + " and PNAME like '%" + T.preHandleSql(PNAME) + "%'";
            }
        }
        string sqlstr = "select * from(select t.*,rownum rn from(select PNAME,PNUMBER,FILETYPE from T_COMMISSIONINFORMATION " + QSentence + " group by PNAME,PNUMBER,FILETYPE) t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + "";
        ///条件查询 end
        string sql = "select count(*) from T_COMMISSIONINFORMATION" + QSentence + " group by PNAME,PNUMBER,FILETYPE";
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