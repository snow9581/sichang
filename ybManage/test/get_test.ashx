<%@ WebHandler Language="C#" Class="get_text" %>
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
public class get_text : BaseHandler {

    public override void AjaxProcess (HttpContext context) {
        //context.Response.ContentType = "text/plain";
        //context.Response.Write("Hello World");
        string userlevel = Convert.ToString(context.Session["userlevel"]);
        string username = Convert.ToString(context.Session["username"]);
        string DM = Convert.ToString(context.Session["dm"]);
        int page = Convert.ToInt32(context.Request.Params["page"]);//页索引
        int rows = Convert.ToInt32(context.Request.Params["rows"]);
        string YBMC = context.Request.Params["YBMC"];
        string GGXH = context.Request.Params["GGXH"];
        string QSentence = "";
        if (YBMC != "" && YBMC != null)
        {
            QSentence += " and YBMC like '%" + T.preHandleSql(YBMC) + "%'";
        }
        if (GGXH != null && GGXH != "")
        {
            QSentence += " and GGXH like '%" + T.preHandleSql(GGXH) + "%'";
        }
        DB db = new DB();
        string select = "select ID from T_METER";
        DataTable dt_in = new DataTable();
        dt_in = db.GetDataTable(select);
        //for(int i=0;i<dt_in.Rows.Count;i++)
        //{
        //    string insert = "insert into T_METERTEXT (T_ID) values ('" + dt_in.Rows[i]["ID"] + "')";
        //    db.ExecuteSQL(insert);
        //}


        string sqlstr = "select * from(select t.*,rownum rn from(select T_METERTEXT.*,T_METER.* from T_METERTEXT,T_METER where T_METER.ID=T_METERTEXT.T_ID" + QSentence + ") t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + "";

        string sql = "select count(*) from T_METER where 1=1 " + QSentence;
        int Count = db.GetCount(sql);//获取总条数
        DataTable dt = db.GetDataTable(sqlstr); //数据源      

        dt.Columns.Add("workitem");

        CTaskList tl = new CTaskList();
        tl.userName = username;
        tl.userlevel = userlevel;
        tl.Organization = DM;

        for(int i=0;i<dt.Rows.Count;i++)
        {
            tl = tl.getSingleTaskMeterText(dt.Rows[i]);
            dt.Rows[i]["workitem"] = tl.workItem;
        }

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
                if (tempColname == "TEXTDATE"||tempColname=="VALIDDATE" )
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