<%@ WebHandler Language="C#" Class="insert_container" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.SessionState;

public class insert_container : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string json = "";
        string fh = "Φ";
        string ch = "×"; 
        string hb="";
        string DM = Convert.ToString(context.Session["dm"]);
        string ZM = context.Request.Params["ZM"];
        string SBLB= context.Request.Params["SBLB"];
        string SBMC = context.Request.Params["SBMC"];
        string SBBH = context.Request.Params["SBBH"];
       
        string GGXH1 = context.Request.Params["GGXH1"];
        string GGXH2 = context.Request.Params["GGXH2"];
        string SBNL = context.Request.Params["SBNL"];
        string TCRQ = context.Request.Params["TCRQ"];
        string SL = context.Request.Params["SL"];
        string SCCJ = context.Request.Params["SCCJ"];
        string BZ = context.Request.Params["BZ"];
        if ((GGXH1 != "" && GGXH1 != null) ||( GGXH2 != "" && GGXH2 != null))
            hb = fh + GGXH1 + ch + GGXH2;
        string ID = "0";
        DB db = new DB();
        string sql_id = "select SEQ_CONTAINER.nextval from dual";
        System.Data.DataTable dt = db.GetDataTable(sql_id);
        if (dt.Rows.Count > 0) ID = dt.Rows[0][0].ToString();
        string sql = "insert into T_CONTAINER(ID,DM,ZM,SBMC,SBLB,SBBH,GGXH,SBNL,TCRQ,SL,SCCJ,BZ) values (" +ID + ",'" + DM + "','" +
                     ZM + "','" + SBMC + "','" + SBLB + "','" + SBBH + "','" + hb + "','" + SBNL + "',to_date('" + TCRQ + "','yyyy-mm-dd'),'" + SL + "','" + SCCJ + "','" + BZ + "')";
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
            context.Response.Write("<script>alert('  错误!\\n添加失败！');</script>");
        }

    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}