<%@ WebHandler Language="C#" Class="insert_construction1" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
///<summary> 
///模块编号：archives-07 电子档案管理子系统7号模块 借阅文档管理insert功能代码   
///作用：<向数据库中T_Construction1表中录入数据>
///作者：by wya 
///编写日期：2014-08-26  
///</summary>
public class insert_construction1 : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string json = "";
        string ARCHIVENO = context.Request.Params["ARCHIVENO"];
        string DESIGNSPECIAL = context.Request.Params["DESIGNSPECIAL"];
        string FILENUMBER = context.Request.Params["FILENUMBER"];
        string PID = context.Request.Params["PID"];
        string PNAME = context.Request.Params["PNAME"];
        string DESIGNRQ = context.Request.Params["DESIGNRQ"];
        if (DESIGNRQ.Contains("-")) //如果不为空，为日期格式，还没细判断
        {
            DESIGNRQ = Convert.ToDateTime(DESIGNRQ).ToShortDateString();
        }
        string ARCHIVERQ = context.Request.Params["ARCHIVERQ"];
        if (ARCHIVERQ.Contains("-")) //如果不为空，为日期格式，还没细判断
        {
            ARCHIVERQ = Convert.ToDateTime(ARCHIVERQ).ToShortDateString();
        }

        string PLEADER = context.Request.Params["PLEADER"];
        string REVIEWER = context.Request.Params["REVIEWER"];
        string PAGENO = context.Request.Params["PAGENO"];
        string ONEFIGURE = context.Request.Params["ONEFIGURE"];
        string ARCHIVESTATE = context.Request.Params["ARCHIVESTATE"];
        string BORROWRQ = context.Request.Params["BORROWRQ"];
        if (BORROWRQ.Contains("-")) //如果不为空，为日期格式，还没细判断
        {
            BORROWRQ = Convert.ToDateTime(ARCHIVERQ).ToShortDateString();
        }
        string BORROWER = context.Request.Params["BORROWER"];
        string RETURNRQ = context.Request.Params["RETURNRQ"];
        if (RETURNRQ.Contains("-")) //如果不为空，为日期格式，还没细判断
        {
            RETURNRQ = Convert.ToDateTime(RETURNRQ).ToShortDateString();
        }
        string RETURNER = context.Request.Params["RETURNER"];
        string BZ = context.Request.Params["BZ"];


        string ID = "0";
        DB db = new DB();
        string sql_id = "select SEQ_CONSTRUCTION1.nextval from dual";
        System.Data.DataTable dt = db.GetDataTable(sql_id);
        if (dt.Rows.Count > 0) ID = dt.Rows[0][0].ToString();
           
        string sql = "insert into T_construction1(ID,ARCHIVENO,DESIGNSPECIAL,FILENUMBER,PID,PNAME,DESIGNRQ,ARCHIVERQ,PLEADER," +
                    "REVIEWER,PAGENO,ONEFIGURE,ARCHIVESTATE,BORROWRQ,BORROWER,RETURNRQ,RETURNER,BZ) values ("+ID+",'" +
                    T.preHandleSql(ARCHIVENO) + "','" + DESIGNSPECIAL + "','" + T.preHandleSql(FILENUMBER) + "','" + T.preHandleSql(PID) + "','" + T.preHandleSql(PNAME) +
                    "'," + "to_date('" + DESIGNRQ + "','yyyy-mm-dd')," +
                    "to_date('" + ARCHIVERQ + "','yyyy-mm-dd'),'" + T.preHandleSql(PLEADER) + "','" + T.preHandleSql(REVIEWER) + "','" + PAGENO + 
                    "','" + ONEFIGURE + "','" + T.preHandleSql(ARCHIVESTATE) +
                    "'," + "to_date('" + BORROWRQ + "','yyyy-mm-dd'),'" + T.preHandleSql(BORROWER) +
                    "'," + "to_date('" + RETURNRQ + "','yyyy-mm-dd'),'" + T.preHandleSql(RETURNER) + 
                    "','" + T.preHandleSql(BZ) +"')";
        
        bool result=db.ExecuteSQL(sql);
        if (result)
        {
            Construction1 construction1 = new Construction1();
            construction1.ID = ID;
            construction1.ARCHIVENO = ARCHIVENO;
            construction1.DESIGNSPECIAL = DESIGNSPECIAL;
            construction1.FILENUMBER = FILENUMBER;
            construction1.PID = PID;
            construction1.PNAME = PNAME;
            construction1.DESIGNRQ = DESIGNRQ;
            construction1.ARCHIVERQ = ARCHIVERQ;
            construction1.PLEADER = PLEADER;
            construction1.REVIEWER = REVIEWER;
            construction1.PAGENO = PAGENO;
            construction1.ONEFIGURE = ONEFIGURE;
            construction1.ARCHIVESTATE = ARCHIVESTATE;
            construction1.BORROWRQ = BORROWRQ;
            construction1.BORROWER = BORROWER;
            construction1.RETURNRQ = RETURNRQ;
            construction1.RETURNER = RETURNER;
            construction1.BZ = BZ;
            //construction1.FILES = fileName;

            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(construction1);
            context.Response.Write(json);
            context.Response.End();
        }
        else
        {
            context.Response.Write("<script>alert('  错误!\\n添加失败！');</script>");
        }
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}