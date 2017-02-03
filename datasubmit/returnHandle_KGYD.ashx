<%@ WebHandler Language="C#" Class="returnHandle_KGYD" %>

using System;
using System.Web;
using System.Web.SessionState;

public class returnHandle_KGYD : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string ids = context.Request.Params["XD"];
        string[] s = ids.Split(new char[] { ',' });
        string sql = "";
        string sql_1 = "";
        string id = context.Request.Params["HD_ID"];//获取调查id
        DB db = new DB();
    
        string km = "";
              
        if (context.Session["km"] != null) km = context.Session["km"].ToString();
        
        for (int i = 0; i < s.Length;i++ )
        {
            string opinion=context.Request.Params[s[i].ToString()];//获得修改意见

            sql = "update t_team  set type='工艺队审核退回' , MINEROPINION='" + opinion + "',endtime = null where rowid='" + s[i].ToString() + "'";
            sql_1 = "update t_minerflow set submittype='' where id=" + id + " and minerName='" + km + "'";
         
            bool flag = false,flag1=false;
            flag = db.ExecuteSQL(sql);
            flag1 = db.ExecuteSQL(sql_1);

            if (flag == false)
            {
               context.Response.Write("0");
               return;
            }              
         }
        context.Response.Write("1");
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}