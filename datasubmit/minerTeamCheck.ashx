<%@ WebHandler Language="C#" Class="minerTeamCheck" %>

using System;
using System.Web;
using System.Web.SessionState;

public class minerTeamCheck : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string id = context.Request.Params["HD_ID"];
        string LEADERCHECK = context.Request.Params["LEADERCHECK"];
        string type = "工艺队审核通过";
        if (LEADERCHECK == "0")
        {
            type = "工艺队审核退回";
        }
        string LEADEROPINION = context.Request.Params["LEADEROPINION"];

        DB db = new DB();

        string sql = "";
        
        if (LEADERCHECK == "1")
        {
            sql = "update t_team  set type='" + type + "' , MINEROPINION='" + LEADEROPINION + "',endtime = to_date('" + DateTime.Now.ToString() + "','yyyy-mm-dd hh24:mi:ss') where rowid='" + id + "'";
        }
        else
        {
            sql = "update t_team  set type='" + type + "' , MINEROPINION='" + LEADEROPINION + "',endtime = null where rowid='" + id + "'";
        }
        bool flag = false;
        flag = db.ExecuteSQL(sql);
       
        if (flag == true)
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