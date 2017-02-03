<%@ WebHandler Language="C#" Class="submitPrice" %>

using System;
using System.Web;
//员工填写确认单时执行
public class submitPrice : BaseHandler {

    override public void AjaxProcess(HttpContext context)
    {
        string DJs = context.Request.Params["dj"].ToString();
        string HJs = context.Request.Params["hj"].ToString();
        string IDs = context.Request.Params["id"].ToString();
        string JDHGSLs = context.Request.Params["JDHGSL"].ToString();
        string TSQKSMs = context.Request.Params["TSQKSM"].ToString();
        string fromid=context.Request.Params["fromid"].ToString();
        
      //  int result = Int32.Parse(context.Request.Params["jg"].ToString());
        
        string[] DJ = DJs.Split(',');
        string[] HJ = HJs.Split(',');
        string[] ID = IDs.Split(',');
        string[] JDHGSL = JDHGSLs.Split(',');
        string[] TSQKSM = TSQKSMs.Split(',');
        DB db = new DB();
        bool isfinish = true;
        for (int i = 0; i < ID.Length; i++)
        {
            if (DJ[i] == "" || HJ[i] == "")
                isfinish = false;
            string sql = "update T_METER_CHECK_QRD set JDDJ='" + DJ[i] + "',JDFYHJ='" + HJ[i] + "',JDHGSL='" + JDHGSL[i] + "',TSQKSM='" + TSQKSM [i]+ "' where ID='" + ID[i] + "'";
            db.ExecuteSQL(sql);
          //  string sql_update_result = "update T_METER_CHECK set JG=" + result + " where ID=" + fromid ;
          //  db.ExecuteSQL(sql_update_result);
        }
        if (isfinish)
        {
            string sql = "update T_METER_CHECK set QRD_FINISH='1',STATE='5' where ID=" + fromid;
            db.ExecuteSQL(sql);
        }
        context.Response.Write("1");
        context.Response.End();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}