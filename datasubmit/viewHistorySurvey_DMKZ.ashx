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
        DB db = new DB();
        
        string km="";
        if (context.Session["km"] != null) km = context.Session["km"].ToString();
            
        string sqlstr = "select * from(select t.*,rownum rn from("+
            "select a.name,a.initdate,b.wordname wordname0,b.excelname excelname0,b.minername,b.minercheck,b.mineropinion,c.teamname,c.wordname,c.excelname from t_instituteinvestigationflow a,t_minerflow b,t_team c where a.id = b.id and a.id = c.id and b.minername ='"+km+"' and c.minername ='"+km+"'" +
            ") t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + "";
        string sql = "select count(*) from t_instituteinvestigationflow a,t_team c where a.id=c.id";
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