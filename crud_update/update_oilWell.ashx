<%@ WebHandler Language="C#" Class="update_oilWell" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.SessionState;

public class update_oilWell : BaseHandler
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
        string KM = context.Request.Params["KM"];
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
        string JYGXGG = "";
        if (JYGXGG1 != "" || JYGXGG2 != "")
            JYGXGG = "Ф" + JYGXGG1 + "×" + JYGXGG2;
        string JYGXLENGTH = context.Request.Params["JYGXLENGTH"];
        string CSGXGG1 = context.Request.Params["CSGXGG1"];
        string CSGXGG2 = context.Request.Params["CSGXGG2"];
        string CSGXGG = "";
        if (CSGXGG1 != "" || CSGXGG2 != "")
            CSGXGG = "Ф" + CSGXGG1 + "×" + CSGXGG2;
        string CSGXLENGTH = context.Request.Params["CSGXLENGTH"];
        string GJJH = context.Request.Params["GJJH"];
        string TCRQ = context.Request.Params["TCRQ"];
        string BZ = context.Request.Params["BZ"];
        
        DB db = new DB();
        string sql = "update T_oilWell set ZM='" + T.preHandleSql(ZM) + "',JLJ='" + T.preHandleSql(JLJ) + "',PRODUCTIONDATE=to_date('" + PRODUCTIONDATE + "','yyyy-mm-dd'),JLJJG='" + T.preHandleSql(JLJJG) + "',FLQXH='" + T.preHandleSql(FLQXH) +
                      "',WELLTYPE='" + T.preHandleSql(WELLTYPE) + "',KT ='" + KT + "',WNUMBER='" + WNUMBER + "',JYGXGG='" + JYGXGG + "',JYGXLENGTH='" + JYGXLENGTH + "',CSGXGG='" + T.preHandleSql(CSGXGG) + "',CSGXLENGTH='" + T.preHandleSql(CSGXLENGTH) + "',GJJH='" + T.preHandleSql(GJJH) + "',TCRQ =to_date('" + TCRQ + "','yyyy-mm-dd'),BZ='" + T.preHandleSql(BZ) + "' where id='" + ID + "'";
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
            context.Response.Write("<script>alert('  错误!\\n更新失败！');</script>");
        }

    }
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}