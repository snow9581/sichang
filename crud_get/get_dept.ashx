<%@ WebHandler Language="C#" Class="get_event" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;

public class get_event : BaseHandler {

    public override void AjaxProcess(HttpContext context)
    {
        int page = Convert.ToInt32(context.Request.Params["page"]);//页索引
        int rows = Convert.ToInt32(context.Request.Params["rows"]);
        
        string KM = context.Request.Params["KM"];
        string DM = context.Request.Params["DM"];
        string QSentence = " where 1=1 ";  //定义一个查询子句，当有一个或多个条件不为空时，使用该子句
        if (KM != null || DM != null)
        {
            if (KM != "")
            {
                QSentence = QSentence + " and KM like '%" + KM + "%'";
            }
            if (DM != "")
            {
                QSentence = QSentence + " and DM like '%" + DM + "%'";
            }
        }
        DB db = new DB();
        string sqlstr = "select * from(select t.*,rownum rn from(select * from T_DEPT " + QSentence + ") t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + "";
        string sql = "select count(*) from T_DEPT" + QSentence;
        
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