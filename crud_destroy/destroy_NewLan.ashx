<%@ WebHandler Language="C#" Class="destroy_NewLan" %>

using System;
using System.Web;
using System.Data;

public class destroy_NewLan : BaseHandler{

    public override void AjaxProcess(HttpContext context)
    {
        string LANMU = context.Request.Params["LANMU"];
        DB db = new DB();
        string num = "select * from T_share where SH_PROJECT ='"+LANMU+"'";
        DataTable ct = db.GetDataTable(num);
        if (ct.Rows.Count == 0)
        {
            string sql = "delete from T_LAN where LANMU='" + LANMU + "'";
            bool result = db.ExecuteSQL(sql);
            if (result)
            {
                string state = "删除成功！";

                context.Response.Write(state);
                context.Response.End();
            }
            else
            {
                context.Response.Write("<script>alert('  错误!\\n删除失败！'</script>");
            }
        }
        else
        {
            context.Response.Write("1");
        }

        
    }


    public bool IsReusable {
        get {
            return false;
        }
    }
}
