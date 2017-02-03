<%@ WebHandler Language="C#" Class="get_select" %>
//员工发起仪表检定时，在挑选待检定仪表时，加载所有仪表信息，从中挑选待检定表
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
public class get_select : BaseHandler
{

    override public void AjaxProcess(HttpContext context)
    {
        int page = Convert.ToInt32(context.Request.Params["page"]);//页索引
        int rows = Convert.ToInt32(context.Request.Params["rows"]);

        DB db = new DB();
        string sqlstr = "select * from(select t.*,rownum rn from(select * from T_METER ) t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + "";
        
        ///条件查询 begin
        string KM = context.Request.Params["KM"];
        string DM = context.Request.Params["DM"];        
        int searchScope=Convert.ToInt32(context.Request.Params["SCOPE"]);//获取搜索范围
      
        string QSentence = " where 1=1 ";  //定义一个查询子句，当有一个或多个条件不为空时，使用该子句

        if (searchScope == 1)
        { //计算仪表下次检定时间
           //获取当前时间所有月份的起止时间
           DateTime toDay=DateTime.Today;
           int month=toDay.Month;           
           int year=toDay.Year;
           string startday=year+"-"+month+"-"+"01";
           string endday="";
           switch (month)
           {
               case 1:
               case 3:
               case 5:
               case 7:
               case 8:
               case 10:
               case 12: endday=year+"-"+month+"-"+"31";
                                     break;
               case 2:
               case 4:
               case 6:
               case 9:
               case 11: endday=year+"-"+month+"-"+"30";
                                     break;               
           }
         
            //构造SQL查询条件
           QSentence = QSentence + "and add_months(JDRQ,JDZQ) between to_date('" + startday + "','yyyy-mm-dd') and to_date('" + endday + "','yyyy-mm-dd')";
        }
     
        if (KM != null && KM != "")
        {
            QSentence = QSentence + " and KM like '%" + T.preHandleSql(KM) + "%'";
        }

        if (DM != null && DM != "")
        {
            QSentence = QSentence + " and DM like '%" + T.preHandleSql(DM) + "%'";
        }

        QSentence = QSentence + "and SFWS='送检'";
            
        sqlstr = "select * from(select t.*,rownum rn from(select * from T_METER " + QSentence + ") t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + "";

        ///条件查询 end
        string sql = "select count(*) from T_METER" + QSentence;
        int Count = db.GetCount(sql);//获取总条数
        DataTable dt = db.GetDataTable(sqlstr); //数据源             
        
        String jsonData = wjz_tools.ToJson(dt, dt.Rows.Count, new List<string> { "CCRQ", "JDRQ" });
        context.Response.Write(jsonData);
        context.Response.End();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }
}