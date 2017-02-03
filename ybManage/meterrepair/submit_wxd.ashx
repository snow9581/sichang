<%@ WebHandler Language="C#" Class="submit_wxd" %>

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


public class submit_wxd : BaseHandler {
    
    override public void AjaxProcess (HttpContext context) {
        string str = System.Web.HttpUtility.UrlDecode(context.Request.Params["str"].ToString());
        string[] strs = str.Split(',');
        string name = "(";
        string values = "values(";
        if (strs[0] != "")
        {
            name += "DW,";
            values += "'" + strs[0] + "',";
        }
        if (strs[1] != "")
        {
            name += "WXLX,";
            values += "'" + strs[1] + "',";
        }
        if (strs[2] != "")
        {
            name += "AZWZ,";
            values += "'" + strs[2] + "',";
        }
        if (strs[3] != "")
        {
            name += "YQYBMC,";
            values += "'" + strs[3] + "',";
        }
        if (strs[4] != "")
        {
            name += "GGXH,";
            values += "'" + strs[4] + "',";
        }
        if (strs[5] != "")
        {
            name += "RQ,";
            values += "to_date('" + strs[5] + "','YYYY-MM-DD'),";
        }
        if (strs[6] != "")
        {
            name += "GZXX,";
            values += "'" + strs[6] + "',";
        }
        name += "ID,KM,STATE)";
        DB db = new DB();
        DataTable dt = db.GetDataTable("select SEQ_HOUSE.nextval from dual");
        values += dt.Rows[0][0].ToString() + ",'" + context.Session["KM"].ToString() + "','1')";
        string sql = "insert into T_METER_REPAIR " + name + " " + values;
        if (db.ExecuteSQL(sql))
            context.Response.Write("1");
        else
            context.Response.Write("0");
        context.Response.End();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}