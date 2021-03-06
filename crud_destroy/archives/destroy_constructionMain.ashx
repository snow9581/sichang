﻿<%@ WebHandler Language="C#" Class="destroy_constructionMain" %>

using System;
using System.Web;

public class destroy_constructionMain : BaseHandler
{

    public override void AjaxProcess(HttpContext context)
    {
        string PNAME = context.Request.Params["PNAME"].ToString();
        string PNUMBER = context.Request.Params["PNUMBER"].ToString();
        DB db = new DB();
        bool result = true;

        string QS = "";
        if (PNUMBER != "" && PNAME != null)
            QS += " and PID='" + PNUMBER + "'";

        string idsql = "select * from T_CONSTRUCTION where PNAME='" + T.preHandleSql(PNAME) + "' " + QS;

        System.Data.DataTable dt = db.GetDataTable(idsql);
        string[] filename = new string[dt.Rows.Count];
        for (int i = 0; i < dt.Rows.Count && result == true; i++)
        {
            filename[i] = dt.Rows[i]["FILES"].ToString();
            string sql = "delete from T_CONSTRUCTION where ID='" + dt.Rows[i]["ID"].ToString() + "'";
            result = db.ExecuteSQL(sql);
            if (filename[i] != "")
            {
                try
                {
                    FTP ftp = new FTP();
                    ftp.Delete("archives", filename[i]);
                }
                catch (Exception ex)
                {
                    SClog.insert("error", "ftp delete failure" + ex.ToString());
                }
            }

        }
        if (result)
        {
            string state = "{\"success\":true}";
            context.Response.Write(state);
            context.Response.End();
        }
        else
            context.Response.Write("<script>alert('  错误!\\n删除失败！');</script>");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}