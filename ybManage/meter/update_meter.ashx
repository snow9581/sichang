<%@ WebHandler Language="C#" Class="update_meter" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public class update_meter : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string json = "";
        string ID = context.Request.QueryString["ID"];
        string YBFL = context.Request.Params["YBFL"];
        string YBMC = context.Request.Params["YBMC"];
        string KM = context.Session["km"].ToString();
        string DM = context.Session["dm"].ToString();
        string AZDD = context.Request.Params["AZDD"];
        string GGXH  = context.Request.Params["GGXH"];
        string SCCJ  = context.Request.Params["SCCJ"];
        string CCBH  = context.Request.Params["CCBH"];
        string CCRQ  = context.Request.Params["CCRQ"];
        string ZQDDJ = context.Request.Params["ZQDDJ"];
        string LC    = context.Request.Params["LC"];
        string JDZQ  = context.Request.Params["JDZQ"];
        string JDDW  = context.Request.Params["JDDW"];
        string JDRQ  = context.Request.Params["JDRQ"];
        string JDJG  = context.Request.Params["JDJG"];
        if (JDJG == null)
        { JDJG = ""; }
        string GLZT  = context.Request.Params["GLZT"];
        string SFWS  = context.Request.Params["SFWS"];
        if (SFWS == null)
        { SFWS = ""; }
        string BZ   = context.Request.Params["BZ"];
        DB db = new DB();
        if (JDZQ != "")
        {
            string s = "update T_METER set JDZQ=" + JDZQ + " where ID='" + ID + "'";
            db.ExecuteSQL(s);

        }
        string sql = "update T_METER set YBFL='"+ T.preHandleSql(YBFL)+ "',YBMC='"+T.preHandleSql(YBMC)+"',AZDD='"+ AZDD +"',GGXH='"+ GGXH + "', SCCJ='"+ T.preHandleSql(SCCJ)+"',CCBH='" + T.preHandleSql(CCBH) + "',CCRQ=to_date('" + CCRQ + "','yyyy-mm-dd'),ZQDDJ='" + T.preHandleSql(ZQDDJ) + "',LC='" + T.preHandleSql(LC) +
            "',JDDW='" + T.preHandleSql(JDDW) + "',JDRQ =to_date('" + JDRQ + "','yyyy-mm-dd'),JDJG='" + T.preHandleSql(JDJG) +
           "',GLZT='"+T.preHandleSql(GLZT)+"',SFWS='"+T.preHandleSql(SFWS)+"',BZ='"+T.preHandleSql(BZ)+"' where ID='"+ ID + "'";//高俊涛修改 2014-09-07 把文件名filename存入数据库
        bool result=db.ExecuteSQL(sql);
        if (result)
        {
            meter meter = new meter();
            meter.ID = ID;
            meter.YBFL = YBFL;
            meter.YBMC = YBMC;
            meter.KM = KM;
            meter.DM = DM;
            meter.AZDD = AZDD;
            meter.GGXH = GGXH;
            meter.SCCJ = SCCJ;
            meter.CCBH = CCBH;
            meter.CCRQ = CCRQ;
            meter.ZQDDJ = ZQDDJ;
            meter.LC = LC;
            meter.JDZQ = JDZQ;
            meter.JDDW = JDDW;
            meter.JDRQ = JDRQ;
            meter.JDJG = JDJG;
            meter.GLZT = GLZT;
            meter.SFWS= SFWS;
            meter.BZ=BZ;
            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(meter);
            context.Response.Write(json);
            context.Response.End();
        }
        else
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write("<script>alert('  错误!\\n更新失败！');</script>");
        }

    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}