<%@ WebHandler Language="C#" Class="insert_meter" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.SessionState;

public class insert_meter : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string json = "";
        string ID = context.Request.QueryString["ID"];
        string DM = Convert.ToString(context.Session["dm"]);
        string KM = Convert.ToString(context.Session["km"]);
        string YBFL = context.Request.Params["YBFL"];
        string YBMC = context.Request.Params["YBMC"];
        //string DM = "";
        //string KM = "";
        string AZDD = context.Request.Params["AZDD"];
        string GGXH = context.Request.Params["GGXH"];
        string SCCJ = context.Request.Params["SCCJ"];
        string CCBH = context.Request.Params["CCBH"];
        string CCRQ = context.Request.Params["CCRQ"];
        if (CCRQ.Contains("-"))
        {
            CCRQ = Convert.ToDateTime(context.Request.Params["CCRQ"]).ToShortDateString();
        }
        string ZQDDJ = context.Request.Params["ZQDDJ"];
        string LC = context.Request.Params["LC"];
        string JDZQ = context.Request.Params["JDZQ"];
        string JDDW = context.Request.Params["JDDW"];
        string JDRQ = context.Request.Params["JDRQ"];
        if (JDRQ.Contains("-")) //如果不为空，为日期格式，还没细判断
        {
            JDRQ = Convert.ToDateTime(context.Request.Params["JDRQ"]).ToShortDateString();
        }
        string JDJG = context.Request.Params["JDJG"];
        if (JDJG == null)
        {
            JDJG = "";
        }
        string GLZT = context.Request.Params["GLZT"];
        string SFWS = context.Request.Params["SFWS"];
        if(SFWS==null)
       {
            SFWS = "";
        }
        string BZ   = context.Request.Params["BZ"];
        DB db = new DB();
        //DB db = new DB();
        //string sql_id = "select SEQ_REPAIR.nextval from dual";
        //System.Data.DataTable dt = db.GetDataTable(sql_id);
        //if (dt.Rows.Count > 0) ID = dt.Rows[0][0].ToString();
        string sql_id = "select SEQ_METER.nextval from dual";
        System.Data.DataTable dt = db.GetDataTable(sql_id);
        if (dt.Rows.Count > 0) ID = dt.Rows[0][0].ToString();
        string sql = "insert into T_METER(ID,YBFL,YBMC,KM,DM,AZDD,GGXH,SCCJ,CCBH,CCRQ," +
                     "ZQDDJ,LC,JDZQ,JDDW,JDRQ,JDJG,GLZT,SFWS,BZ) values ('" + ID + "','" + T.preHandleSql(YBFL) + "','" + T.preHandleSql(YBMC) + "','" +
                     KM + "','" + DM + "','" + T.preHandleSql(AZDD) + "','" + T.preHandleSql(GGXH) +  "','" +SCCJ + "','" +
                     CCBH + "',to_date('" + CCRQ + "','yyyy-mm-dd'),'" + T.preHandleSql(ZQDDJ) + "','" + LC + "','" + JDZQ +"','" + T.preHandleSql(JDDW) + "', to_date('" + JDRQ + "','yyyy-mm-dd'),'"
                     + T.preHandleSql(JDJG) + "','" + T.preHandleSql(GLZT) + "','" + T.preHandleSql(SFWS) + "','" + T.preHandleSql(BZ) + "')";
        bool result = db.ExecuteSQL(sql);
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
            meter.JDDW= JDDW;
            meter.JDRQ = JDRQ;
            meter.JDJG = JDJG;
            meter.GLZT = GLZT;
            meter.SFWS = SFWS;
            meter.BZ = BZ;
            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(meter);
            context.Response.Write(json);
            context.Response.End();
        }
        else
        {
            context.Response.ContentType = "text/html";
            context.Response.Write("<script>alert('  错误!\\n添加失败！');</script>");
        }
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}