<%@ WebHandler Language="C#" Class="insert_repair" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.SessionState;

public class insert_repair : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string json = "";
        string DM = Convert.ToString(context.Session["dm"]);
        string KM = Convert.ToString(context.Session["km"]);
        string CREATEDATE = DateTime.Now.ToString();
        string ZM = context.Request.Params["ZM"];
        string SBMC = context.Request.Params["SBMC"];
        string SBXH = context.Request.Params["SBXH"];
        string SBNL = context.Request.Params["SBNL"];

        string TCRQ = context.Request.Params["TCRQ"];
        if (TCRQ.Contains("-")) //如果不为空，为日期格式，还没细判断
        {
            TCRQ = Convert.ToDateTime(TCRQ).ToShortDateString();
        }
        string WXRQ = context.Request.Params["WXRQ"];
        if (WXRQ.Contains("-")) //如果不为空，为日期格式，还没细判断
        {
            WXRQ = Convert.ToDateTime(WXRQ).ToShortDateString();
        }
        string WXNR = context.Request.Params["WXNR"];

        string WXDW = context.Request.Params["WXDW"];
        string FZR = context.Request.Params["FZR"];
        string TELEPHONE = context.Request.Params["TELEPHONE"];
        string BZ = context.Request.Params["BZ"];

        string ID = "0";
        DB db = new DB();
        string sql_id = "select SEQ_REPAIR.nextval from dual";
        System.Data.DataTable dt = db.GetDataTable(sql_id);
        if (dt.Rows.Count > 0) ID = dt.Rows[0][0].ToString();
       
        string sql = "insert into T_REPAIR(ID,KM,DM,ZM,SBMC,SBXH,SBNL,TCRQ,WXRQ," +
                    "WXNR,WXDW,FZR,TELEPHONE,BZ,CREATEDATE) values (" + ID + ",'" +
                    KM + "','" + DM + "','" + T.preHandleSql(ZM) + "','" + T.preHandleSql(SBMC) + "','" + T.preHandleSql(SBXH) + "','" +
                    SBNL + "', to_date('" + TCRQ + "','yyyy-mm-dd'),to_date('" + WXRQ + "','yyyy-mm-dd'),'" + T.preHandleSql(WXNR) + "','" + T.preHandleSql(WXDW) + "','" +
                    T.preHandleSql(FZR) + "','" + T.preHandleSql(TELEPHONE) + "','" + T.preHandleSql(BZ) + "',to_date('" + CREATEDATE + "','yyyy-mm-dd hh24:mi:ss'))";
        
        bool result=db.ExecuteSQL(sql);
        if (result)
        {
            Repair repair = new Repair();
            repair.ID = ID;
            repair.KM = KM;
            repair.DM = DM;
            repair.CREATEDATE = CREATEDATE;
            repair.ZM = ZM;
            repair.SBMC = SBMC;
            repair.SBXH = SBXH;
            repair.SBNL = SBNL.ToString();
            repair.TCRQ = TCRQ;
            repair.WXRQ = WXRQ;
            repair.WXNR = WXNR;
            repair.WXDW = WXDW;
            repair.FZR = FZR;
            repair.TELEPHONE = TELEPHONE;
            repair.BZ = BZ;

            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(repair);
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