<%@ WebHandler Language="C#" Class="get_temp" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;
public class get_temp : BaseHandler {
    
    public override void AjaxProcess (HttpContext context) {
        DB db = new DB();
        string sql = "select * from T_PLANTEMPLATE";
        DataTable dt = db.GetDataTable(sql);
        int Count = db.GetCount(sql);//获取总条数
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