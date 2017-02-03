<%@ WebHandler Language="C#" Class="get_blueGraph" %>

using System;
using System.Web;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;
using System.Web.SessionState;

public class get_blueGraph : BaseHandler
{

    public override void AjaxProcess(HttpContext context)
    {
        string userlevel = Convert.ToString(context.Session["userlevel"]);
        string username = Convert.ToString(context.Session["username"]);
        int page = Convert.ToInt32(context.Request.Params["page"]);//页索引
        int rows = Convert.ToInt32(context.Request.Params["rows"]);

        ///条件查询 begin
        string b_pname = context.Request.Params["b_pname"];
        string b_name = context.Request.Params["b_name"];
        string b_major = context.Request.Params["b_major"];
        string QSentence = " where PNAME='" + b_pname+"'";  //定义一个查询子句，当有一个或多个条件不为空时，使用该子句
        if (b_major != null && b_major != "")
        {
            QSentence = QSentence + " and DESIGNSPECIAL like '%" + T.preHandleSql(b_major) + "%'";
        }
        if (b_name != null && b_name != "")
        {
            QSentence = QSentence + " and SPECIALPERSON like '%" + T.preHandleSql(b_name) + "%'";
        }
        string sqlstr = "select * from(select t.*,rownum rn from(select * from t_construction " + QSentence + ") t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + "";

        ///条件查询 end

        string sql = "select count(*) from t_construction" + QSentence;

        DB db = new DB();
        int Count = db.GetCount(sql);//获取总条数
        DataTable dt = db.GetDataTable(sqlstr); //获取当前页的数据                     

        String jsonData = T.ToJson_LongDate(dt, Count);
        context.Response.Write(jsonData);
        context.Response.End();

    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}