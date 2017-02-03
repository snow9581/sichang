<%@ WebHandler Language="C#" Class="get_long_plan" %>

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

public class get_long_plan : BaseHandler 
{
    public override void AjaxProcess(HttpContext context)
    {
        string userlevel = Convert.ToString(context.Session["userlevel"]);
        string username = Convert.ToString(context.Session["username"]);
        string DM = Convert.ToString(context.Session["dm"]);
        string buf = context.Request.Params["buf"];
        int page = Convert.ToInt32(context.Request.Params["page"]);//页索引
        int rows = Convert.ToInt32(context.Request.Params["rows"]);

        ///条件查询 begin
        string PName = context.Request.Params["PName"];
        string SoluChief = context.Request.Params["SoluChief"];

        string QSentence = " where 1=1 and BUFFER=" + buf;  //定义一个查询子句，当有一个或多个条件不为空时，使用该子句

        if (PName != null && PName != "")
        {
            QSentence = QSentence + " and PNAME like '%" + T.preHandleSql(PName) + "%'";

        }
        if (SoluChief != null && SoluChief != "")
        {
            QSentence = QSentence + " and SOLUCHIEF like '%" + T.preHandleSql(SoluChief) + "%'";
        }
        //if (DM == "规划室"&&userlevel=="6")
        //    QSentence = QSentence + " and SOLUCHIEF='" + username + "'";
        //if (DM == "矿区室" && userlevel == "6")
        //    QSentence = QSentence + " and SOLUCHIEF='" + username + "'";
        string sqlstr;
        string sql = "select PID,PNAME,SOLUCHIEF,ESTIINVESTMENT,to_char(SOLUCOMPDATE_P,'yyyy-mm-dd') AS SOLUCOMPDATE_P,to_char(SOLUCOMPDATE_R,'yyyy-mm-dd') AS SOLUCOMPDATE_R" +
                ",to_char(INSTCHECKDATE_P,'yyyy-mm-dd') AS INSTCHECKDATE_P,to_char(INSTCHECKDATE_R,'yyyy-mm-dd') AS INSTCHECKDATE_R,to_char(FACTCHECKDATE_P,'yyyy-mm-dd') AS FACTCHECKDATE_P" +
                ",to_char(FACTCHECKDATE_R,'yyyy-mm-dd') AS FACTCHECKDATE_R,to_char(SOLUSUBMITDATE,'yyyy-mm-dd') AS SOLUSUBMITDATE,to_char(SOLUCHECKDATE,'yyyy-mm-dd') AS SOLUCHECKDATE" +
                ",to_char(SOLUADVICEREPLYDATE,'yyyy-mm-dd') AS SOLUADVICEREPLYDATE,to_char(SOLUAPPROVEDATE,'yyyy-mm-dd') AS SOLUAPPROVEDATE,DRAFTSOLUTIONFILE,INSTAPPRSOLUTIONFILE,FACTAPPRSOLUTIONFILE,FINALSOLUTIONFILE,APPROVEFILE FROM T_PLANRUN_ZCQ" + QSentence;
        //if (DM == "矿区室")
        //    sql += " and FLAGS=2";
        //else
        //    sql += "and FLAGS=1";
        DB db = new DB();       
        sqlstr = "select * from(select t.*,rownum rn from("+sql+") t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + "";
        
        int Count = db.GetCount(sql);//获取总条数S
        DataTable dt = db.GetDataTable(sqlstr); //获取当前页的数据                     
        
        //增加列
        dt.Columns.Add("workurl");
        dt.Columns.Add("workitem"); 

        CTaskList tl = new CTaskList(userlevel,DM);
        tl.userName = username;      
        for (int i = 0; i < dt.Rows.Count;i++ )
        {
            tl = tl.getSingleTask_longplan(dt.Rows[i]);
            dt.Rows[i]["workitem"] = tl.workItem;
            dt.Rows[i]["workurl"] = tl.workUrl;
            
        }
        dt = data_up(dt);
        String jsonData = T.ToJson(dt,dt.Rows.Count);
        context.Response.Write(jsonData);
        context.Response.End();
    }

    //将表内未完成的项目置顶
    public DataTable data_up(DataTable dt)
    {
        DataTable new_dt=dt.Copy();
        new_dt.Clear();
        int[] up=new int[dt.Rows.Count];
        int m = 0;
        int[] low=new int[dt.Rows.Count];
        int n = 0;
        int[] up_low = new int[dt.Rows.Count];
        int q = 0;
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (dt.Rows[i]["workitem"].ToString() == "结束")
            {
                low[n] = i;
                n++;
            }
            else if (dt.Rows[i]["workitem"].ToString() == "进行中")
            {
                up[m] = i;
                m++;
            }
            else
            {
                up_low[q] = i;
                q++;
            }   
        }
        for (int i = 0; i < m; i++)
        {
            new_dt.ImportRow(dt.Rows[up[i]]);
        }
        for (int i = 0; i < q; i++)
        {
            new_dt.ImportRow(dt.Rows[up_low[i]]);
        }
        for (int i = 0; i < n; i++)
        {
            new_dt.ImportRow(dt.Rows[low[i]]);
        }
        return new_dt;
    }
        
    //清理功能，不显示1年前的数据
    //public DataTable clean(DataTable dt)
    //{
    //    DataTable new_dt = new DataTable();
    //    for(int i=0;i<dt.Rows.Count;i++)
    //        if()
    //}

    //将整个表单里的year/month/day型日期转化为year-month-day型日期
    public DataTable change_time_all(DataTable dt)
    {
        DataTable new_dt = dt.Copy();
        for (int i = 0; i < new_dt.Rows.Count; i++)
            new_dt.Rows[i]["SOLUCOMPDATE_P"] = change_time(new_dt.Rows[i]["SOLUCOMPDATE_P"].ToString());
            //for (int j = 0; j < new_dt.Rows[i].ItemArray.Length; j++)
            //    if (j > 3 || j < 14)
            //        new_dt.Rows[i].ItemArray[j] = change_time(dt.Rows[i].ItemArray[j].ToString());
                    //dt.Rows[i].ItemArray[j] = "11";
        return new_dt;
                
    }
    //将year/month/day型日期转化为year-month-day型日期
    public string change_time(string str)
    {
        string year = "";
        string month = "";
        string day = "";
        int type = 1;
        for (int i = 0; i < str.Length; i++)
        {
            if (type == 1 && str[i] != '/')
                year += str[i];
            if (type == 2 && str[i] != '/')
                month += str[i];
            if (type == 3 && str[i] != '/')
                day += str[i];
            if (str[i] == '/')
                type++;
            if (str[i] == ' ')
                break;
        }
        if (month.Length == 1)
            month = "0" + month;
        if (day.Length == 1)
            day = "0" + day;
        return year + "-" + month + "-" + day;
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}