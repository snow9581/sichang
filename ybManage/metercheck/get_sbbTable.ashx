<%@ WebHandler Language="C#" Class="get_sbbTable" %>
//加载申报表时执行
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

public class get_sbbTable : BaseHandler
{

    override public void AjaxProcess(HttpContext context)
    {
        string fromid = context.Request.Params["FROMID"].ToString();
        DB db = new DB();
        DataTable dt = db.GetDataTable("select * from T_METER_CHECK_SBB where FROMID='" + fromid + "'");
        string json = wjz_tools.ToJson(dt, dt.Rows.Count, new List<string>() { "JDRQ" });
        context.Response.Write(json);
        context.Response.End();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}