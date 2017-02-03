<%@ WebHandler Language="C#" Class="get_FinishState" %>
//加载确认单时执行
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;
using System.Web.SessionState;

public class get_FinishState : BaseHandler
{

    override public void AjaxProcess(HttpContext context)
    {
        string fromid = context.Request.Params["FROMID"].ToString();
        DB db = new DB();
        DataTable dt = db.GetDataTable("select * from T_METER_CHECK_QRD where FROMID='" + fromid + "'");
        //判断在哪条数据下插入信息
        int location=dt.Rows.Count;
        for (int i = 0; i < dt.Rows.Count - 1; i++)
            if (dt.Rows[i]["TYPE"].ToString() == "1" && dt.Rows[i + 1]["TYPE"].ToString() == "2")
                location = i;
        DataRow dr = dt.NewRow();
     /*   dr["TYPE"] = "3";
        dr["JLQJMC"] = "计量器具名称";
        dr["GGXH"] = "规格型号";
        dr["JLLB"] = "安装位置";
        dr["JDWCSL"] = "维修更换部件";
        dr["JDDJ"] = "维修单位";
        dr["JDFYHJ"] = "维修费用(元)";
        dt.Rows.InsertAt(dr, location+1);
      * */
        string json = wjz_tools.ToJson(dt, dt.Rows.Count, new List<string>() { "Time" });
        context.Response.Write(json);
        context.Response.End();
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}