<%@ WebHandler Language="C#" Class="get_new_lan" %>

using System;
using System.Web;
using System.Data;
using System.Web.Script.Serialization;
using System.Web.SessionState;
using System.Text;

public class get_new_lan : BaseHandler
{

    public override void AjaxProcess(HttpContext context)
    {
        try
        {
            string sql = "select LANMU from T_LAN ";
            DB db = new DB();
            DataTable dt = new DataTable();
            dt = db.GetDataTable(sql);
            String jsonData = ToJsonCombo(dt);
            context.Response.Write(jsonData);
            context.Response.End();
        }
        catch (Exception ex)
        {            
            throw ex;
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
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}