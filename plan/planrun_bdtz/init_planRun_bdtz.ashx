<%@ WebHandler Language="C#" Class="init_planRun_bdtz" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;
using System.Web.SessionState;
using System.Configuration;
using System.IO;

public class init_planRun_bdtz : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string PName = context.Request.Params["PName"];
        string PNUMBER = context.Request.Params["PNUMBER"];
        string SoluChief = context.Request.Params["SoluChief"].TrimEnd(',');
        SoluChief = SoluChief.TrimStart(',');
        DB db = new DB();
        string sql = "insert into T_PLANRUN_BDTZ(PID,PNAME,PNUMBER,SoluChief,NEWITEMDATE,BUFFER)" +
            " values (SEQ_PLANRUN_BDTZ.nextval,'" + T.preHandleSql(PName) + "','" + T.preHandleSql(PNUMBER) + "','" + SoluChief + "',to_date('" + DateTime.Now.ToString() + "','yyyy-mm-dd hh24:mi:ss'),0)";

        bool flag = db.ExecuteSQL(sql);

        if (flag == true)
        {
            context.Response.Write("1");
        }
        else
        {
            context.Response.Write("0");
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}