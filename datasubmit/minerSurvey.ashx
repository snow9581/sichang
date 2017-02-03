<%@ WebHandler Language="C#" Class="minerSurvey" %>

using System;
using System.Web;
using System.Web.SessionState;

public class minerSurvey : BaseHandler{

    public override void AjaxProcess(HttpContext context)
    {
        string teamname = "";
        string km = "";

        if (context.Session["dm"] != null) teamname = context.Session["dm"].ToString();
        if (context.Session["km"] != null) km = context.Session["km"].ToString();
        string id = context.Request.Params["HD_ID"];
        string NAME = context.Request.Params["NAME"];
        if (context.Request.Params["type"] != null)
        {
            if (context.Request.Params["type"].ToString() == "1")
            {
                DB db1 = new DB();
                string sqlstr = "select distinct(a.dm) from t_dept a,t_user b where a.km = '" + km + "' and b.userlevel = 1";
                System.Data.DataTable dt = db1.GetDataTable(sqlstr); //数据源             
                String jsonData = ToJsonCombo(dt);
                context.Response.Write(jsonData);
                context.Response.End();
            }
        }
        
        DB db = new DB();
        string sql = "update t_minerflow  set starttime = to_date('" + DateTime.Now.ToString() + "','yyyy-mm-dd hh24:mi:ss') where id=" + id + " and minername = '" + km + "'";
        bool flag = false;
        flag = db.ExecuteSQL(sql);

        string[] team = context.Request.Params["TEAM"].Split(',');
        for (int i = 0; i < team.Length; i++)
        {
            string sql2 = "insert into t_team(id, minername, teamname,type) values('" + id + "','" + km + "','" + team[i] + "','待填写调查报告')";
            db.ExecuteSQL(sql2);
        }

        if (flag == true)
        {
            context.Response.Write("1");
        }
        else
        {
            context.Response.Write("0");
        }      

    }
    public static string ToJsonCombo(System.Data.DataTable dt)
    {
        System.Text.StringBuilder jsonBuilder = new System.Text.StringBuilder();

        jsonBuilder.Append("[");
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            jsonBuilder.Append("{");
            for (int j = 0; j < dt.Columns.Count; j++)
            {

                jsonBuilder.Append("\"");
                jsonBuilder.Append("text");
                jsonBuilder.Append("\":\"");
                string text = dt.Rows[i][j].ToString();
                jsonBuilder.Append(text);
                jsonBuilder.Append("\"");


            }
            //jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
            jsonBuilder.Append("},");
        }

        jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
        jsonBuilder.Append("]");

        string Json_data = "";
        Json_data = jsonBuilder.ToString();
        return Json_data;

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
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}