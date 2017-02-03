<%@ WebHandler Language="C#" Class="get_project" %>

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

public class get_project : BaseHandler {

    public override void AjaxProcess(HttpContext context)
    {
        //string userlevel = Convert.ToString(context.Session["userlevel"]);
        //string username = Convert.ToString(context.Session["username"]);
        //string DM = Convert.ToString(context.Session["dm"]);
        int page = Convert.ToInt32(context.Request.Params["page"]);//页索引
        int rows = Convert.ToInt32(context.Request.Params["rows"]);
        string buf = context.Request.Params["buf"];
        ///条件查询 begin
       // string PID = context.Request.Params["PID"];//项目编号
        string PName = context.Request.Params["PNAME"];//工程内容||工程名称
        string PNumber = context.Request.Params["PNUMBER"];//项目号||方案号
        string SoluChief = context.Request.Params["SOLUCHILF"];//项目方案负责人
  

        string QSentence = " where 1=1 and BUFFER="+buf;  //定义一个查询子句，当有一个或多个条件不为空时，使用该子句
        if (PNumber != null && PNumber != "")
        {
            QSentence=QSentence +"and Pnumber like '%" + T.preHandleSql(PNumber)+  "%'";
        }
        if (PName != null && PName != "")
        {
            QSentence = QSentence + " and PNAME like '%" + T.preHandleSql(PName) + "%'";
        }
        if (SoluChief != null && SoluChief != "")
        {
            QSentence = QSentence + " and SOLUCHIEF like '%" + T.preHandleSql(SoluChief) + "%'";
        }
        string sqlstr = "select PID,PNAME,PNUMBER,PNUMBER,SOLUCHIEF,PLANINVESMENT,DESICHIEF,DESIAPPROVALARRIVALFILENUMBER,PLANARRIVALFILENUMBER from(select t.*,rownum rn from(select * from T_PLANRUN_DTZ " + QSentence + " Order By INITDATE DESC) t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + " ";
        ///条件查询 end
        string sql = "select count(*) from T_PLANRUN_DTZ" + QSentence;
        DB db = new DB();
        int Count = db.GetCount(sql);//获取总条数
        DataTable dt = db.GetDataTable(sqlstr); //获取当前页的数据
        String jsonData = T.ToJson(dt, Count);
        context.Response.Write(jsonData);
        context.Response.End();
    }
    public bool IsReusable {
        get {
            return false;
        }
    }
}
