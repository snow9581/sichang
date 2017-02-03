<%@ WebHandler Language="C#" Class="teamSubmitView" %>

using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;
using System.Web.SessionState;
using System.Configuration;
public class teamSubmitView :BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string teamname = "";
        string km = "";
        if (context.Session["username"] != null)
        {
            teamname = context.Session["username"].ToString();
            km = GetKM(teamname);
        }
        int page = Convert.ToInt32(context.Request.Params["page"]);//页索引    
        int rows = Convert.ToInt32(context.Request.Params["rows"]);
        DB db = new DB();
        string sqlstr = "select * from(select t.*,rownum rn from(" +
            "select id,(select name from t_instituteinvestigationflow where id = t_team.id) name,starttime,endtime,wordname,excelname,type from t_team where teamname = '" + teamname + "' " +
            ") t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + "";
        string sql = "select count(*) from t_instituteinvestigationflow a,t_team c where a.id=c.id";
        int Count = db.GetCount(sql);//获取总条数
        DataTable dt = db.GetDataTable(sqlstr); //数据源             
        String jsonData = T.ToJson(dt, Count);
        context.Response.Write(jsonData);
        context.Response.End();

    }
    
    public string GetKM(string DM)
    {
        string km = "";
        DB db = new DB();
        string sql = "select km from t_dept where dm = '" + DM + "'";
        System.Data.DataTable dt = new System.Data.DataTable();
        dt = db.GetDataTable(sql);
        if (dt.Rows.Count > 0)
        {
            km = dt.Rows[0][0].ToString();
        }
        return km;

    }
    
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}