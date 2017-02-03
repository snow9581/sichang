<%@ WebHandler Language="C#" Class="update_repair" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.SessionState;

public class update_repair : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        if (context.Session["userlevel"] == "" || context.Session["userlevel"] == null)
        {
            context.Response.Write("<script>alert('用户已过期,请重新登录！');window.parent.location.href ='../login.aspx'</script>");
        }
        string json = "";
        string ID = context.Request.Params["ID"];
        string KM = context.Request.Params["KM"];
        string DM = context.Request.Params["DM"];
        string CREATEDATE = DateTime.Now.ToString();
        string ZM = context.Request.Params["ZM"];
        string SBMC = context.Request.Params["SBMC"];
        string SBXH = context.Request.Params["SBXH"];
        string SBNL = context.Request.Params["SBNL"];
        string TCRQ = context.Request.Params["TCRQ"];
        string WXRQ = context.Request.Params["WXRQ"];
        string WXNR = context.Request.Params["WXNR"];
        string WXDW = context.Request.Params["WXDW"];
        string FZR = context.Request.Params["FZR"];
        string TELEPHONE = context.Request.Params["TELEPHONE"];
        string BZ = context.Request.Params["BZ"];
        
        DB db = new DB();
        string sql = "update T_REPAIR set KM='" + KM + "',DM='" + DM + "',ZM='" + T.preHandleSql(ZM) + "',SBMC='" + T.preHandleSql(SBMC) + "',SBXH='" +
                      T.preHandleSql(SBXH) + "',SBNL='" + SBNL + "',TCRQ= to_date('" + TCRQ + "','yyyy-mm-dd'),WXRQ=to_date('" + WXRQ + "','yyyy-mm-dd'),WXNR='" +
                      T.preHandleSql(WXNR) + "',WXDW='" + T.preHandleSql(WXDW) +
                      "',FZR='" + T.preHandleSql(FZR) + "', TELEPHONE='" + T.preHandleSql(TELEPHONE) + "',BZ='" + T.preHandleSql(BZ) + "',CREATEDATE =to_date('" + CREATEDATE + "','yyyy-mm-dd hh24:mi:ss') where id='" + ID + "'";
        
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
            repair.TCRQ = T.ChangeDate(TCRQ);
            repair.WXRQ = T.ChangeDate(WXRQ);
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
           context.Response.Write("<script>alert('  错误!\\n更新失败！');</script>");
       }
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}