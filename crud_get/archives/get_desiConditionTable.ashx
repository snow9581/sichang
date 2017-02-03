<%@ WebHandler Language="C#" Class="get_desiConditionTable" %>
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;
public class get_desiConditionTable : BaseHandler {

    public override void AjaxProcess(HttpContext context)
    {
        int page = Convert.ToInt32(context.Request.Params["page"]);//页索引
        int rows = Convert.ToInt32(context.Request.Params["rows"]);
        DB db = new DB();
        //从计划运行获取的查询条件，查询与项目相关的记录
        string pna = context.Request.Params["pna"];
        string pnum = context.Request.Params["pnum"];

        ///条件查询 begin
        string KWORDS = context.Request.Params["KWORDS"];//以关键字为查询项
        string PID = context.Request.Params["PID"];
        string PNAME = context.Request.Params["PNAME"];
        string KSRQ = context.Request.Params["KSRQ"];
        string JSRQ = context.Request.Params["JSRQ"];

        string QSentence = " where 1=1 ";  //定义一个查询子句，当有一个或多个条件不为空时，使用该子句
         if (KWORDS != null && KWORDS != "")
        {
            QSentence = QSentence + " and kwords like '%" + T.preHandleSql(KWORDS) + "%'";
        }
        if (PID != null && PID != "")
        {
            QSentence = QSentence + " and PID like '%" + T.preHandleSql(PID) + "%'";
        }
        if (PNAME != null && PNAME != "")
        {
            QSentence = QSentence + " and PNAME like '%" + T.preHandleSql(PNAME) + "%'";
        }
        if (KSRQ != null && KSRQ != "")
        {
            QSentence = QSentence + " and bxrq >= to_date('" + KSRQ + "','yyyy-mm-dd')";
        }
        if (JSRQ != null && JSRQ != "")
        {
            QSentence = QSentence + " and bxrq <= to_date('" + JSRQ + "','yyyy-mm-dd')";
        }
        if (pna != "" && pna != null)
        {
            QSentence = QSentence + " and PNAME = '" + T.preHandleSql(pna) + "'";
        }
        if (pnum != "" && pnum != null)
        {
            QSentence = QSentence + " and PID = '" + T.preHandleSql(pnum) + "'";
        }

        ///条件查询 end
        string sqlstr = "select * from(select t.*,rownum rn from(select * from T_DESICONDITIONTABLE  " + QSentence + ") t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + "";
        string sql = "select count(*) from T_DESICONDITIONTABLE" + QSentence;
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