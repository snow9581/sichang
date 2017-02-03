<%@ WebHandler Language="C#" Class="initSurvey" %>

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
public class initSurvey : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string id = context.Request.Params["HD_ID"];
        string NAME = context.Request.Params["NAME"];
        string LEADERCHECK = context.Request.Params["LEADERCHECK"];
        string LEADEROPINION = context.Request.Params["LEADEROPINION"];
       
        DB db = new DB();

        string sql = "update T_INSTITUTEINVESTIGATIONFLOW  set LEADERCHECK='" + LEADERCHECK + "' , LEADEROPINION='" + LEADEROPINION + "',checktime = to_date('" + DateTime.Now.ToString() + "','yyyy-mm-dd hh24:mi:ss') where id=" + id;
     
        bool flag1=true, flag2=true;//记录下列SQL语句执行结果
        
        if (LEADERCHECK == "1")//主管所长同意，生成矿级子流程
        {
            string sql2 = "select GYKD from T_INSTITUTEINVESTIGATIONFLOW where id =" + id;
            string GYKD = db.GetDataTable(sql2).Rows[0][0].ToString();
            string[] gykd = GYKD.Split(',');
            for (int i = 0; i < gykd.Length; i++)
            {
                string sql3 = "insert into t_minerflow(id,minername) values('" + id + "','" + gykd[i] + "')";
                flag1=db.ExecuteSQL(sql3);
            }
        }

        if (LEADERCHECK == "0")//主管所长拒绝，结束该流程
        {
            string sql4 = "update T_INSTITUTEINVESTIGATIONFLOW set state='1' where id=" + id;
            flag2=db.ExecuteSQL(sql4);
        }      
        
        bool flag = false;
        flag=db.ExecuteSQL(sql);
        if (flag&flag1&flag2 == true)
        {
            context.Response.Write("1");
        }
        else {
            context.Response.Write("0");
        }

        
      
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}