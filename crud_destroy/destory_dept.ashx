<%@ WebHandler Language="C#" Class="destroy_dept" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Data;

public class destroy_dept : BaseHandler {

    public override void AjaxProcess(HttpContext context)
    {
      
        string ID = context.Request.Params["ID"];
        DB db = new DB();
        string del_sql = "delete from T_DEPT where ID='" + ID + "'";
        string sel_sql = "select username from T_USER t, t_dept s where s.id="+ID+" and s.km=t.km and s.dm=t.dm";
        DataTable dt = db.GetDataTable(sel_sql);
        int ucount = dt.Rows.Count;
        if (ucount < 1) //可以删除
        {
            bool result = db.ExecuteSQL(del_sql);
            if (result)
            {
                string state = "{\"success\":true}";

                context.Response.Write(state);
                context.Response.End();
            }
            else
            {
                context.Response.Write("<script>alert('  错误!\\n删除失败！');</script>");
            }
        
        }
        else//有用户不能删除
        {
            for (int t = 0; t < ucount; t++)
                context.Response.Write(dt.Rows[t]["username"] + " ");
        }
     
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

    
    
}