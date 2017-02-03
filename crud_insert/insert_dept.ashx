<%@ WebHandler Language="C#" Class="insert_dept" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.SessionState;
public class insert_dept : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string json = "";
        string CM = "第四采油厂";
        string KM = context.Request.Params["KM"];
        string DM = context.Request.Params["DM"];
        string ID = "0";
        DB db = new DB();
        string sql_id = "select SEQ_DEPT.nextval from dual";
        System.Data.DataTable dt = db.GetDataTable(sql_id);
        if (dt.Rows.Count > 0) ID = dt.Rows[0][0].ToString();

        string sql = "insert into T_DEPT(ID,CM,DM,KM) values (" + ID + ",'" + CM + "','" + DM + "','" + KM + "')";

        bool result=db.ExecuteSQL(sql);
       
        if (result)
        {
            Dept dept = new Dept();
            dept.ID = ID;
            dept.CM = CM;
            dept.KM = KM;
            dept.DM = DM;
           
            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(dept);
            context.Response.Write(json);
            context.Response.End();
        }
        else
        {
            context.Response.Write("<script>alert('  错误!\\n添加失败！');</script>");
        }
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}