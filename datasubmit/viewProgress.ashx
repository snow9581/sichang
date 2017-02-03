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
        string username = Convert.ToString(context.Session["username"]); //高俊涛增加按用户的筛选功能 2014-10-08
        string userlevel = Convert.ToString(context.Session["userlevel"]);
        int page = Convert.ToInt32(context.Request.Params["page"]);//页索引
        int rows = Convert.ToInt32(context.Request.Params["rows"]);
        DB db = new DB();

        string sqlstr = "select * from(select t.*,rownum rn from(" +
            "select a.name,a.wordname as word,a.requirements, a.excelname as excel, a.initdate,a.leader,a.leaderopinion,a.leadercheck,a.checktime, a.GYKD, a.state, b.minername,b.minerteamcheck,b.minercheck,b.receivetime, b.excelname as wexcel, （select wm_concat(c.excelname)from t_team c where c.minername=b.minername and b.id=c.id）as excelname from t_instituteinvestigationflow a,t_minerflow b where a.initiator='" + username + "' and a.id=b.id(+)" +
           " order by a.initdate desc) t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + "";//高俊涛增加按用户的筛选功能 2014-10-10  wexcel 是总报告
        
     
        string sql = "select count(*) from t_instituteinvestigationflow a,t_minerflow b where a.id=b.id";
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