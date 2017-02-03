<%@ WebHandler Language="C#" Class="get_measure" %>

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

public class get_measure : BaseHandler {

     public override void AjaxProcess(HttpContext context)
    {
        int page = Convert.ToInt32(context.Request.Params["page"]);//页索引
        int rows = Convert.ToInt32(context.Request.Params["rows"]);
        string km = Convert.ToString(context.Session["km"]);
       string dm = Convert.ToString(context.Session["dm"]);
       string userlevel = Convert.ToString(context.Session["userlevel"]);

        DB db = new DB();
        string sqlstr = "select * from(select t.*,rownum rn from(select * from T_MEASURE ) t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + "";
        ///条件查询 begin
        string KM = context.Request.Params["KM"];
        string DM = context.Request.Params["DM"];
        string GW = context.Request.Params["GW"];
        string ZB = context.Request.Params["ZB"];
        string ZM = context.Request.Params["ZM"];
        string XTBM = context.Request.Params["XTMB"];
        string RJKFCJ = context.Request.Params["RJKFCJ"];
        string TYSJ = context.Request.Params["TYSJ"];
        string SWRJPTMC = context.Request.Params["SWRJPTMC"];
        string XWJMKCJMC = context.Request.Params["XWJMKCJMC"];
        string SWJPZ = context.Request.Params["SWJPZ"];
        string XTLX = context.Request.Params["XTLX"];
        string CPUXH = context.Request.Params["CPUXH"];
        string CPUSL = context.Request.Params["CPUSL"];
        string AIXH = context.Request.Params["AIXH"];
        string AISL = context.Request.Params["AISL"];
        string AOXH = context.Request.Params["AOXH"];
        string AOSL = context.Request.Params["AOSL"];
        string DIXH = context.Request.Params["DIXH"];
        string DISL = context.Request.Params["DISL"];
        string DOXH = context.Request.Params["DOXH"];
        string DOSL = context.Request.Params["DOSL"];
        string DYXH = context.Request.Params["DYXH"];
        string DYSL = context.Request.Params["DYSL"];
        string QTMKXH = context.Request.Params["QTMKXH"];
        string QTMKSL = context.Request.Params["QTMKSL"];
        string AQSXH = context.Request.Params["AQSXH"];
        string AQSSL = context.Request.Params["AQSSL"];
        string PDQXH = context.Request.Params["PDQXH"];
        string PDQSL = context.Request.Params["PDQSL"];
        string JDQXH = context.Request.Params["JDQXH"];
        string JDQSL = context.Request.Params["JDQSL"];
        string QTXH = context.Request.Params["QTXH"];
        string QTSL = context.Request.Params["QTSL"];
        string XTZK = context.Request.Params["XTZK"];
        string SWJYCXCCLJ = context.Request.Params["SWJYCXCCLJ"];
        string XWJYCXCCLJ = context.Request.Params["XWJYCXCCLJ"];
        string TXFS = context.Request.Params["TXFS"];
        string BZ = context.Request.Params["BZ"];
        string QSentence = " where 1=1 ";  //定义一个查询子句，当有一个或多个条件不为空时，使用该子句

     
        ///查询者等级的确定  
        if (km != "" && (userlevel == "3" || userlevel == "5"))//地面队长或地面矿长
        {
            QSentence = QSentence + "and km='" + km + "'";
        }
        else if (KM != null && KM != "")
        {
            QSentence = QSentence + " and KM like '%" + T.preHandleSql(KM) + "%'";
        }
         
        if (dm != "" && userlevel == "1")//小队
        {
            QSentence = QSentence + " and dm='" + dm + "'";
        }
        else if (DM != null && DM != "")
        {
            QSentence = QSentence + " and DM like '%" + T.preHandleSql(DM) + "%'";
        }
        else if (dm == "仪表室" && (KM == "" || KM == null))
        {
            QSentence += " and DM like '%仪表室%'";
        }
         
        if (RJKFCJ!=null&&RJKFCJ !="")
        {
            QSentence = QSentence + "and RJKFCJ like '%" + T.preHandleSql(RJKFCJ)+"%'";
        }
        sqlstr = "select * from(select t.*,rownum rn from(select * from T_MEASURE " + QSentence + ") t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + "";

        string sql = "select count(*) from T_MEASURE" + QSentence;
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
                if (tempColname == "TYRQ" )
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