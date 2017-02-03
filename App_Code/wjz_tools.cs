using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Text;
/// <summary>
///wjz_tools 的摘要说明
/// </summary>
public class wjz_tools
{
	public wjz_tools()
	{
	}
    public static string ToJson(DataTable dt, int Count,List<string> Time)
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
                //jsonBuilder.Append(dt.Columns[j].ColumnName);
                jsonBuilder.Append("\":\"");

                string tempValue = dt.Rows[i][j].ToString();
                if (IsStringInList(tempColname,Time))
                {
                    if (tempValue != null && !"".Equals(tempValue))
                    {
                        tempValue = Convert.ToDateTime(tempValue).ToShortDateString();//把数据库中取出来的日期转换为标准格式YYYY-MM-DD
                    }
                }

            //    jsonBuilder.Append(tempValue);
                jsonBuilder.Append(tempValue.Replace("\r\n", "<br/>").Replace("\"", "\\\"").Replace("\r", "\\r").Replace("\n", "\\n").Replace("\t", "\\t").ToString());
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
    public static bool IsStringInList(string str,List<string> list)
    {
        for (int i = 0; i < list.Count; i++)
            if (str == list[i])
                return true;
        return false;
    }
    public static DataTable exchangeRow(DataTable dt, int x, int y)
    {
        DataRow dr = dt.NewRow();
        dr.ItemArray = dt.Rows[x].ItemArray;
        dt.Rows[x].ItemArray = dt.Rows[y].ItemArray;
        dt.Rows[y].ItemArray = dr.ItemArray;
        return dt;
    }
    public static DataTable diandaoTable(DataTable dt, int up, int down)
    {
        if (up <= down)
            return dt;
        int x = (up - down) / 2;
        if ((up - down) % 2 == 1)
            x--;
        for (int i = 0; i < x; i++)
            exchangeRow(dt, up - i, down + i);
        return dt;
    }
}