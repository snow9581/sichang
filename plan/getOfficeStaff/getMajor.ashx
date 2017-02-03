<%@ WebHandler Language="C#" Class="getMajor" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;

public class getMajor : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/json";
        string major=context.Request.Params["major"];
        string pid = context.Request.Params["pid"];
        string sql = ""; 
        DB db = new DB();
        if (major == null)
        {
            sql = "select DISTINCT(major) from T_USER where major is not null";
            DataTable dt = db.GetDataTable(sql); //数据源             
            string jsonData = T.ToJsonCombo(dt);
            context.Response.Write(jsonData);
            context.Response.End();
        }
        else
        {
            string psql = "select pname,pnumber from T_PLANRUN_DTZ where pid='" + pid + "' ";
            DataTable dd = db.GetDataTable(psql);
            if (dd.Rows.Count > 0)
            {
                string QSentence = "";
                string pnum=dd.Rows[0]["pnumber"].ToString();
                if (pnum != "" && pnum != null)
                {
                    QSentence = " and pnumber='" + pnum + "' ";
                }
                sql = "select DISTINCT(SENDEE) from T_COMMISSIONINFORMATION where pname='" + dd.Rows[0]["pname"].ToString() + "' " + QSentence + " and SENDEEMAJOR='" + major + "'";
                DataTable dt = db.GetDataTable(sql);
                if (dt.Rows.Count > 0)
                {
                    string jsonData = T.ToJsonCombo(dt);
                    context.Response.Write(jsonData);
                    context.Response.End();
                }
                else
                {
                    sql = "select username from T_USER where major='" + major + "'";
                    DataTable du = db.GetDataTable(sql); //数据源             
                    string jsonData = T.ToJsonCombo(du);
                    context.Response.Write(jsonData);
                    context.Response.End();
                }
            }
            
        }
       
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}