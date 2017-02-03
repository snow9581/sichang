<%@ WebHandler Language="C#" Class="updata_text" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.SessionState;
using System.Text.RegularExpressions;

public class updata_text : BaseHandler {

    public override void AjaxProcess (HttpContext context) {
        //context.Response.ContentType = "text/plain";
        //context.Response.Write("Hello World");
        string json = "";
        string COMPANY = context.Request.Params["COMPANY"];
        string COMPETENT = context.Request.Params["COMPETENT"];
        string CHECKER = context.Request.Params["CHECKER"];
        string TEXTER = context.Request.Params["TEXTER"];
        string TEXTDATE = context.Request.Params["TEXTDATE"];
        string VALIDDATE = context.Request.Params["VALIDDATE"];
        string a = " 0:00:00";
        Regex r = new Regex(a);
        Match m = r.Match(TEXTDATE);
        if(m.Success)
        {
            TEXTDATE = TEXTDATE.Replace(a, "");
            VALIDDATE = VALIDDATE.Replace(a, "");
        }
        string DATA1 = context.Request.Params["DATA1"];
        string DATA2 = context.Request.Params["DATA2"];
        string DATA3 = context.Request.Params["DATA3"];
        string DATA9 = context.Request.Params["DATA9"];
        string DATA10 = context.Request.Params["DATA10"];
        string DATA11 = context.Request.Params["DATA11"];
        string DATA12 = context.Request.Params["DATA12"];
        string DATA13 = context.Request.Params["DATA13"];
        string DATA14 = context.Request.Params["DATA14"];
        string DATA15 = context.Request.Params["DATA15"];
        string DATA16 = context.Request.Params["DATA16"];
        string DATA17 = context.Request.Params["DATA17"];
        string DATA18 = context.Request.Params["DATA18"];
        string DATA19 = context.Request.Params["DATA19"];
        string DATA20 = context.Request.Params["DATA20"];
        string DATA21 = context.Request.Params["DATA21"];
        string DATA22 = context.Request.Params["DATA22"];
        string DATA23 = context.Request.Params["DATA23"];
        string DATA24 = context.Request.Params["DATA24"];
        string DATA25 = context.Request.Params["DATA25"];
        string DATA26 = context.Request.Params["DATA26"];
        string DATA27 = context.Request.Params["DATA27"];
        string DATA28 = context.Request.Params["DATA28"];
        string DATA29 = context.Request.Params["DATA29"];
        string DATA30 = context.Request.Params["DATA30"];
        string DATA31 = context.Request.Params["DATA31"];
        string DATA32 = context.Request.Params["DATA32"];
        string DATA33 = context.Request.Params["DATA33"];
        string DATA34 = context.Request.Params["DATA34"];
        string DATA35 = context.Request.Params["DATA35"];
        string DATA36 = context.Request.Params["DATA36"];
        string DATA37 = context.Request.Params["DATA37"];
        string DATA38 = context.Request.Params["DATA38"];
        string MAXERROR = context.Request.Params["MAXERROR"];
        string TEXTED = context.Request.Params["TEXTED"];
        string ID = context.Request.Params["ID"];
        DB db = new DB();
        string sql = "update T_METERTEXT set COMPANY='"+COMPANY+"',COMPETENT='"+COMPETENT+"',CHECKER='"+CHECKER+"',TEXTER='"+TEXTER+"',TEXTDATE =to_date('"+TEXTDATE+"','yyyy-mm-dd'),VALIDDATE=to_date('"+VALIDDATE+"','yyyy-mm-dd'),DATA1='"+DATA1+"',DATA2='"+DATA2+"',DATA3='"+DATA3+"',DATA9='"+DATA9+"',DATA10='"+DATA10+"',DATA11='"+DATA11+"',DATA12='"+DATA12+"',DATA13='"+DATA13+"',DATA14='"+DATA14+"',DATA15='"+DATA15+"',DATA16='"+DATA16+"',DATA17='"+DATA17+"',DATA18='"+DATA18+"',DATA19='"+DATA19+"',DATA20='"+DATA20+"',DATA21='"+DATA21+"',DATA22='"+DATA22+"',DATA23='"+DATA23+"',DATA24='"+DATA24+"',DATA25='"+DATA25+"',DATA26='"+DATA26+"',DATA27='"+DATA27+"',DATA28='"+DATA28+"',DATA29='"+DATA29+"',DATA30='"+DATA30+"',DATA31='"+DATA31+"',DATA32='"+DATA32+"',DATA33='"+DATA33+"',DATA34='"+DATA34+"',DATA35='"+DATA35+"',DATA36='"+DATA36+"',DATA37='"+DATA37+"',DATA38='"+DATA38+"',MAXERROR='"+MAXERROR+"' where T_ID='"+ID+"'";
        bool result = db.ExecuteSQL(sql);
        if(result)
        {
            MeterText mt = new MeterText();
            mt.COMPANY = COMPANY;
            mt.CHECKER = CHECKER;
            mt.COMPETENT = COMPETENT;
            mt.DATA1 = DATA1;
            mt.DATA2 = DATA1;
            mt.DATA3 = DATA1;
            mt.DATA9 = DATA9;
            mt.DATA10 = DATA10;
            mt.DATA11= DATA11;
            mt.DATA12 = DATA12;
            mt.DATA13 = DATA13;
            mt.DATA14 = DATA14;
            mt.DATA15 = DATA15;
            mt.DATA16 = DATA16;
            mt.DATA17 = DATA17;
            mt.DATA18 = DATA18;
            mt.DATA19 = DATA19;
            mt.DATA20 = DATA20;
            mt.DATA21 = DATA21;
            mt.DATA22 = DATA22;
            mt.DATA23 = DATA23;
            mt.DATA24 = DATA24;
            mt.DATA25 = DATA25;
            mt.DATA26 = DATA26;
            mt.DATA27 = DATA27;
            mt.DATA28 = DATA28;
            mt.DATA29 = DATA29;
            mt.DATA30 = DATA30;
            mt.DATA31 = DATA31;
            mt.DATA32 = DATA32;
            mt.DATA33 = DATA33;
            mt.DATA34 = DATA34;
            mt.DATA35 = DATA35;
            mt.DATA36 = DATA36;
            mt.DATA37 = DATA37;
            mt.DATA38 = DATA38;
            mt.MAXERROR = MAXERROR;
            mt.TEXTED = TEXTED;
            mt.ID = ID;
            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(mt);
            context.Response.Write(json);
            context.Response.End();
        }
        else
        {
            context.Response.ContentType = "text/html";
            context.Response.Write("<script>alert('  错误!\\n添加失败！');</script>");
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}