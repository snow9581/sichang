<%@ WebHandler Language="C#" Class="insert_qrd2" %>

using System;
using System.Web;
//员工填写确认单中需手动填写部分后，上传数据时执行
public class insert_qrd2 : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        string JLQJMC = context.Request.Params["JLQJMC"];
        string GGXH = context.Request.Params["GGXH"];
        string JLLB = context.Request.Params["JLLB"];
        string JDWCSL = context.Request.Params["JDWCSL"];
        string JDDJ = context.Request.Params["JDDJ"];
        string JDFYHJ = context.Request.Params["JDFYHJ"];
        string TSQKSM = context.Request.Params["TSQKSM"];
        string FROMID = context.Request.Params["FROMID"];
        DB db = new DB();
        string str_id = "select SEQ_Table.nextval from dual";
        string id = db.GetDataTable(str_id).Rows[0][0].ToString();
        bool x1 = db.ExecuteSQL("update T_METER_CHECK set QRD_FINISH='1' where FROMID=" + FROMID);
        bool x2 = db.ExecuteSQL("insert into T_METER_CHECK_QRD (JLQJMC,GGXH,JLLB,JDWCSL,JDDJ,JDFYHJ,TSQKSM,TYPE,ID,FROMID) values ('" + JLQJMC + "','" + GGXH + "','" + JLLB + "','" + JDWCSL + "','" + JDDJ + "','" + JDFYHJ + "','" + TSQKSM + "','2','" + id + "','" + FROMID + "')");
        if (x1 && x2)
            context.Response.Write("1");
        else
            context.Response.Write("0");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}