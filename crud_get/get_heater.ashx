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
        
        ///条件查询 begin
        string ZNBH = context.Request.Params["ZNBH"];
        string JRLMC = context.Request.Params["JRLMC"];
        string ZM = context.Request.Params["ZM"];
        string KSRQ = context.Request.Params["KSRQ"];
        string JSRQ = context.Request.Params["JSRQ"];
         string dm = Convert.ToString(context.Session["dm"]);
         string km = Convert.ToString(context.Session["km"]);//获取矿名
         string userlevel = Convert.ToString(context.Session["userlevel"]);
        string QSentence = " where 1=1 ";  //定义一个查询子句，当有一个或多个条件不为空时，使用该子句
        if (dm != "" && userlevel == "1")
        {
            QSentence = QSentence + " and dm='" + dm + "'";
        }
        if (km != "" && (userlevel == "3" || userlevel == "5"))
        {
            QSentence = QSentence + " and dm in (select dm from t_dept where km='" + km + "')";
        }
        
        if (ZNBH != null || JRLMC != null || ZM != null || KSRQ != null || JSRQ != null)
        {
            if (ZNBH != "")
            {
                QSentence = QSentence + " and ZNBH like '%" + T.preHandleSql(ZNBH) + "%'";

            }
            if (ZM != "")
            {
                QSentence = QSentence + " and ZM like '%" + T.preHandleSql(ZM) + "%'";
            }
            if (JRLMC != "")
            {
                QSentence = QSentence + " and JRLMC like '%" + T.preHandleSql(JRLMC) + "%'";
            }
            if (KSRQ != "")
            {
                QSentence = QSentence + " and TCRQ >= to_date('" + KSRQ + "','yyyy-mm-dd')";
            }
            if (JSRQ != "")
            {
                QSentence = QSentence + " and TCRQ <= to_date('" + JSRQ + "','yyyy-mm-dd')";
            }
            
        }///条件查询 end
         ///
        DB db = new DB();
        string sqlstr = "select * from(select t.*,rownum rn from(select * from T_HEATER " + QSentence + ") t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + "";
        string sql = "select count(*) from T_HEATER" + QSentence;
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