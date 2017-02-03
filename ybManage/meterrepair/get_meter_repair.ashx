<%@ WebHandler Language="C#" Class="get_meter_repair" %>

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

public class get_meter_repair : BaseHandler {
//1:待矿计量员审核
//2:待仪表室主任审核并派遣
//3:待填写维修结果
//6:等待维修单位确认
//4:结束
//5:驳回

    override public void AjaxProcess (HttpContext context) {
        int page = Convert.ToInt32(context.Request.Params["page"]);//页索引
        int rows = Convert.ToInt32(context.Request.Params["rows"]);
        DB db = new DB();
        string DM = context.Session["DM"].ToString();
        string userlevel = context.Session["userlevel"].ToString();
        string KM=context.Session["KM"].ToString();
        string username=context.Session["username"].ToString();
       
        ///条件查询 begin
        string dwKM=context.Request.Params["KM"];//发起维修请求的小队所属的矿名
        string KSRQ = context.Request.Params["KSRQ"];
        string JSRQ = context.Request.Params["JSRQ"];

        string QSentence = "";  //定义一个查询子句，当有一个或多个条件不为空时，使用该子句，此查询条件只有仪表室主任可用。

        if (dwKM != null && dwKM != "")
        {
            QSentence = QSentence + "and DW in (select dm from t_dept where km like '%"+T.preHandleSql(dwKM)+"%')";

        }        
        if (KSRQ != null && KSRQ != "")
        {
            QSentence = QSentence + "and RQ >= to_date('" + KSRQ + "','yyyy-mm-dd')";
        }
        if (JSRQ != null && JSRQ != "")
        {
            QSentence = QSentence + "and RQ <= to_date('" + JSRQ + "','yyyy-mm-dd')";
        }
        
        //if (QSentence.Substring(0, 3) == "and") QSentence = QSentence.Substring(3, QSentence.Length - 3);
        
        string sql;
        if (userlevel == "9")
              sql = "select * from T_METER_REPAIR WHERE KM='" + KM + "'";
            
        else if (userlevel == "2" && DM=="仪表室")
        {
            sql = "select * from T_METER_REPAIR";
            if (QSentence != "") sql = sql + " where " + QSentence.Substring(3, QSentence.Length - 3);
        }
        else if (userlevel == "1")
            sql = "select * from T_METER_REPAIR WHERE DW='" + DM + "'";
        else
            //一个班组内的员工只能看到分配给自己的活，无需看到其他分配给其他班组的活。
            sql = "select * from T_METER_REPAIR t,T_USER s WHERE t.WXR=s.MAJOR and s.username='" + username + "'";
        
        DataTable dt = db.GetDataTable(sql); //数据源
        DataColumn dc = new DataColumn();//新增判断流程状态列
        dc.DataType = typeof(string);
        dc.ColumnName = "workitem";
        dt.Columns.Add(dc);
        for (int i = 0; i < dt.Rows.Count; i++)//判断流程状态
        {
            if (dt.Rows[i]["STATE"].ToString() == "4")
                dt.Rows[i]["workitem"] = "通过";
            else if(dt.Rows[i]["STATE"].ToString()=="5")
                dt.Rows[i]["workitem"] = "不通过";
            else if (dt.Rows[i]["STATE"].ToString() == "1" && userlevel == "9")
                dt.Rows[i]["workitem"] = "是我";
            else if (dt.Rows[i]["STATE"].ToString() == "2" && userlevel == "2")
                dt.Rows[i]["workitem"] = "是我";
            //当前流程状态为待填写维修结果，用户为仪表室该班组的员工时处理。 
            //前面sql语句已经限定了班组信息，所以在这里不用再加限制。
            else if (dt.Rows[i]["STATE"].ToString() == "3" && userlevel == "6")
                dt.Rows[i]["workitem"] = "是我";
            //等待计量员确认，该矿的计量员是当前用户时进行处理。
            //此前的sql语句已经对矿进行限制，所以此处不用再判断是否为本矿的计量员。
            else if (dt.Rows[i]["STATE"].ToString() == "6" && userlevel == "1")
                dt.Rows[i]["workitem"] = "是我";
            else
                dt.Rows[i]["workitem"] = "等待中";
        }

        int head = 0;
        List<int> x = new List<int>();
        x.Add(0);
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (dt.Rows[i]["workitem"].ToString() == "是我")
            {
                wjz_tools.exchangeRow(dt, i, head);
                head++;
            }
        }
        x.Add(head);
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (dt.Rows[i]["workitem"].ToString() == "等待中")
            {
                wjz_tools.exchangeRow(dt, i, head);
                head++;
            }
        }
        x.Add(head);
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (dt.Rows[i]["workitem"].ToString() == "通过")
            {
                wjz_tools.exchangeRow(dt, i, head);
                head++;
            }
        }
        x.Add(head);
        x.Add(dt.Rows.Count);
        for (int i = 0; i < 4; i++)
        {
            if (x[i + 1] > x[i])
                wjz_tools.diandaoTable(dt, x[i + 1] - 1, x[i]);
        }
        DataTable dt2 = dt.Clone();
        for (int i = 0; i < dt.Rows.Count; i++)
            if ((page - 1) * rows <= i && i < page * rows)
                dt2.Rows.Add(dt.Rows[i].ItemArray);
        String jsonData = wjz_tools.ToJson(dt2, dt.Rows.Count, new List<string> { "SJ" });
        context.Response.Write(jsonData);
        context.Response.End();
    }
}