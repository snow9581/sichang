<%@ WebHandler Language="C#" Class="update_injectionWell" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.SessionState;

public class update_injectionWell : BaseHandler
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
        string WNUMBER = context.Request.Params["WNUMBER"];
        string TCRQ = context.Request.Params["TCRQ"];
        string GXGG1 = context.Request.Params["GXGG1"];
        string GXGG2 = context.Request.Params["GXGG2"];
        string GXGG = "";
        if (GXGG1 != "" || GXGG2 != "")
            GXGG = "Ф" + GXGG1 + "×" + GXGG2;
        string LENGTH = context.Request.Params["LENGTH"];
        string ZRFS = context.Request.Params["ZRFS"];
        string BWFS = context.Request.Params["BWFS"];
        string LANDTYPE = context.Request.Params["LANDTYPE"];
        string GXCZ = context.Request.Params["GXCZ"];
        string BZ = context.Request.Params["BZ"];
        DB db = new DB();
        string sql = "update T_injectionWell set ZM='" + T.preHandleSql(ZM) + "',WNUMBER='" + T.preHandleSql(WNUMBER) + "',TCRQ =to_date('" + TCRQ + "','yyyy-mm-dd'),GXGG='" + T.preHandleSql(GXGG) + "',LENGTH='" + T.preHandleSql(LENGTH) +
                      "',ZRFS='" + T.preHandleSql(ZRFS) + "',BWFS ='" + T.preHandleSql(BWFS) + "',LANDTYPE='" + T.preHandleSql(LANDTYPE) + "',GXCZ='" + T.preHandleSql(GXCZ) + "',BZ='" + T.preHandleSql(BZ) + "' where id='" + ID + "'";
        bool result = db.ExecuteSQL(sql);
        if (result)
        {
            injectionWell injectionwell = new injectionWell();
            injectionwell.ID = ID;
            injectionwell.KM = KM;
            injectionwell.DM = DM;
            injectionwell.ZM = ZM;
            injectionwell.WNUMBER = WNUMBER;
            injectionwell.TCRQ = T.ChangeDate(TCRQ);
            injectionwell.GXGG = GXGG;
            injectionwell.LENGTH = LENGTH;
            injectionwell.ZRFS = ZRFS;
            injectionwell.BWFS = BWFS;
            injectionwell.LANDTYPE = LANDTYPE;
            injectionwell.GXCZ = GXCZ;
            injectionwell.BZ = BZ;
            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(injectionwell);
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