<%@ WebHandler Language="C#" Class="get_planYear" %>

using System;
using System.Web;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;

public class get_planYear : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        String jsonData = "";
        DB db = new DB();
        string sqlstr = "";
        sqlstr = "select * from (select distinct substr(pnumber,instr(pnumber,'(')+1,instr(pnumber,')')-3) as pyear from T_PLANRUN_DTZ order by pyear asc) where pyear is not null";
        DataTable dt = db.GetDataTable(sqlstr); //数据源  
        dt.Rows.Add("其他");        
        jsonData = T.ToJsonCombo(dt);

        context.Response.Write(jsonData);
        context.Response.End();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}