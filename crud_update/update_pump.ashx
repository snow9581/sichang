<%@ WebHandler Language="C#" Class="update_pump" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Data;
using System.Web.SessionState;
public class update_pump : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string json = "";
        string ID = context.Request.Params["ID"];
        string DM=context.Request.Params["DM"];
        string ZM=context.Request.Params["ZM"];
        string BMC=context.Request.Params["BMC"];
        string BSBBH=context.Request.Params["BSBBH"];
        string BXH=context.Request.Params["BXH"];
        string BSBNL=context.Request.Params["BSBNL"];
        string BTCRQ=context.Request.Params["BTCRQ"];
        string BYC=context.Request.Params["BYC"];
        string BYXZT=context.Request.Params["BYXZT"];
        string SCCJ = context.Request.Params["SCCJ"];
        string BBZ=context.Request.Params["BBZ"];
        string DJXH=context.Request.Params["DJXH"];
        string DJGL=context.Request.Params["DJGL"];
        string DJTCRQ=context.Request.Params["DJTCRQ"];
        string DJBPQBH = context.Request.Params["DJBPQBH"];
        string DJSCCJ=context.Request.Params["DJSCCJ"];
        string DJBZ=context.Request.Params["DJBZ"];
        DB db = new DB();
        string sql = "";
        sql = "update T_PUMP set DM='" + T.preHandleSql(DM) + "',ZM='" + T.preHandleSql(ZM) + "',BMC='" + T.preHandleSql(BMC) +
                "',BSBBH='" + T.preHandleSql(BSBBH) + "',BXH='" + T.preHandleSql(BXH) + "',BSBNL='" + T.preHandleSql(BSBNL) + "',BTCRQ=to_date('" + BTCRQ + "','yyyy-mm-dd') ,BYC='" + T.preHandleSql(BYC) + "',BYXZT='" + T.preHandleSql(BYXZT) + "',SCCJ='" + T.preHandleSql(SCCJ) + "',BBZ='" + T.preHandleSql(BBZ) + "',DJXH='" + T.preHandleSql(DJXH) + "', DJTCRQ=to_date('" + DJTCRQ + "','yyyy-mm-dd') ,DJBPQBH='" + T.preHandleSql(DJBPQBH) + "',DJSCCJ='" + T.preHandleSql(DJSCCJ) + "',DJBZ='" + T.preHandleSql(DJBZ) + "'where id='" + ID + "'";
        bool result=db.ExecuteSQL(sql);
        if (result)
        {
            Pump pump = new Pump();
            pump.BBZ = BBZ;
            pump.BMC = BMC;
            pump.BSBBH = BSBBH;
            pump.BSBNL = BSBNL;
            pump.BTCRQ = T.ChangeDate(BTCRQ);
            pump.BXH = BXH;
            pump.BYC = BYC;
            pump.BYXZT = BYXZT;
            pump.DJBPQBH = DJBPQBH;
            pump.DJBZ = DJBZ;
            pump.DJGL = DJGL;
            pump.DJSCCJ = DJSCCJ;
            pump.DJTCRQ = T.ChangeDate(DJTCRQ);
            pump.DJXH = DJXH;
            pump.DM = DM;
            pump.ID = ID;
            pump.SCCJ = SCCJ;
            pump.ZM = ZM;
            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(pump);
            context.Response.Write(json);
            context.Response.End();
        }
        else
        {
            context.Response.Write("<script>alert('  错误!\\n添加失败！');</script>");
        }
        
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}