<%@ WebHandler Language="C#" Class="jly_submit_jld" %>

using System;
using System.Web;
using System.Data;
public class jly_submit_jld : BaseHandler {
    
    override public void AjaxProcess (HttpContext context) {
        string str = System.Web.HttpUtility.UrlDecode(context.Request.Params["str"].ToString());
        string[] strs = str.Split(',');
     //   string sql = "update T_measure_REPAIR set WXDW='" + strs[0] + "',WXNR='" + strs[1] + "',PJYYQK='" + strs[2] + "',WXJG='" + strs[3] + "',WXRQZ='" + strs[4] + "',STATE='4',SCDWQZ='" + strs[5] + "' where ID=" + strs[6];
        //将原来固定拼接update SQL语句改为根据传参的情况动态拼接。

        string sql = "update T_measure_REPAIR set STATE='4' ";//结束流程。
                
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