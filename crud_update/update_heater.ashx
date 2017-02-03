<%@ WebHandler Language="C#" Class="update_heater" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Data;
using System.Web.SessionState;

public class update_heater : BaseHandler
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
        string JRLYT = context.Request.Params["JRLYT"];
        string JRLLX = context.Request.Params["JRLLX"];
        string JRLMC = context.Request.Params["JRLMC"];
        string ZNBH = context.Request.Params["ZNBH"];
        string GGXH1 = context.Request.Params["GGXH1"];
        string GGXH2 = context.Request.Params["GGXH2"];
        string JRLGL = context.Request.Params["JRLGL"];
        string TCRQ = context.Request.Params["TCRQ"];
        string AQBHLX = context.Request.Params["AQBHLX"];
        string SCCJ = context.Request.Params["SCCJ"];
        string LUBZ = context.Request.Params["LUBZ"];
        string RSQXH = context.Request.Params["RSQXH"];
        string RSQGL = context.Request.Params["RSQGL"];
        string RSQCJ = context.Request.Params["RSQCJ"];
        string RSQBZ = context.Request.Params["RSQBZ"];
        if ((GGXH1 != "" && GGXH1 != null) || (GGXH2 != "" && GGXH2 != null))
            hb = fh + GGXH1 + ch + GGXH2;
        
        DB db = new DB();

        string sql = "update T_HEATER set DM='" + T.preHandleSql(DM) + "',ZM='" + T.preHandleSql(ZM) + "',JRLYT='" + T.preHandleSql(JRLYT) +
              "',JRLLX='" + T.preHandleSql(JRLLX) + "',JRLMC='" + T.preHandleSql(JRLMC) + "',ZNBH='" + T.preHandleSql(ZNBH) + "',GGXH='" + T.preHandleSql(hb) + "',JRLGL='" + T.preHandleSql(JRLGL) 
              + "',TCRQ=to_date('" + TCRQ + "','yyyy-mm-dd') ,AQBHLX='" + T.preHandleSql(AQBHLX) + "',SCCJ='" + T.preHandleSql(SCCJ) + "',LUBZ='" + T.preHandleSql(LUBZ) 
              + "',RSQXH='" + T.preHandleSql(RSQXH) + "',RSQGL='" + T.preHandleSql(RSQGL) + "',RSQCJ='" + T.preHandleSql(RSQCJ) + "',RSQBZ='" + T.preHandleSql(RSQBZ) + "'where id='" + ID + "'";

        bool result=db.ExecuteSQL(sql);
        if (result)
        {
            Heater heater = new Heater();
            heater.ID = ID;
            heater.DM = DM;
            heater.ZM = ZM;
            heater.JRLYT = JRLYT;
            heater.JRLLX = JRLLX;
            heater.JRLMC = JRLMC;
            heater.ZNBH = ZNBH;
            heater.GGXH = hb;
            heater.JRLGL = JRLGL;
            heater.TCRQ = T.ChangeDate(TCRQ);
            heater.AQBHLX = AQBHLX;
            heater.SCCJ = SCCJ;
            heater.LUBZ = LUBZ;
            heater.RSQXH = RSQXH;
            heater.RSQGL = RSQGL;
            heater.RSQCJ = RSQCJ;
            heater.RSQBZ = RSQBZ;
            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(heater);
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