﻿<%@ WebHandler Language="C#" Class="destory_pump" %>

using System;
using System.Web;

public class destory_pump : BaseHandler {

    public override void AjaxProcess(HttpContext context)
    {
        string ID = context.Request.Params["ID"];
        DB db = new DB();
        string sql = "delete from T_PUMP where ID='" + ID + "'";
        bool result = db.ExecuteSQL(sql);
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
 
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}