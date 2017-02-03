
<%@ WebHandler Language="C#" Class="destroy_construction1" %>
///<summary> 
  ///模块编号：archives-01 电子档案管理子系统1号模块 destroy功能代码   
  ///作用：<含最初方案、上报方案、审查后方案进行存储> <删除单条记录>
  ///作者：by wya 
  ///编写日期：2014-08-26  
///</summary>
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public class destroy_construction1 : BaseHandler
{

    public override void AjaxProcess(HttpContext context)
    {

        string ID = context.Request.Params["ID"];
        DB db = new DB();
        
        string sql = "delete from T_construction1 where ID='" + T.preHandleSql(ID) + "'";

       bool result=db.ExecuteSQL(sql);
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