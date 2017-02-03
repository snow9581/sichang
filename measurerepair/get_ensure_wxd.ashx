<%@ WebHandler Language="C#" Class="get_ensure_wxd" %>

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

public class get_ensure_wxd : BaseHandler {
    
    override public void AjaxProcess (HttpContext context) {
        string ID = context.Request.Params["ID"].ToString();
        DB db = new DB();
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
        NewRows.ItemArray = new object[] { "故障申请单", "", "", "", "", "" };
        dt.Rows.Add(NewRows);
        if (ID[0] != 's'&&ID[0]!='d')
        {
            DataTable dt2 = db.GetDataTable("select * from T_measure where ID=" + ID);
            DataRow NewRows1 = dt.NewRow();
            NewRows1.ItemArray = new object[] { "单位", context.Session["DM"].ToString(), "CPU型号",  dt2.Rows[0]["CPUXH"].ToString(), "安装岗位", dt2.Rows[0]["GW"].ToString() };
            dt.Rows.Add(NewRows1);
            DataRow NewRows2 = dt.NewRow();
            NewRows2.ItemArray = new object[] { "系统类型", dt2.Rows[0]["XTLX"].ToString(), "日期", "" };
            dt.Rows.Add(NewRows2);
            DataRow NewRows3 = dt.NewRow();
            NewRows3.ItemArray = new object[] { "故障现象", "", "", "", "", "" };
            dt.Rows.Add(NewRows3);
        }
        else
        {
            ID = ID.Substring(1, ID.Length - 1);
            DataTable dt3 = db.GetDataTable("select * from T_measure_REPAIR where ID=" + ID);
            DataRow NewRows1 = dt.NewRow();
            NewRows1.ItemArray = new object[] { "单位", dt3.Rows[0]["DW"].ToString(), "CPU型号", dt3.Rows[0]["CPUXH"].ToString(), "安装岗位", dt3.Rows[0]["GW"].ToString() };
            dt.Rows.Add(NewRows1);
            DataRow NewRows2 = dt.NewRow();
            string sRQ = dt3.Rows[0]["RQ"].ToString();

            if (sRQ.IndexOf(" ")>0) sRQ = sRQ.Substring(0, sRQ.IndexOf(" "));
            
            NewRows2.ItemArray = new object[] { "系统类型", dt3.Rows[0]["XTLX"].ToString(), "日期", sRQ };
            dt.Rows.Add(NewRows2);
            DataRow NewRows3 = dt.NewRow();
            NewRows3.ItemArray = new object[] { "故障现象", dt3.Rows[0]["GZXX"].ToString(), "", "", "", "" };
            dt.Rows.Add(NewRows3);
        }
        context.Response.Write(wjz_tools.ToJson(dt, 3, new List<string>() { }));
        context.Response.End();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}