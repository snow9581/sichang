<%@ WebHandler Language="C#" Class="get_CommissionInformation" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;

public class get_CommissionInformation : BaseHandler {

    public override void AjaxProcess(HttpContext context)
    {
        int page = Convert.ToInt32(context.Request.Params["page"]);//页索引
        int rows = Convert.ToInt32(context.Request.Params["rows"]);
        DB db = new DB();
       
        string PNUMBER = context.Request.Params["pnumber"];
        string PNAME = context.Request.Params["pname"];
        string FILETYPE = context.Request.Params["ptype"];
        ///条件查询 begin
        string CONSIGNERMAJOR = context.Request.Params["CONSIGNERMAJOR"];
        string KSRQ = context.Request.Params["KSRQ"];
        string JSRQ = context.Request.Params["JSRQ"];
        string QSentence = " where 1=1 ";  //定义一个查询子句，当有一个或多个条件不为空时，使用该子句
        if (PNUMBER != "" && PNUMBER != null)
        {
            QSentence = QSentence + " and PNUMBER = '" + T.preHandleSql(PNUMBER) + "'";
        }
        if (PNAME != ""&& PNAME != null)
        {
            QSentence = QSentence + " and PNAME = '" + T.preHandleSql(PNAME) + "'";
        }
        if (FILETYPE != "" && FILETYPE != null)
        {
            QSentence = QSentence + " and FILETYPE = '" + T.preHandleSql(FILETYPE) + "'";
        }
        if (CONSIGNERMAJOR != ""&& CONSIGNERMAJOR!=null)
        {
            QSentence = QSentence + " and CONSIGNERMAJOR like '%" + T.preHandleSql(CONSIGNERMAJOR) + "%'";
        }
        if (KSRQ != "" && KSRQ != null)
        {
            QSentence = QSentence + " and RELEASERQ >= to_date('" + KSRQ + "','yyyy-mm-dd')";
        }
        if (JSRQ != "" && JSRQ != null)
        {
            QSentence = QSentence + " and RELEASERQ <= to_date('" + JSRQ + "','yyyy-mm-dd')";
        }
        string sqlstr = "select * from(select t.*,rownum rn from(select * from T_COMMISSIONINFORMATION " + QSentence + ") t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + "";
        ///条件查询 end
        string sql = "select count(*) from T_COMMISSIONINFORMATION" + QSentence;
        int Count = db.GetCount(sql);//获取总条数
        DataTable dt = db.GetDataTable(sqlstr); //数据源             
        String jsonData = T.ToJson(dt, Count);
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