<%@ WebHandler Language="C#" Class="get_NewLan" %>

using System;
using System.Web;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;
using System.Web.SessionState;

public class get_NewLan : BaseHandler
{

    public override void AjaxProcess(HttpContext context)
    {
        DB db = new DB();
        string sql = "select * from T_LAN";
        DataTable dt = new DataTable();
        dt = db.GetDataTable(sql);
        dt.Columns.Add("count", typeof(int));
        int n = dt.Rows.Count;
        for (int i = 0; i < n; i++)
        {
            string name = dt.Rows[i][0].ToString();
            string num = "select count(*) from T_Share where SH_PROJECT='" +name+ "'";
            DataTable dt_count = new DataTable();
            dt_count = db.GetDataTable(num);
            int count = Convert.ToInt32(dt_count.Rows[0][0]);
            dt.Rows[i][1] = count;
        }
        String jsonData = ToJson(dt, n);
        context.Response.Write(jsonData);
        context.Response.End();
    }
    public static string ToJson(DataTable dt, int Count)
    {
        StringBuilder jsonBuilder = new StringBuilder();

        jsonBuilder.Append("[");
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            jsonBuilder.Append("{");
            for (int j = 0; j < dt.Columns.Count; j++)
            {
                jsonBuilder.Append("\"");
                string tempColname = dt.Columns[j].ColumnName;
                jsonBuilder.Append(tempColname);
                jsonBuilder.Append("\":\"");
                string tempValue = dt.Rows[i][j].ToString();
                if (tempColname == "CCRQ"||tempColname=="JDRQ" )
                {
                    if (tempValue != null && !"".Equals(tempValue))
                    {
                        tempValue = Convert.ToDateTime(tempValue).ToShortDateString();//把数据库中取出来的日期转换为标准格式YYYY-MM-DD
                    }
                }
                jsonBuilder.Append(tempValue);
                jsonBuilder.Append("\",");
            }
            jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
            jsonBuilder.Append("},");
        }
        if (dt.Rows.Count > 0) jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
        jsonBuilder.Append("]");
        jsonBuilder.Append("}");
        string Json_data = "";
        Json_data = "{\"total\":" + Count.ToString() + ",\"rows\":" + jsonBuilder.ToString();
        return Json_data;
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}