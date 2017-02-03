<%@ WebHandler Language="C#" Class="insert_oilWell" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.SessionState;
public class insert_oilWell : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string json = "";
        string DM = Convert.ToString(context.Session["dm"]);
        string KM = Convert.ToString(context.Session["km"]);
        string ZM = context.Request.Params["ZM"];
        string JLJ = context.Request.Params["JLJ"];
        string PRODUCTIONDATE = context.Request.Params["PRODUCTIONDATE"];
        string JLJJG = context.Request.Params["JLJJG"];
        string FLQXH = context.Request.Params["FLQXH"];
        string WELLTYPE = context.Request.Params["WELLTYPE"];
        string KT = context.Request.Params["KT"];
        string WNUMBER = context.Request.Params["WNUMBER"];
        string JYGXGG1 = context.Request.Params["JYGXGG1"];
        string JYGXGG2 = context.Request.Params["JYGXGG2"];
        string JYGXGG="";
        if(JYGXGG1!=""||JYGXGG2!="")
            JYGXGG = "Ф" + JYGXGG1 + "×" + JYGXGG2;
        string JYGXLENGTH = context.Request.Params["JYGXLENGTH"];
        string CSGXGG1 = context.Request.Params["CSGXGG1"];
        string CSGXGG2 = context.Request.Params["CSGXGG2"];
        string CSGXGG = "";
        if (CSGXGG1 != "" || CSGXGG2 != "")
            CSGXGG ="Ф" + CSGXGG1 + "×" + CSGXGG2;
        string CSGXLENGTH = context.Request.Params["CSGXLENGTH"];
        string GJJH = context.Request.Params["GJJH"];
        string TCRQ = context.Request.Params["TCRQ"];
        string BZ = context.Request.Params["BZ"];

        string ID = "0";
        DB db = new DB();
        string sql_id = "select SEQ_oilWell.nextval from dual";
        System.Data.DataTable dt = db.GetDataTable(sql_id);
        if (dt.Rows.Count > 0) ID = dt.Rows[0][0].ToString(); 

        string sql = "insert into T_oilWell(ID,KM,DM,ZM,JLJ,PRODUCTIONDATE,JLJJG,FLQXH,WELLTYPE,KT,WNUMBER,JYGXGG,JYGXLENGTH,CSGXGG,CSGXLENGTH,GJJH,TCRQ,BZ) values ("+ID+",'" +
                     KM + "','" + DM + "','" + T.preHandleSql(ZM) + "','" + T.preHandleSql(JLJ) + "', to_date('" + PRODUCTIONDATE + "','yyyy-mm-dd'),'" + T.preHandleSql(JLJJG) + "','" + T.preHandleSql(FLQXH) + "','" + T.preHandleSql(WELLTYPE) + "','" +
                     T.preHandleSql(KT) + "','" + T.preHandleSql(WNUMBER) + "','" + T.preHandleSql(JYGXGG) + "','" + T.preHandleSql(JYGXLENGTH) + "','" + T.preHandleSql(CSGXGG) + "','" + T.preHandleSql(CSGXLENGTH) + "','" + T.preHandleSql(GJJH) + "', to_date('" + TCRQ + "','yyyy-mm-dd'),'" + T.preHandleSql(BZ) + "')"; //高俊涛修改 2014-09-07 把文件名filename存入数据库
        bool result = db.ExecuteSQL(sql);
        if (result)
        {
            oilWell oilwell = new oilWell();
            oilwell.ID = ID;
            oilwell.KM = KM;
            oilwell.DM = DM;
            oilwell.ZM = ZM;
            oilwell.JLJ = JLJ;
            oilwell.PRODUCTIONDATE = T.ChangeDate(PRODUCTIONDATE);
            oilwell.JLJJG = JLJJG;
            oilwell.FLQXH = FLQXH;
            oilwell.WELLTYPE = WELLTYPE;
            oilwell.KT = KT;
            oilwell.WNUMBER = WNUMBER;
            oilwell.JYGXGG = JYGXGG;
            oilwell.JYGXLENGTH = JYGXLENGTH;
            oilwell.CSGXGG = CSGXGG;
            oilwell.CSGXLENGTH = CSGXLENGTH;
            oilwell.TCRQ = T.ChangeDate(TCRQ);
            oilwell.GJJH = GJJH;
            oilwell.BZ = BZ;
            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(oilwell);
            context.Response.Write(json);
            context.Response.End();
        }
        else
        {
            context.Response.Write("<script>alert('  错误!\\n添加失败！')</script>");
        }

    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}