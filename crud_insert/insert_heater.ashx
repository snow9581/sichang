<%@ WebHandler Language="C#" Class="insert_heater" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.SessionState;
public class insert_heater : BaseHandler
{
    public override void AjaxProcess (HttpContext context)
    {  
        string json="";
        string fh = "Φ";
        string ch = "×"; 
        string hb="";
        string DM = Convert.ToString(context.Session["dm"]);
        string ZM=context.Request.Params["ZM"];
        string JRLYT=context.Request.Params["JRLYT"];
        string JRLLX=context.Request.Params["JRLLX"];
        string JRLMC=context.Request.Params["JRLMC"];
        string ZNBH=context.Request.Params["ZNBH"];
        string GGXH1=context.Request.Params["GGXH1"];
        string GGXH2= context.Request.Params["GGXH2"];
        string JRLGL=context.Request.Params["JRLGL"];
        string TCRQ=context.Request.Params["TCRQ"];
        string AQBHLX=context.Request.Params["AQBHLX"];
        string SCCJ=context.Request.Params["SCCJ"];
        string LUBZ=context.Request.Params["LUBZ"];
        string RSQXH=context.Request.Params["RSQXH"];
        string RSQGL=context.Request.Params["RSQGL"];
        string RSQCJ=context.Request.Params["RSQCJ"];
        string RSQBZ=context.Request.Params["RSQBZ"];
        if ((GGXH1 != "" && GGXH1 != null) || (GGXH2 != "" && GGXH2 != null))
            hb = fh + GGXH1 + ch + GGXH2;
        string ID = "0";
        DB db = new DB();
        string sql_id = "select SEQ_HEATER.nextval from dual";
        System.Data.DataTable dt = db.GetDataTable(sql_id);
        if (dt.Rows.Count > 0) ID = dt.Rows[0][0].ToString();
        string sql = "insert into T_HEATER(ID,DM,ZM,JRLYT,JRLLX,JRLMC,ZNBH,GGXH,JRLGL,TCRQ,AQBHLX,SCCJ,LUBZ,RSQXH,RSQGL,RSQCJ,RSQBZ) values (" + ID + ",'" + DM+ "','" +
                     ZM + "','" + JRLYT + "','" + JRLLX + "','" + JRLMC + "','" + ZNBH + "','" + hb + "','" + JRLGL + "',to_date('" + TCRQ + "','yyyy-mm-dd'),'" + AQBHLX + "','" + SCCJ + "','" + LUBZ + "','" + RSQXH + "','" + RSQGL + "','" + RSQCJ + "','" + RSQBZ + "')";
        bool result=db.ExecuteSQL(sql);
        if (result)
        {
            Heater heater = new Heater();
            heater.ID=ID;
            heater.DM = DM;
            heater.ZM=ZM;
            heater.JRLYT=JRLYT;
            heater.JRLLX=JRLLX;
            heater.JRLMC=JRLMC;
            heater.ZNBH=ZNBH;
            heater.GGXH=hb;
            heater.JRLGL=JRLGL;
            heater.TCRQ=T.ChangeDate(TCRQ);
            heater.AQBHLX=AQBHLX;
            heater.SCCJ=SCCJ;
            heater.LUBZ=LUBZ;
            heater.RSQXH=RSQXH;
            heater.RSQGL=RSQGL;
            heater.RSQCJ=RSQCJ;
            heater.RSQBZ=RSQBZ;
            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(heater);
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