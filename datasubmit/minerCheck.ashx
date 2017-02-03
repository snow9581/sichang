<%@ WebHandler Language="C#" Class="minerCheck" %>

using System;
using System.Web;
using System.Web.SessionState;

public class minerCheck : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        DB db = new DB();
        string sql = "";
        
        string id = context.Request.Params["HD_ID"];
        string LEADERCHECK = context.Request.Params["LEADERCHECK"];
        string LEADEROPINION = context.Request.Params["LEADEROPINION"];
        
        string teamname = "";
        string km = "";
    /*    if (context.Session["dept"] != null)
        {
            teamname = context.Session["dept"].ToString();
            km = db.GetKM(teamname);
        }
    */
        if (context.Session["km"] != null) km = context.Session["km"].ToString();
    

        if (LEADERCHECK == "1")
        {
            sql = "update t_minerflow  set MINERCHECK='" + LEADERCHECK + "' , minerOpinion='" + LEADEROPINION + "',endtime = to_date('" + DateTime.Now.ToString() + "','yyyy-mm-dd hh24:mi:ss') where id=" + id + " and minername = '" + km + "'";
            //如果所有矿流程都审核通过，就应标志该调查结束。高俊涛2014-10-11
           
        }
        else
        {
            sql = "update t_minerflow  set MINERCHECK='" + LEADERCHECK + "' , minerOpinion='" + LEADEROPINION + "',endtime = null where id=" + id + " and minername = '" + km + "'";

        }

        bool flag = false;
        
        flag = db.ExecuteSQL(sql);
        
        
        bool isAllOver = true;

        string sql_1 = "update T_INSTITUTEINVESTIGATIONFLOW set state=1 where id=" + id;//设置调查流程状态为结束。高俊涛2014-10-11

        string sql_2 = "select minercheck from T_MINERFLOW where id=" + id;
        
        System.Data.DataTable dt = new System.Data.DataTable();
        
        dt = db.GetDataTable(sql_2);

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (dt.Rows[i]["minercheck"].ToString() =="") isAllOver = false;
              else if (Convert.ToInt16(dt.Rows[i]["minercheck"]) != 1) isAllOver = false;
        }

        bool flag1 = true;
        
        if (isAllOver) flag1=db.ExecuteSQL(sql_1);
        
        
        if (flag&flag1 == true)          
        {
            
            context.Response.Write("1");
        }
        else
        {
            context.Response.Write("0");
        }
    }
  
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}