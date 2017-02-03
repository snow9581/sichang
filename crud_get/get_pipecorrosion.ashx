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
using System.Web.SessionState;

public class get_event : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        int page = Convert.ToInt32(context.Request.Params["page"]);//页索引
        int rows = Convert.ToInt32(context.Request.Params["rows"]);
        string dm = Convert.ToString(context.Session["dm"]);//获取队名
        string km = Convert.ToString(context.Session["km"]);//获取矿名
        string userlevel = Convert.ToString(context.Session["userlevel"]);//获取用户级别

        string KM = context.Request.Params["KM"];
        string DM = context.Request.Params["DM"];
        string XDFZR = context.Request.Params["XDFZR"];
        string KSRQ = context.Request.Params["KSRQ"];
        string JSRQ = context.Request.Params["JSRQ"];

        string QSentence = " where 1=1 ";  //定义一个查询子句，当有一个或多个条件不为空时，使用该子句

        if (dm != "" && userlevel == "1")
        {
            QSentence = QSentence + " and dm='" + dm + "'";
        }
        if (km != "" && (userlevel == "3" || userlevel == "5"))
        {
            QSentence = QSentence + " and km='" + km + "'";
        }
        ///条件查询 begin
        if (KM != null || DM != null || XDFZR != null || KSRQ != null || JSRQ != null)
        {
            if (KM != "")
            {
                QSentence = QSentence + " and KM like '%" + T.preHandleSql(KM) + "%'";

            }
            if (DM != "")
            {
                QSentence = QSentence + " and DM like '%" + T.preHandleSql(DM) + "%'";
            }
            if (XDFZR != "")
            {
                QSentence = QSentence + " and XDFZR like '%" + T.preHandleSql(XDFZR) + "%'";
            }
            if (KSRQ != "")
            {
                QSentence = QSentence + " and CREATEDATE >= to_date('" + KSRQ + "','yyyy-mm-dd')";
            }
            if (JSRQ != "")
            {
                QSentence = QSentence + " and CREATEDATE <= to_date('" + JSRQ + "','yyyy-mm-dd')";
            }            
        }
        ///条件查询 end
        DB db = new DB();
        string sqlstr = "select * from(select t.*,rownum rn from(select * from T_PIPECORROSION" + QSentence + " order by CREATEDATE desc) t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + "";
        string sql = "select count(*) from T_PIPECORROSION" + QSentence;
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