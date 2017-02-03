<%@ WebHandler Language="C#" Class="get_select" %>
//员工发起仪表检定时，在挑选待检定仪表时，加载所有仪表信息，从中挑选待检定表
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
public class get_select : BaseHandler
{

    override public void AjaxProcess(HttpContext context)
    {
        DB db = new DB();
        string sql = "select * from T_METER where DM ='" + context.Session["DM"] + "'";
        string YBMC = context.Request.Params["YBMC"];
        string GGXH = context.Request.Params["GGXH"];
        string AZDD = context.Request.Params["AZDD"];
        if (YBMC != "" && YBMC != null)
        {
            sql += " and YBMC like '%" + T.preHandleSql(YBMC) + "%'";
        }
        if (GGXH != null && GGXH != "")
        {
            sql += " and GGXH like '%" + T.preHandleSql(GGXH) + "%'";
        }
        if (AZDD != null && AZDD != "")
        {
            sql += " and AZDD like '%" + T.preHandleSql(AZDD) + "%'";
        }
        DataTable dt = db.GetDataTable(sql); //数据源             
        String jsonData = wjz_tools.ToJson(dt, dt.Rows.Count, new List<string> { "CCRQ", "JDRQ" });
        context.Response.Write(jsonData);
        context.Response.End();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }
}