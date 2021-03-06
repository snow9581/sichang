﻿
<%@ WebHandler Language="C#" Class="destroy_proofcheck" %>
///<summary> 
  ///模块编号：archives-08 电子档案管理子系统8号模块 destroy功能代码   
  ///作用：<含最初方案、上报方案、审查后方案进行存储> <删除单条记录>
  ///作者：by wya 
  ///编写日期：2014-10-07  
///</summary>
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public class destroy_proofcheck : BaseHandler
{

    public override void AjaxProcess(HttpContext context)
    {

        string ID = context.Request.Params["ID"];
        DB db = new DB();
        string filename = "";

        string idsql = "select FILES from T_proofcheck where ID='" + T.preHandleSql(ID) + "'";

        System.Data.DataTable dt = db.GetDataTable(idsql);
        if (dt.Rows.Count > 0) filename = dt.Rows[0]["FILES"].ToString();
        
        string sql = "delete from T_proofcheck where ID='" + T.preHandleSql(ID) + "'";

       bool result=db.ExecuteSQL(sql);
       if (result)
       {
           if (filename != "")
           {
               try
               {
                   FTP ftp = new FTP();
                   ftp.Delete("archives", filename);
               }
               catch (Exception ex)
               {
                   SClog.insert("error", "ftp delete failure" + ex.ToString());
               }
           }     
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