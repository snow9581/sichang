<%@ WebHandler Language="C#" Class="insert_injectionWell" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.SessionState;

public class insert_injectionWell :  BaseHandler
{

    public override void AjaxProcess(HttpContext context)
    {
        string json = "";
        string DM = Convert.ToString(context.Session["dm"]);
        string KM = Convert.ToString(context.Session["km"]);
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
        string ID = "0";
        DB db = new DB();
        string sql_id = "select SEQ_injectionWell.nextval from dual";
        System.Data.DataTable dt = db.GetDataTable(sql_id);
        if (dt.Rows.Count > 0) ID = dt.Rows[0][0].ToString(); 

        string sql = "insert into T_injectionWell(ID,KM,DM,ZM,WNUMBER,TCRQ,GXGG,LENGTH,ZRFS,BWFS,LANDTYPE,GXCZ,BZ) values ("+ID+",'" +
                     KM + "','" + DM + "','" + T.preHandleSql(ZM) + "','" + T.preHandleSql(WNUMBER) + "', to_date('" + TCRQ + "','yyyy-mm-dd'),'" + T.preHandleSql(GXGG) + "','" + LENGTH + "','" + T.preHandleSql(ZRFS) + "','" +
                     T.preHandleSql(BWFS) + "','" + T.preHandleSql(LANDTYPE) + "','" + T.preHandleSql(GXCZ) + "','" + T.preHandleSql(BZ) + "')"; //高俊涛修改 2014-09-07 把文件名filename存入数据库
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
            context.Response.Write("<script>alert('  错误!\\n添加失败！')</script>");
        }

    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}