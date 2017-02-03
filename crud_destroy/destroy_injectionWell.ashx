<%@ WebHandler Language="C#" Class="destroy_injectionWell" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public class destroy_injectionWell : BaseHandler {

    public override void AjaxProcess(HttpContext context)
    {

        string ID = context.Request.Params["ID"];
        DB db = new DB();
        string sql = "delete from T_injectionWell where ID='" + ID + "'";

        bool result = db.ExecuteSQL(sql);
        if (result)
        {
            string state = "{\"success\":true}";

            context.Response.Write(state);
            context.Response.End();
        }
        else
        {
            context.Response.Write("<script>alert('  错误!\\n删除失败！'</script>");
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}