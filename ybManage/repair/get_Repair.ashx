<%@ WebHandler Language="C#" Class="get_Repair" %>

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

public class get_Repair : BaseHandler
{

    public override void AjaxProcess(HttpContext context)
    {
        int page = Convert.ToInt32(context.Request.Params["page"]);//页索引
        int rows = Convert.ToInt32(context.Request.Params["rows"]);
        DB db = new DB();
        string KM = context.Session["KM"].ToString();
        string DM = context.Session["DM"].ToString();
        string userlevel = context.Session["userlevel"].ToString();
        //权限控制
        string sql;
        if (DM == "仪表室")
            sql = "select * from T_INSTRUREPAIR";
        else
            sql = "select * from T_INSTRUREPAIR where DW='" + KM + "'";
        //权限控制
        string sqlstr = "select * from(select t.*,rownum rn from(" + sql + " ) t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + "";
        DataTable Count = db.GetDataTable(sql);//获取总条数
        DataTable dt = db.GetDataTable(sqlstr); //数据源
        DataColumn dc = new DataColumn();
        dc.DataType = typeof(string);
        dc.ColumnName = "workitem";
        dt.Columns.Add(dc);
        //dt.Columns.Add("workitem", typeof(string));
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (dt.Rows[i]["STATE"].ToString() == "3")
                dt.Rows[i]["workitem"] = "通过";
            else if (dt.Rows[i]["STATE"].ToString() == "4")
                dt.Rows[i]["workitem"] = "不通过";
            else if (userlevel == "5" && dt.Rows[i]["STATE"].ToString() == "1")
                dt.Rows[i]["workitem"] = "是我";
            else if (userlevel == "5" && dt.Rows[i]["STATE"].ToString() == "2")
                dt.Rows[i]["workitem"] = "等待中";
            else if (userlevel == "2" && dt.Rows[i]["STATE"].ToString() == "1")
                dt.Rows[i]["workitem"] = "等待中";
            else if (userlevel == "2" && dt.Rows[i]["STATE"].ToString() == "2")
                dt.Rows[i]["workitem"] = "是我";
            else if (userlevel == "1" && dt.Rows[i]["STATE"].ToString() == "5")
                dt.Rows[i]["workitem"] = "是我";
            else
                dt.Rows[i]["workitem"] = "等待中";
        }

        int head = 0;
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (dt.Rows[i]["workitem"].ToString() == "是我")
            {
                DataRow dr = dt.NewRow();
                for (int j = 0; j < dt.Columns.Count; j++)
                    dr[j] = dt.Rows[i][j].ToString();
                for (int j = 0; j < dt.Columns.Count; j++)
                    dt.Rows[i][j] = dt.Rows[head][j].ToString();
                for (int j = 0; j < dt.Columns.Count; j++)
                    dt.Rows[head][j] = dr[j].ToString();
                head++;
            }
        }
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (dt.Rows[i]["workitem"].ToString() == "等待中")
            {
                DataRow dr = dt.NewRow();
                for (int j = 0; j < dt.Columns.Count; j++)
                    dr[j] = dt.Rows[i][j].ToString();
                for (int j = 0; j < dt.Columns.Count; j++)
                    dt.Rows[i][j] = dt.Rows[head][j].ToString();
                for (int j = 0; j < dt.Columns.Count; j++)
                    dt.Rows[head][j] = dr[j].ToString();
                head++;
            }
        }
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (dt.Rows[i]["workitem"].ToString() == "通过")
            {
                DataRow dr = dt.NewRow();
                for (int j = 0; j < dt.Columns.Count; j++)
                    dr[j] = dt.Rows[i][j].ToString();
                for (int j = 0; j < dt.Columns.Count; j++)
                    dt.Rows[i][j] = dt.Rows[head][j].ToString();
                for (int j = 0; j < dt.Columns.Count; j++)
                    dt.Rows[head][j] = dr[j].ToString();
                head++;
            }
        }
        String jsonData = ToJson(dt, Count.Rows.Count);
        context.Response.Write(jsonData);
        context.Response.End();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
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
                //jsonBuilder.Append(dt.Columns[j].ColumnName);
                jsonBuilder.Append("\":\"");

                string tempValue = dt.Rows[i][j].ToString();
                if (tempColname == "RQ")
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
}