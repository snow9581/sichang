<%@ WebHandler Language="C#" Class="insert_pump" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.SessionState;
public class insert_pump : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string json="";
        string DM = Convert.ToString(context.Session["dm"]);
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
        string ID = "0";
        DB db = new DB();
        string sql_id = "select SEQ_PUMP.nextval from dual";
        System.Data.DataTable dt = db.GetDataTable(sql_id);
        if (dt.Rows.Count > 0) ID = dt.Rows[0][0].ToString();
        string sql = "insert into T_PUMP(ID,DM,ZM,BMC,BSBBH,BXH,BSBNL,BTCRQ,BYC,BYXZT,SCCJ,BBZ,DJXH,DJGL,DJTCRQ,DJBPQBH,DJSCCJ,DJBZ) values (" + ID + ",'" + T.preHandleSql(DM) + "','" +
                     T.preHandleSql(ZM) + "','" + T.preHandleSql(BMC) + "','" + T.preHandleSql(BSBBH) + "','" + T.preHandleSql(BXH) + "','" + T.preHandleSql(BSBNL) + "',to_date('" + BTCRQ + "','yyyy-mm-dd'),'" + T.preHandleSql(BYC) + "','" + T.preHandleSql(BYXZT) + "','" + T.preHandleSql(SCCJ) + "','" + T.preHandleSql(BBZ) + "','" + T.preHandleSql(DJXH) + "','" + T.preHandleSql(DJGL) + "',to_date('" + DJTCRQ + "','yyyy-mm-dd'),'" + T.preHandleSql(DJBPQBH) + "','" + T.preHandleSql(DJSCCJ) + "','" + T.preHandleSql(DJBZ) + "')";
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