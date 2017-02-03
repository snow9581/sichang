<%@ WebHandler Language="C#" Class="update_container" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Data;
using System.Web.SessionState;

public class update_container : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string json = "";
        string fh = "Φ";
        string ch = "×";
        string hb = "";
        string ID = context.Request.Params["ID"];
        string DM = context.Request.Params["DM"];
        string ZM = context.Request.Params["ZM"];
        string SBLB = context.Request.Params["SBLB"];
        string SBMC = context.Request.Params["SBMC"];
        string SBBH = context.Request.Params["SBBH"];
        string GGXH1 = context.Request.Params["GGXH1"];
        string GGXH2 = context.Request.Params["GGXH2"];
        string SBNL = context.Request.Params["SBNL"];
        string TCRQ = context.Request.Params["TCRQ"];
        string SL = context.Request.Params["SL"];
        string SCCJ = context.Request.Params["SCCJ"];
        string BZ = context.Request.Params["BZ"];
        if ((GGXH1 != "" && GGXH1 != null) || (GGXH2 != "" && GGXH2 != null))
            hb = fh + GGXH1 + ch + GGXH2;
        DB db = new DB();

        string sql = "update T_CONTAINER set DM='" + T.preHandleSql(DM) + "',ZM='" + T.preHandleSql(ZM) + "',SBLB='" + T.preHandleSql(SBLB) +"',SBMC='" + T.preHandleSql(SBMC)+
                   "',SBBH='" + T.preHandleSql(SBBH) + "',GGXH='" + T.preHandleSql(hb) + "',SBNL='" + T.preHandleSql(SBNL) + "',TCRQ=to_date('" + TCRQ + "','yyyy-mm-dd') ,SL='" + T.preHandleSql(SL) + "',SCCJ='" + T.preHandleSql(SCCJ) + "',BZ='" + T.preHandleSql(BZ) + "'where id='" + ID + "'";
       
        bool result = db.ExecuteSQL(sql);
        if (result)
        {
            Container container = new Container();
            container.ID = ID;
            container.BZ = BZ;
            container.DM = DM;
            container.GGXH = hb;
            container.SBBH = SBBH;
            container.SBLB = SBLB;
            container.SBMC = SBMC;
            container.SBNL = SBNL;
            container.SCCJ = SCCJ;
            container.SL = SL;
            container.TCRQ = T.ChangeDate(TCRQ);
            container.ZM = ZM;
            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(container);
            context.Response.Write(json);
            context.Response.End();
        }
        else
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write("<script>alert('  错误!\\n添加失败！');</script>");
        }

    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}