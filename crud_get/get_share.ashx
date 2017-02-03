<%@ WebHandler Language="C#" Class="get_share" %>

using System;
using System.Web;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;
using System.Web.SessionState;

public class get_share : BaseHandler
{

    public override void AjaxProcess(HttpContext context)
    {
        //context.Response.ContentType = "text/plain";
        //context.Response.Write("Hello World");
        int page = Convert.ToInt32(context.Request.Params["page"]);//页索引
        int rows = Convert.ToInt32(context.Request.Params["rows"]);
        string XZ_PROJECT = context.Request.Params["xz_project"];
        string SH_NAME = context.Request.Params["SH_NAME"];

        string sqlstr = "";

        string QSentence = " where 1=1 ";  //定义一个查询子句，当有一个或多个条件不为空时，使用该子句
        if (XZ_PROJECT != null)
        {
            sqlstr = "select * from(select t.*,rownum rn from(select * from T_share ) t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + "";
            if (XZ_PROJECT != "")
            {
                QSentence = QSentence + " and SH_PROJECT = '" + T.preHandleSql(XZ_PROJECT) + "'";

            }
            sqlstr = "select * from(select t.*,rownum rn from(select * from T_share " + QSentence + ") t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + "";
        }
        DB db = new DB();
        DataTable dt = new DataTable();
        dt = db.GetDataTable(sqlstr);
        int Count = db.GetCount(sqlstr);
        String jsonData = ToJson(dt, Count);
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
                if (tempColname == "SH_DATE")
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