<%@ WebHandler Language="C#" Class="update_waterWell" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Data;
using System.Web.SessionState;
public class update_waterWell : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        if (context.Session["userlevel"] == "" || context.Session["userlevel"] == null)
        {
            context.Response.Write("<script>alert('用户已过期,请重新登录！');window.parent.location.href ='../login.aspx'</script>");
        }
        string json = "";
        string ID = context.Request.Params["ID"];
        string DM = context.Request.Params["DM"];
        string KM = context.Request.Params["KM"]; ;
        string ZM = context.Request.Params["ZM"];
        string ZSZMC = context.Request.Params["ZSZMC"];
        string WNUMBER = context.Request.Params["WNUMBER"];
        string TCRQ = context.Request.Params["TCRQ"];
        string GXGG1 = context.Request.Params["GXGG1"];
        string GXGG2 = context.Request.Params["GXGG2"];
        string GXGG="";
        if(GXGG1!=""||GXGG2!="")
             GXGG = "Ф" + GXGG1 + "×" + GXGG2;
        string LENGTH = context.Request.Params["LENGTH"];
        string PSJMC = context.Request.Params["PSJMC"];
        string GXMC = context.Request.Params["GXMC"];
        string LANDTYPE = context.Request.Params["LANDTYPE"];
        string GBF = context.Request.Params["GBF"];
        string GBFFORMAT = context.Request.Params["GBFFORMAT"];
        string BZ = context.Request.Params["BZ"];
        DB db = new DB();
        string sql = "update T_waterWell set ZM='" + T.preHandleSql(ZM) + "',ZSZMC='" + T.preHandleSql(ZSZMC) + "',WNUMBER='" + T.preHandleSql(WNUMBER) + "',TCRQ =to_date('" + TCRQ + "','yyyy-mm-dd'),GXGG='" + T.preHandleSql(GXGG) + "',LENGTH='" + T.preHandleSql(LENGTH) +
                      "',PSJMC='" + T.preHandleSql(PSJMC) + "',GXMC ='" + T.preHandleSql(GXMC) + "',LANDTYPE='"+T.preHandleSql(LANDTYPE)+"',GBF='"+T.preHandleSql(GBF)+"',GBFFORMAT='"+T.preHandleSql(GBFFORMAT)+"',BZ='"+T.preHandleSql(BZ)+"' where id='" + ID + "'";
        bool result = db.ExecuteSQL(sql);
        if (result)
        {
            waterWell waterwell = new waterWell();
            waterwell.ID = ID;
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
            context.Response.Write("<script>alert('  错误!\\n更新失败！');</script>");
        }

    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}