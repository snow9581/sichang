<%@ WebHandler Language="C#" Class="get_waterWell" %>

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

public class get_waterWell : BaseHandler {

    public override void AjaxProcess(HttpContext context)
    {
        int page = Convert.ToInt32(context.Request.Params["page"]);//页索引
        int rows = Convert.ToInt32(context.Request.Params["rows"]);
        string dm = Convert.ToString(context.Session["dm"]);
        string km = Convert.ToString(context.Session["km"]);//获取矿名
        string userlevel = Convert.ToString(context.Session["userlevel"]);
        
        //开始查询  
        string KM = context.Request.Params["KM"];
        string DM = context.Request.Params["DM"];
        string ZM = context.Request.Params["ZM"];
        string ZSZMC = context.Request.Params["ZSZMC"];
        string QSentence = " where 1=1 ";  //定义一个查询子句，当有一个或多个条件不为空时，使用该子句

        if (dm != "" && userlevel == "1")
        {
            QSentence = QSentence + " and dm='" + dm + "'";
        }
        if (km != "" && (userlevel == "3" || userlevel == "5"))
        {
            QSentence = QSentence + " and km='" + km + "'";
        }
        
        if (KM != null && KM != "")
        {
            QSentence = QSentence + " and KM like '%" + T.preHandleSql(KM) + "%'";
        }
        if (DM != null && DM != "")
        {
            QSentence = QSentence + " and DM like '%" + T.preHandleSql(DM) + "%'";
        }
        if (ZM != null && ZM != "")
        {
            QSentence = QSentence + " and ZM like '%" + T.preHandleSql(ZM) + "%'";
        }
        if (ZSZMC != null && ZSZMC != "")
        {
            QSentence = QSentence + " and ZSZMC like '%" + T.preHandleSql(ZSZMC) + "%'";
        }
        ////结束查询
        DB db = new DB();
        string sqlstr = "select * from(select t.*,rownum rn from(select * from T_waterWell " + QSentence + ") t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + "";
        string sql = "select count(*) from T_waterWell" + QSentence;
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