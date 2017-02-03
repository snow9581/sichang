<%@ WebHandler Language="C#" Class="get_calibrator" %>

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


public class get_calibrator : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        int page = Convert.ToInt32(context.Request.Params["page"]);//页索引
        int rows = Convert.ToInt32(context.Request.Params["rows"]);

        string sqlstr = "SELECT * FROM (SELECT id,BZQMC,BXSJ,FZR,WJ, ROW_NUMBER () OVER (PARTITION BY BZQMC ORDER BY ID DESC )as rowindex from T_CALIBRATOR) WHERE rowindex=1";
        string sql = "select count(*) from T_CALIBRATOR";

        DB db = new DB();
        int Count = db.GetCount(sql);//获取总条数
        DataTable dt = db.GetDataTable(sqlstr); //获取当前页的数据                     
        String jsonData = T.ToJson(dt, Count);
        context.Response.Write(jsonData);
        context.Response.End();

    }

   
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}