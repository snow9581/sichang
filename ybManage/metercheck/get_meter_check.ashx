<%@ WebHandler Language="C#" Class="get_Instrument" %>
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
//获取外送仪表检定流程列表。此程序负责判断流程状态。
public class get_Instrument : BaseHandler
{
    //1：等待审核人审核
    //2：等待审批人审批
    //3：等待管理科同意
    //4：等待填写确认单
    //5：完成
    //6：因不某环节不通过而中止
    override public void AjaxProcess(HttpContext context)
    {
        int page = Convert.ToInt32(context.Request.Params["page"]);//页索引
        int rows = Convert.ToInt32(context.Request.Params["rows"]);
        string BM = context.Request.Params["BM"];//查询条件
        DB db = new DB();
        string KM = context.Session["KM"].ToString();
        string userlevel = context.Session["userlevel"].ToString();
        string username = context.Session["username"].ToString();
        
        string sql;
        if (userlevel == "0")//admin可看到所有数据
            sql = "select * from T_METER_CHECK where 1=1";
        else//其他人看到自己部分的数据
            sql = "select * from T_METER_CHECK where Department='" + KM + "'";
        if (!(BM == "" || BM == null || BM == "0"))//查询条件
            sql += " and BM='第四采油厂" + BM + "月份外送仪表检定申请表'";
        
        DataTable dt = db.GetDataTable(sql); //数据源
        DataColumn dc = new DataColumn();//新增判断流程状态列
        dc.DataType = typeof(string);
        dc.ColumnName = "workitem";
        dt.Columns.Add(dc);
        for (int i = 0; i < dt.Rows.Count; i++)//判断流程状态
        {
            if (dt.Rows[i]["STATE"].ToString() == "5")
                dt.Rows[i]["workitem"] = "通过";
            else if (dt.Rows[i]["STATE"].ToString() == "6")
                dt.Rows[i]["workitem"] = "不通过";
            else if (userlevel == "2" && dt.Rows[i]["STATE"].ToString() == "1")
                dt.Rows[i]["workitem"] = "是我";
            else if (userlevel == "4" && dt.Rows[i]["STATE"].ToString() == "2")
                dt.Rows[i]["workitem"] = "是我";
            else if (userlevel == "1" && dt.Rows[i]["STATE"].ToString() == "4")
                dt.Rows[i]["workitem"] = "是我";
            else if (userlevel == "0" && dt.Rows[i]["STATE"].ToString() == "1" && dt.Rows[i]["DEPARTMENT"].ToString() != "规划所")
                dt.Rows[i]["workitem"] = "是我";
            else if (userlevel == "0" && dt.Rows[i]["STATE"].ToString() == "2" && dt.Rows[i]["DEPARTMENT"].ToString() != "规划所")
                dt.Rows[i]["workitem"] = "是我";
            else if (userlevel == "0" && dt.Rows[i]["STATE"].ToString() == "3" )
                dt.Rows[i]["workitem"] = "是我";
            else if (userlevel == "6" && dt.Rows[i]["STATE"].ToString() == "3" && dt.Rows[i]["INITIATOR"].ToString()==username)
                dt.Rows[i]["workitem"] = "是我";
            else if (userlevel == "6" && dt.Rows[i]["STATE"].ToString() == "4" && dt.Rows[i]["INITIATOR"].ToString() == username)
                dt.Rows[i]["workitem"] = "是我";
            else
                dt.Rows[i]["workitem"] = "等待中";
        }

        int head = 0;
        List<int> x = new List<int>();
        x.Add(0);
        for (int i = 0; i <dt.Rows.Count ; i++)
        {
            if (dt.Rows[i]["workitem"].ToString() == "是我")
            {
                wjz_tools.exchangeRow(dt, i, head);
                head++;
            }
        }
        x.Add(head);
        for (int i = 0; i < dt.Rows.Count ; i++)
        {
            if (dt.Rows[i]["workitem"].ToString() == "等待中")
            {
                wjz_tools.exchangeRow(dt, i, head);
                head++;
            }
        }
        x.Add(head);
        for (int i = 0; i < dt.Rows.Count ; i++)
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
            if (x[i + 1] >  x[i])
                wjz_tools.diandaoTable(dt, x[i + 1] - 1, x[i]);
        }
        DataTable dt2 = dt.Clone();
        for (int i = 0; i < dt.Rows.Count; i++)
            if ((page - 1) * rows <= i && i < page * rows)
                dt2.Rows.Add(dt.Rows[i].ItemArray);
        String jsonData = wjz_tools.ToJson(dt2, dt.Rows.Count, new List<string> { "TIME" });
        context.Response.Write(jsonData);
        context.Response.End();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }
}