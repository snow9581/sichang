<%@ WebHandler Language="C#" Class="insert_measure" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.SessionState;

public class insert_measure: BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string json = "";
        string ID = context.Request.QueryString["ID"];
        string KM = Convert.ToString(context.Session["km"]);
        if (KM == null||KM=="")
        {
            KM = "";
        }
        string DM = Convert.ToString(context.Session["dm"]);
        if (DM == null||DM=="")
        {
            DM = "";
        }
        string GW = context.Request.Params["GW"];
        string ZB = context.Request.Params["ZB"];
        string ZM = context.Request.Params["ZM"];
        string XTBM = context.Request.Params["XTBM"];
        //string DM = context.Session["dm"].ToString();


        string RJKFCJ = context.Request.Params["RJKFCJ"];
        string TYSJ = context.Request.Params["TYSJ"];
        if (TYSJ.Contains("-"))
        {
            TYSJ  = Convert.ToDateTime(context.Request.Params["TYSJ"]).ToShortDateString();
        }
        string SWRJPTMC = context.Request.Params["SWRJPTMC"];
        if (SWRJPTMC==null)
        {
            SWRJPTMC = "";
        }
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
        DB db = new DB();

        //DB db = new DB();
        //string sql_id = "select SEQ_REPAIR.nextval from dual";
        //System.Data.DataTable dt = db.GetDataTable(sql_id);
        //if (dt.Rows.Count > 0) ID = dt.Rows[0][0].ToString();
        //     string ID = "0";
        string sql_id = "select SEQ_MEASURE.nextval from dual";
        System.Data.DataTable dt = db.GetDataTable(sql_id);
        if (dt.Rows.Count > 0) ID = dt.Rows[0][0].ToString();
        string sql = "insert into T_MEASURE(ID,KM,DM,GW,ZB,ZM,XTBM,RJKFCJ,TYSJ,SWRJPTMC,XWJMKCJMC,SWJPZ,XTLX,CPUXH,CPUSL,AIXH,AISL,AOXH,AOSL,DIXH,DISL,DOXH,DOSL,DYXH," +
                     "DYSL,QTMKXH,QTMKSL,AQSXH,AQSSL,PDQXH,PDQSL,JDQXH,JDQSL,QTXH,QTSL,XTZK,SWJYCXCCLJ,XWJYCXCCLJ,TXFS,BZ) values ('" + ID +"','"+KM+ "','"+DM+"','" + GW +"' ,'"+ZB+"','"+ZM+"','"+XTBM+"','" + T.preHandleSql(RJKFCJ) +
                     "',to_date('" + TYSJ + "','yyyy-mm-dd'),'" + SWRJPTMC + "','" + T.preHandleSql(XWJMKCJMC) + "','" + T.preHandleSql(SWJPZ) +  "','" +XTLX + "','" +
                     CPUXH + "','"+CPUSL+"','"+ AIXH + "','" + AISL + "','" + AOXH +"','" + AOSL +
                  "','"   + DIXH + "','" +DISL + "','" + DOXH + "','"+ DOSL +"','"+ DYXH +"','" + DYSL +
                  "','"   + QTMKXH + "','" + QTMKSL + "','" +AQSXH + "','"+ AQSSL+
                  "','"   +PDQXH + "','" + PDQSL + "','" + JDQXH + "','"+ JDQSL + "','" + QTXH + "','" +QTSL + "','"+ XTZK +
                  "','"   + SWJYCXCCLJ + "','" + XWJYCXCCLJ + "','" + T.preHandleSql(TXFS) + "','"+ T.preHandleSql(BZ) + "')";
        bool result = db.ExecuteSQL(sql);
        if (result)
        {
            MEASURE measure = new MEASURE();
            measure.ID = ID;
            measure.KM = KM;
            measure.DM = DM;
            measure.GW = GW;
            measure.ZB = ZB;
            measure.ZM = ZM;
            measure.XTBM = XTBM;
            measure.RJKFCJ = RJKFCJ;
            measure.TYSJ = TYSJ;
            measure.SWRJPTMC = SWRJPTMC;
            measure.XWJMKCJMC = XWJMKCJMC;
            measure.SWJPZ = SWJPZ;
            measure.XTLX = XTLX;
            measure.CPUXH = CPUXH;
            measure.CPUSL = CPUSL;
            measure.AIXH = AIXH;
            measure.AISL = AISL;
            measure.AOXH = AOXH;
            measure.AOSL= AOSL;
            measure.DIXH = DIXH;
            measure.DISL = DISL;
            measure.DOXH = DOXH;
            measure.DOSL = DOSL;
            measure.DYXH = DYXH;
            measure.DYSL = DYSL;
            measure.QTMKXH = QTMKXH;
            measure.QTMKSL = QTMKSL;
            measure.AQSXH = AQSXH;
            measure.AQSSL = AQSSL;
            measure.PDQXH = PDQXH;
            measure.PDQSL = PDQSL;
            measure.JDQXH = JDQXH;
            measure.JDQSL = JDQSL;
            measure.QTXH = QTXH;
            measure.QTSL = QTSL;
            measure.XTZK= XTZK;
            measure.SWJYCXCCLJ = SWJYCXCCLJ;
            measure.XWJYCXCCLJ = XWJYCXCCLJ;
            measure.XWJYCXCCLJ = XWJYCXCCLJ;
            measure.BZ = BZ;
            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(measure);
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