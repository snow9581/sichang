<%@ WebHandler Language="C#" Class="jly_not_submit_jld" %>

using System;
using System.Web;
using System.Data;
public class jly_not_submit_jld : BaseHandler {
    
    override public void AjaxProcess (HttpContext context) {

        string str = System.Web.HttpUtility.UrlDecode(context.Request.Params["str"].ToString());
        string[] strs = str.Split(',');
        
        string sql = "update T_METER_REPAIR set STATE='3' ";//将流程状态置回维修单填写状态。
                
        sql = sql + " where ID=" + strs[0];
        DB db = new DB();
        if (db.ExecuteSQL(sql))
            context.Response.Write("1");
        else
            context.Response.Write("0");
       
        context.Response.End();
        
        context.Response.End();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}