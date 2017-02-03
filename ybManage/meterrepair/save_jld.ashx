<%@ WebHandler Language="C#" Class="save_jld" %>

using System;
using System.Web;
using System.Data;
//只保存《仪器仪表维修记录单》，不提交。流程状态不修改。
public class save_jld : BaseHandler {
    
    override public void AjaxProcess (HttpContext context) {
        string str = System.Web.HttpUtility.UrlDecode(context.Request.Params["str"].ToString());
        string[] strs = str.Split(',');
        
        //string sql = "update T_METER_REPAIR set WXDW='" + strs[0] + "',WXNR='" + strs[1] + "',PJYYQK='" + strs[2] + "',WXJG='" + strs[3] + "',WXRQZ='" + strs[4] + "',SCDWQZ='" + strs[5] + "' where ID=" + strs[6];
        
        //将原来固定拼接update SQL语句改为根据传参的情况动态拼接。
        
        string sql = "update T_METER_REPAIR set";
        
        //如果值为undefined，则说明该值已存在不需要修改。
        string valupdatesql = "";
        string falsestring = "undefined";
        bool needUpdate = false;//是否需要修改，决定是不是要执行这条语句。

        if (strs[0] != falsestring)
        {
            valupdatesql = valupdatesql + " WXDW='" + strs[0] + "',";
            needUpdate = true;
        }
        if (strs[1] != falsestring)
        {
            valupdatesql = valupdatesql + " WXNR='" + strs[1] + "',";
            needUpdate = true;
        }
        if (strs[2] != falsestring)
        {
            valupdatesql = valupdatesql + " PJYYQK='" + strs[2] + "',";
            needUpdate = true;
        }
        if (strs[3] != falsestring)
        {
            valupdatesql = valupdatesql + " WXJG='" + strs[3] + "',";
            needUpdate = true;
        }
        if (strs[4] != falsestring)
        {
            valupdatesql = valupdatesql + " WXRQZ='" + strs[4] + "'";
            needUpdate = true;
        }

        if (needUpdate)
        {
            //若拼接后的修改SQL语句最后一位是“,”号，则去掉“,”号。
            if (valupdatesql[valupdatesql.Length - 1] == ',') valupdatesql = valupdatesql.Substring(0, valupdatesql.Length - 1);

            sql = sql + valupdatesql + " where ID=" + strs[6];
            DB db = new DB();
            if (db.ExecuteSQL(sql))
                context.Response.Write("1");
            else
                context.Response.Write("0");
        }
        else {
            context.Response.Write("1");
        }      
      
        context.Response.End();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}