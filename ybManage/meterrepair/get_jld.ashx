<%@ WebHandler Language="C#" Class="get_jld" %>

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
public class get_jld : BaseHandler {
    
    override public void AjaxProcess (HttpContext context) {
        DB db = new DB();
        DataTable dt2 = db.GetDataTable("select * from T_METER_REPAIR where ID=" + context.Request.Params["ID"].ToString());
        DataTable dt = new DataTable();
        DataColumn dc1 = new DataColumn();
        dc1.DataType = typeof(string);
        dc1.ColumnName = "f1";
        dt.Columns.Add(dc1);
        DataColumn dc2 = new DataColumn();
        dc2.DataType = typeof(string);
        dc2.ColumnName = "f2";
        dt.Columns.Add(dc2);
        DataColumn dc3 = new DataColumn();
        dc3.DataType = typeof(string);
        dc3.ColumnName = "f3";
        dt.Columns.Add(dc3);
        DataColumn dc4 = new DataColumn();
        dc4.DataType = typeof(string);
        dc4.ColumnName = "f4";
        dt.Columns.Add(dc4);
        DataColumn dc5 = new DataColumn();
        dc5.DataType = typeof(string);
        dc5.ColumnName = "f5";
        dt.Columns.Add(dc5);
        DataColumn dc6 = new DataColumn();
        dc6.DataType = typeof(string);
        dc6.ColumnName = "f6";
        dt.Columns.Add(dc6);
        DataRow NewRows = dt.NewRow();
        NewRows.ItemArray = new object[] { "仪器仪表维修记录单", "", "", "", "", "" };
        dt.Rows.Add(NewRows);
        DataRow NewRows1 = dt.NewRow();
        NewRows1.ItemArray = new object[] { "单位", dt2.Rows[0]["DW"].ToString(),"仪器仪表名称", dt2.Rows[0]["YQYBMC"].ToString() , "安装位置", dt2.Rows[0]["AZWZ"].ToString() };
        dt.Rows.Add(NewRows1);
        DataRow NewRows2 = dt.NewRow();
        
        string sRQ = dt2.Rows[0]["RQ"].ToString();
        sRQ = sRQ.Substring(0, sRQ.IndexOf(" "));
        
        NewRows2.ItemArray = new object[] { "规格型号", dt2.Rows[0]["GGXH"].ToString(), "日期", sRQ };
        dt.Rows.Add(NewRows2);
        DataRow NewRows3 = dt.NewRow();
        NewRows3.ItemArray = new object[] { "故障现象", dt2.Rows[0]["GZXX"].ToString(), "", "", "", "" };
        dt.Rows.Add(NewRows3);
        DataRow NewRows4 = dt.NewRow();
        NewRows4.ItemArray = new object[] { "维修单位", dt2.Rows[0]["WXDW"].ToString(), "维修人", dt2.Rows[0]["WXRQZ"].ToString(), "生产单位", dt2.Rows[0]["DW"].ToString() };
        dt.Rows.Add(NewRows4);
        DataRow NewRows5 = dt.NewRow();
        NewRows5.ItemArray = new object[] { "维修内容", dt2.Rows[0]["WXNR"].ToString(), "", "", "", "" };
        dt.Rows.Add(NewRows5);
        DataRow NewRows6 = dt.NewRow();
        NewRows6.ItemArray = new object[] { "配件应用情况", dt2.Rows[0]["PJYYQK"].ToString(), "", "", "", "" };
        dt.Rows.Add(NewRows6);
        DataRow NewRows7 = dt.NewRow();
        NewRows7.ItemArray = new object[] { "维修结果", dt2.Rows[0]["WXJG"].ToString(), "", "", "", "" };
        dt.Rows.Add(NewRows7);
        context.Response.Write(wjz_tools.ToJson(dt, 8, new List<string>(){ }));
        context.Response.End();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}