﻿<%@ WebHandler Language="C#" Class="get_event" %>
///<summary> 
///模块编号：archives-07 电子档案管理子系统7号模块 施工图文档借阅表 GET功能代码   
///作用：获取数据，转换日期字段，对部分字段排序
///作者：by wya 
///编写日期：2014-09-19  
///</summary>
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;

public class get_event : BaseHandler {
    
    public override void AjaxProcess (HttpContext context) {
        int page = Convert.ToInt32(context.Request.Params["page"]);//页索引
        int rows = Convert.ToInt32(context.Request.Params["rows"]);
        DB db = new DB();
        string sqlstr = "select * from(select t.*,rownum rn from(select * from T_construction1 ) t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + "";
        ///条件查询 begin
        //string KWORDS = context.Request.Params["KWORDS"];//以关键字为查询项
        string PID = context.Request.Params["PID"];
        string PNAME = context.Request.Params["PNAME"];
        string KSRQ = context.Request.Params["KSRQ"];
        string JSRQ = context.Request.Params["JSRQ"];
        string QSentence = " where 1=1 ";  //定义一个查询子句，当有一个或多个条件不为空时，使用该子句
        if (PID != null || PNAME != null || KSRQ != null|| JSRQ != null)
        {
            if (PID != "")
            {
                QSentence = QSentence + " and PID like '%" + T.preHandleSql(PID) + "%'";
            }
            if (PNAME != "")
            {
                QSentence = QSentence + " and PNAME like '%" + T.preHandleSql(PNAME) + "%'";
            }
            if (KSRQ != "")
            {
                QSentence = QSentence + " and BORROWRQ >= to_date('" + KSRQ + "','yyyy-mm-dd')";
            }
            if (JSRQ != "")
            {
                QSentence = QSentence + " and BORROWRQ <= to_date('" + JSRQ + "','yyyy-mm-dd')";
            }
            sqlstr = "select * from(select t.*,rownum rn from(select * from T_construction1 " + QSentence + ") t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + "";
        }
        ///条件查询 end
        string sql = "select count(*) from T_construction1" + QSentence;
        int Count = db.GetCount(sql);//获取总条数
        DataTable dt = db.GetDataTable(sqlstr); //数据源             
        String jsonData = T.ToJson(dt, Count);
        context.Response.Write(jsonData);
        context.Response.End(); 
        
        
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}