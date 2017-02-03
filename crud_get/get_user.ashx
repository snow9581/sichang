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
        
        string USERNAME = context.Request.Params["USERNAME"];
        string DM = context.Request.Params["DM"];
        string MAJOR = context.Request.Params["MAJOR"];
        string QSentence = " where 1=1 ";  //定义一个查询子句，当有一个或多个条件不为空时，使用该子句
        if (USERNAME != "" && USERNAME != null)
        {
            QSentence = QSentence + " and USERNAME like '%" + T.preHandleSql(USERNAME) + "%'";
        }
        if (DM != "" && DM != null)
        {
            QSentence = QSentence + " and DM like '%" + T.preHandleSql(DM) + "%'";
        }
        if (MAJOR != "" && MAJOR != null)
        {
            QSentence = QSentence + " and MAJOR like '%" + T.preHandleSql(MAJOR) + "%'";
        }
        DB db = new DB(); 
        string sqlstr = "select * from(select t.*,rownum rn from(select * from T_USER " + QSentence + ") t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + "";
        string sql = "select count(*) from T_USER" + QSentence;
        int Count = db.GetCount(sql);//获取总条数
        DataTable dt = db.GetDataTable(sqlstr); //数据源      
        dt.Columns.Add("POSITION");
        for (int i=0; i < dt.Rows.Count; i++)
        {
            switch(int.Parse(dt.Rows[i]["USERLEVEL"].ToString()))
            {
                case 0: dt.Rows[i]["POSITION"] = "系统管理员"; break;
                case 1: dt.Rows[i]["POSITION"] = "小队"; break;
                case 2: dt.Rows[i]["POSITION"] = "室主任"; break;
                case 3: dt.Rows[i]["POSITION"] = "矿工艺队"; break;
                case 4: dt.Rows[i]["POSITION"] = "所长"; break;
                case 5: dt.Rows[i]["POSITION"] = "地面矿长"; break;
                case 6: dt.Rows[i]["POSITION"] = "室员工"; break;
                case 7: dt.Rows[i]["POSITION"] = "副主任"; break;
                case 8: dt.Rows[i]["POSITION"] = "图纸管理员"; break;
                default: break;
            }
        } 
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