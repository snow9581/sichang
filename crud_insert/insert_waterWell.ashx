<%@ WebHandler Language="C#" Class="insert_waterWell" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.SessionState;

public class insert_waterWell : BaseHandler
{

    public override void AjaxProcess(HttpContext context)
    {
        string json = "";

        string DM = Convert.ToString(context.Session["dm"]);
        string KM = Convert.ToString(context.Session["km"]);
        string ZM = context.Request.Params["ZM"];
        string ZSZMC = context.Request.Params["ZSZMC"];
        string WNUMBER = context.Request.Params["WNUMBER"];
        string TCRQ = context.Request.Params["TCRQ"];
        string GXGG1 = context.Request.Params["GXGG1"];
        string GXGG2 = context.Request.Params["GXGG2"];
        string GXGG="";
        if (GXGG1 != "" || GXGG2 != "")
             GXGG = "Ф" + GXGG1 + "×" + GXGG2;
        string LENGTH = context.Request.Params["LENGTH"];
        string PSJMC = context.Request.Params["PSJMC"];
        string GXMC = context.Request.Params["GXMC"];
        string LANDTYPE = context.Request.Params["LANDTYPE"];
        string GBF = context.Request.Params["GBF"];
        string GBFFORMAT = context.Request.Params["GBFFORMAT"];
        string BZ = context.Request.Params["BZ"];
        string ID = "0";
        DB db = new DB();
        string sql_id = "select SEQ_waterWell.nextval from dual";
        System.Data.DataTable dt = db.GetDataTable(sql_id);
        if (dt.Rows.Count > 0) ID = dt.Rows[0][0].ToString(); 
        string sql = "insert into T_waterWell(ID,KM,DM,ZM,ZSZMC,WNUMBER,TCRQ,GXGG,LENGTH,PSJMC,GXMC,LANDTYPE,GBF,GBFFORMAT,BZ) values ("+ID+",'" +
                     KM + "','" + DM + "','" + T.preHandleSql(ZM) + "','" + T.preHandleSql(ZSZMC) + "','" + T.preHandleSql(WNUMBER) + "', to_date('" + TCRQ + "','yyyy-mm-dd'),'"  + T.preHandleSql(GXGG) + "','" + LENGTH + "','" + T.preHandleSql(PSJMC) + "','" +
                     T.preHandleSql(GXMC) + "','" + T.preHandleSql(LANDTYPE) + "','" + T.preHandleSql(GBF) + "','" + T.preHandleSql(GBFFORMAT) + "','" + T.preHandleSql(BZ) + "')"; //高俊涛修改 2014-09-07 把文件名filename存入数据库
        bool result = db.ExecuteSQL(sql);
        if (result)
        {
            waterWell waterwell = new waterWell();
            waterwell.ID = ID;    //新建后再刷新，能够获取到ID
            waterwell.KM = KM;
            waterwell.DM = DM;
            waterwell.ZM = ZM;
            waterwell.ZSZMC = ZSZMC;
            waterwell.WNUMBER = WNUMBER;
            waterwell.TCRQ = T.ChangeDate(TCRQ);
            waterwell.GXGG = GXGG;
            waterwell.LENGTH = LENGTH;
            waterwell.PSJMC = PSJMC;
            waterwell.GXMC = GXMC;
            waterwell.LANDTYPE = LANDTYPE;
            waterwell.GBF = GBF;
            waterwell.GBFFORMAT = GBFFORMAT;
            waterwell.BZ = BZ;
            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(waterwell);
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