<%@ WebHandler Language="C#" Class="update_construction1" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public class update_construction1 : BaseHandler {

    public override void AjaxProcess(HttpContext context)
    {

        string json = "";
        string ID = context.Request.Params["ID"];
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
       
        DB db = new DB();
        string sql = "update T_construction1 set ARCHIVENO='" + T.preHandleSql(ARCHIVENO) + "',DESIGNSPECIAL='" + DESIGNSPECIAL +
                      "',FILENUMBER='" + T.preHandleSql(FILENUMBER) + "',PID='" + T.preHandleSql(PID) + "',PNAME='" + T.preHandleSql(PNAME) +
                      "',DESIGNRQ= to_date('" + DESIGNRQ + "','yyyy-mm-dd'),ARCHIVERQ= to_date('" + ARCHIVERQ + "','yyyy-mm-dd'),PLEADER='" + T.preHandleSql(PLEADER) +
                      "',REVIEWER='" + T.preHandleSql(REVIEWER) + "',PAGENO='" + PAGENO + "',ONEFIGURE='" + ONEFIGURE +
                      "',ARCHIVESTATE='" + T.preHandleSql(ARCHIVESTATE) + 
                      "',BORROWRQ= to_date('" + BORROWRQ + "','yyyy-mm-dd'),BORROWER='" + T.preHandleSql(BORROWER) +
                      "',RETURNRQ= to_date('" + RETURNRQ + "','yyyy-mm-dd'),RETURNER='" + T.preHandleSql(RETURNER) + 
                      "',BZ='" + T.preHandleSql(BZ) + "'where id='" + T.preHandleSql(ID) + "'";//高俊涛修改 2014-09-07 把文件名filename存入数据库


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
           context.Response.Write("<script>alert('  错误!\\n更新失败！');</script>");
       }
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}