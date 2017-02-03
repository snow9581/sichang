<%@ WebHandler Language="C#" Class="submit_jld" %>

using System;
using System.Web;
using System.Data;
public class submit_jld : BaseHandler {
    
    override public void AjaxProcess (HttpContext context) {
        string str = System.Web.HttpUtility.UrlDecode(context.Request.Params["str"].ToString());
        string[] strs = str.Split(',');
     //   string sql = "update T_measure_REPAIR set WXDW='" + strs[0] + "',WXNR='" + strs[1] + "',PJYYQK='" + strs[2] + "',WXJG='" + strs[3] + "',WXRQZ='" + strs[4] + "',STATE='4',SCDWQZ='" + strs[5] + "' where ID=" + strs[6];
        //将原来固定拼接update SQL语句改为根据传参的情况动态拼接。

        string sql = "update T_measure_REPAIR set STATE='6', ";//在状态3与4之间增加一个状态6，代表维修人已维修完毕，并填写完维
                                                            //修记录单，等待出产单位确认。高俊涛 2016-08-19

        //如果值为undefined，则说明该值已存在不需要修改。
        string valupdatesql = "";
        string falsestring = "undefined";
       

        if (strs[0] != falsestring)
        {
            valupdatesql = valupdatesql + " WXDW='" + strs[0] + "',";
           
        }
        if (strs[1] != falsestring)
        {
            valupdatesql = valupdatesql + " WXNR='" + strs[1] + "',";
          
        }
        if (strs[2] != falsestring)
        {
            valupdatesql = valupdatesql + " PJYYQK='" + strs[2] + "',";
           
        }
        if (strs[3] != falsestring)
        {
            valupdatesql = valupdatesql + " WXJG='" + strs[3] + "',";
         
        }
        if (strs[4] != falsestring)
        {
            valupdatesql = valupdatesql + " WXRQZ='" + strs[4] + "',";
            
        }
        if (strs[5] != falsestring)
        {
            valupdatesql = valupdatesql + " SCDWQZ='" + strs[5] + "',";
           
        }
        
        //若拼接后的修改SQL语句最后一位是“,”号，则去掉“,”号。
        if (valupdatesql[valupdatesql.Length - 1] == ',') valupdatesql = valupdatesql.Substring(0, valupdatesql.Length - 1);
        
        sql = sql + valupdatesql + " where ID=" + strs[6];
        DB db = new DB();
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