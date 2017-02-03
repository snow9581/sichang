<%@ WebHandler Language="C#" Class="get_GGXH" %>

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

public class get_GGXH : BaseHandler
{

    public override void AjaxProcess(HttpContext context)
    {
        DB db=new DB();
        DataTable dt;
        string AZWZ = context.Request.Params["AZWZ"];
        string YQYBMC = context.Request.Params["YQYBMC"];
        if (AZWZ == null || YQYBMC == null)
            dt = db.GetDataTable("select distinct(GGXH) from T_METER where 1=0");
        else
            dt = db.GetDataTable("select distinct(GGXH) from T_METER where AZDD=" + AZWZ + " and YBMC=" + YQYBMC);
        context.Response.Write(ToJsonCombo(dt));
        context.Response.End();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }
    public static string ToJsonCombo(DataTable dt)
    {
        StringBuilder jsonBuilder = new StringBuilder();

        jsonBuilder.Append("[");
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            jsonBuilder.Append("{");
            for (int j = 0; j < dt.Columns.Count; j++)
            {

                jsonBuilder.Append("\"");
                jsonBuilder.Append("text");
                jsonBuilder.Append("\":\"");
                string text = dt.Rows[i][j].ToString();
                jsonBuilder.Append(text);
                jsonBuilder.Append("\"");


            }
            //jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
            jsonBuilder.Append("},");
        }

        jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
        jsonBuilder.Append("]");

        string Json_data = "";
        Json_data = jsonBuilder.ToString();
        return Json_data;

    }
}