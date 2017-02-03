<%@ WebHandler Language="C#" Class="get_InstructionDocuments" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;

public class get_InstructionDocuments : BaseHandler {

    public override void AjaxProcess(HttpContext context)
    {
        int page = Convert.ToInt32(context.Request.Params["page"]);//页索引
        int rows = Convert.ToInt32(context.Request.Params["rows"]);
        DB db = new DB();

        ///条件查询 begin
        string NAME = context.Request.Params["NAME"];
        string KSRQ = context.Request.Params["KSRQ"];
        string JSRQ = context.Request.Params["JSRQ"];

        string QSentence = " where 1=1 ";  //定义一个查询子句，当有一个或多个条件不为空时，使用该子句
        if (NAME != null || KSRQ != null || JSRQ != null)
        {
            if (NAME != "")
            {
                QSentence = QSentence + " and FNAME like '%" + T.preHandleSql(NAME) + "%'";
            }
            if (KSRQ != "")
            {
                QSentence = QSentence + " and SCRQ >= to_date('" + KSRQ + "','yyyy-mm-dd')";
            }
            if (JSRQ != "")
            {
                QSentence = QSentence + " and SCRQ <= to_date('" + JSRQ + "','yyyy-mm-dd')";
            }
            
        }
        string sqlstr = "select * from(select t.*,rownum rn from(select * from T_InstructionDocuments " + QSentence + ") t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + "";
        ///条件查询 end

        string sql = "select count(*) from T_InstructionDocuments" + QSentence;
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