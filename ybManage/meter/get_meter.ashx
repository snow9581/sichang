<%@ WebHandler Language="C#" Class="get_meter" %>

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
public class get_meter : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        int page = Convert.ToInt32(context.Request.Params["page"]);//页索引
        int rows = Convert.ToInt32(context.Request.Params["rows"]);
        string dm = Convert.ToString(context.Session["dm"]);//获取队名
        string km = Convert.ToString(context.Session["km"]);//获取矿名
        string userlevel = Convert.ToString(context.Session["userlevel"]);
        DB db = new DB();
        string sqlstr = "select * from(select t.*,rownum rn from(select * from T_METER ) t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + "";
        ///条件查询 begin
        string KM = context.Request.Params["KM"];
        string DM = context.Request.Params["DM"];
        string JDRQ1 = context.Request.Params["JDRQ1"];
        string JDRQ2 = context.Request.Params["JDRQ2"];
        string GGXH = context.Request.Params["GGXH"];
        string AZDD = context.Request.Params["AZDD"];
        string SCCJ = context.Request.Params["SCCJ"];
        string JDDW = context.Request.Params["JDDW"];
        string QSentence = " where 1=1 ";  //定义一个查询子句，当有一个或多个条件不为空时，使用该子句
        ///查询者等级的确定  
        if (km != "" && km!=null && (userlevel == "3" || userlevel == "5"))
        {
            QSentence = QSentence + "and km='" + km + "'";
        }
        else if (KM != null && KM != "")
        {
            QSentence = QSentence + " and KM like '%" + T.preHandleSql(KM) + "%'";
        }
        
        if (dm!="" && dm!=null && userlevel == "1")
        {
            QSentence = QSentence + " and dm='" + dm + "'";
        }
        else if (DM != null && DM != "")
        {
            QSentence = QSentence + " and DM like '%" + T.preHandleSql(DM) + "%'";
        }
        else if (dm == "仪表室" && (KM==""||KM==null))
        {
            QSentence += " and DM like '%仪表室%'";
        }
        
        if (JDRQ1 != null && JDRQ1 != "")
        {
            QSentence = QSentence + " and JDRQ >= to_date('" + JDRQ1 + "','yyyy-mm-dd')";
        }
        if (JDRQ2 != null && JDRQ2 != "")
        {
            QSentence = QSentence + " and JDRQ <= to_date('" + JDRQ2 + "','yyyy-mm-dd')";
        }
        if (GGXH != null && GGXH != "")
        {
            QSentence = QSentence + " and GGXH like '%" + T.preHandleSql(GGXH) + "%'";
        }
        if (AZDD!= null && AZDD!= "")
        {
            QSentence = QSentence + " and AZDD like '%" + T.preHandleSql(AZDD) + "%'";
        }
        if (SCCJ != null && SCCJ != "")
        {
            QSentence = QSentence + " and SCCJ like '%" + T.preHandleSql(SCCJ) + "%'";
        }
        if (JDDW != null && JDDW != "")
        {
            QSentence = QSentence + " and JDDW like '%" + T.preHandleSql(JDDW) + "%'";
        }

        sqlstr = "select * from(select t.*,rownum rn from(select * from T_METER " + QSentence + ") t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + "";

        ///条件查询 end
        string sql = "select count(*) from T_METER" + QSentence;
        int Count = db.GetCount(sql);//获取总条数
        DataTable dt = db.GetDataTable(sqlstr); //数据源             
        String jsonData = ToJson(dt, Count);
        context.Response.Write(jsonData);
        context.Response.End();
    }
    #region dataTable转换成Json格式
    /// <summary>      
    /// dataTable转换成Json格式      
    /// </summary>      
    /// <param name="dt"></param>      
    /// <returns></returns>      
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
    #endregion dataTable转换成Json格式
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}