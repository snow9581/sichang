<%@ WebHandler Language="C#" Class="get_planRun_bdtz" %>

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
    
public class get_planRun_bdtz : BaseHandler
{

    public override void AjaxProcess(HttpContext context)
    {
        string userlevel = Convert.ToString(context.Session["userlevel"]);
        string organization = Convert.ToString(context.Session["dm"]);
        string username = Convert.ToString(context.Session["username"]);
        string buf = context.Request.Params["buf"];
        int page = Convert.ToInt32(context.Request.Params["page"]);//页索引
        int rows = Convert.ToInt32(context.Request.Params["rows"]);

        ///条件查询 begin
        string PName = context.Request.Params["PNAME"];
        string SoluChief = context.Request.Params["SOLUCHIEF"];
        string PNumber = context.Request.Params["PNUMBER"];

        string QSentence = " where 1=1 and BUFFER="+buf;  //定义一个查询子句，当有一个或多个条件不为空时，使用该子句

        if (PName != null && PName != "")
        {
            QSentence = QSentence + " and PNAME like '%" + T.preHandleSql(PName) + "%'";

        }
        if (SoluChief != null && SoluChief != "")
        {
            QSentence = QSentence + " and SOLUCHIEF like '%" + T.preHandleSql(SoluChief) + "%'";
        }
        if (PNumber != null && PNumber != "")
        {
            QSentence = QSentence + " and PNUMBER like '%" + T.preHandleSql(PNumber) + "%'";
        }

        string sqlstr = "select PID,PNUMBER,PNAME,SOLUCHIEF,to_char(YCZLSUBMITDATE,'yyyy-mm-dd') AS YCZLSUBMITDATE,to_char(CYZLSUBMITDATE,'yyyy-mm-dd') AS CYZLSUBMITDATE,to_char(DMZLDELEGATEDATE,'yyyy-mm-dd') AS DMZLDELEGATEDATE,to_char(SOLUCOMPDATE_P,'yyyy-mm-dd') AS SOLUCOMPDATE_P," +
            "to_char(SOLUCOMPDATE_R,'yyyy-mm-dd hh24:mi:ss') AS SOLUCOMPDATE_R,to_char(SOLUCHECKDATE_P,'yyyy-mm-dd') AS SOLUCHECKDATE_P,to_char(SOLUCHECKDATE_R,'yyyy-mm-dd hh24:mi:ss') AS SOLUCHECKDATE_R," +
            "to_char(DESISUBMITDATE,'yyyy-mm-dd') AS DESISUBMITDATE,to_char(INITIALDESISUBMITDATE_P,'yyyy-mm-dd') AS INITIALDESISUBMITDATE_P,to_char(INITIALDESISUBMITDATE_R,'yyyy-mm-dd hh24:mi:ss') AS INITIALDESISUBMITDATE_R," +
            "to_char(BLUEGRAPHDOCUMENT_P,'yyyy-mm-dd') AS BLUEGRAPHDOCUMENT_P,to_char(BLUEGRAPHDOCUMENT_R,'yyyy-mm-dd hh24:mi:ss') AS BLUEGRAPHDOCUMENT_R,BLUEGRAPHARRIVALDATE,REMARK" + 
            " from(select t.*,rownum rn from(select * from T_PLANRUN_BDTZ " + QSentence + " order by newitemdate desc) t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + "";

        ///条件查询 end

        string sql = "select count(*) from T_PLANRUN_BDTZ" + QSentence;

        DB db = new DB();
        int Count = db.GetCount(sql);//获取总条数
        DataTable dt = db.GetDataTable(sqlstr); //获取当前页的数据                     

        //增加列
        dt.Columns.Add("workitem");
        dt.Columns.Add("workurl");

        CTaskList tl = new CTaskList();
        tl.Organization = organization;
        tl.userlevel = userlevel;

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            tl = tl.getSingleTask_bdtz(dt.Rows[i]);
            dt.Rows[i]["workitem"] = tl.workItem;
            dt.Rows[i]["workurl"] = tl.workUrl;

        }
        dt = data_up(dt);
        String jsonData = T.ToJson(dt, Count);
        context.Response.Write(jsonData);
        context.Response.End();

    }

    //将表内未完成的项目置顶
    public DataTable data_up(DataTable dt)
    {
        DataTable new_dt = dt.Copy();
        new_dt.Clear();
        int[] up = new int[dt.Rows.Count];
        int m = 0;
        int[] low = new int[dt.Rows.Count];
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

    ////将项目按时间排序、
    //public DataTable data_sort(DataTable dt)
    //{
    //    DataTable new_dt = dt.Copy();
    //    new_dt.Clear();
    //    string[] datesotr1 = new string[dt.Rows.Count];
    //    int a = 0;
    //    string[] datesotr2 = new string[dt.Rows.Count];
    //    int b = 0;
    //    string[] datesotr3 = new string[dt.Rows.Count];
    //    int c = 0;
    //    string time="";
    //    for (int i = 0; i < dt.Rows.Count; i++)
    //    {
    //        if (dt.Rows[i]["workitem"].ToString() == "结束")
    //        {
    //            datesotr1[a] = dt.Rows[i]["newitemdate"].ToString();
    //            a++;
    //         }
    //        else if (dt.Rows[i]["workitem"].ToString() == "进行中")
    //        {
    //            datesotr1[b] = dt.Rows[i]["newitemdate"].ToString();
    //            b++;
    //        }
    //        else
    //        {
    //            datesotr1[c] = dt.Rows[i]["newitemdate"].ToString();
    //            c++;
    //        }
    //    }
    //    for (int i = 0; i < a; i++)
    //    {
    //        for (int j = i; j < a; j++)
    //        {
    //            if (DateTime.Parse(datesotr1[i]) > DateTime.Parse(datesotr1[j]))
    //                time=datesotr1[i];
    //                datesotr1[i] = datesotr1[j];
    //                datesotr1[j]=time;
    //        }
    //    }
    //    for (int i = 0; i < b; i++)
    //    {
    //        for (int j = i; j < b; j++)
    //        {
    //            if (DateTime.Parse(datesotr2[i]) > DateTime.Parse(datesotr2[j]))
    //                time = datesotr2[i];
    //                datesotr2[i] = datesotr2[j];
    //                datesotr2[j] = time;
    //        }
    //    }
    //    for (int i = 0; i < c; i++)
    //    {
    //        for (int j = i; j < c; j++)
    //        {
    //            if (DateTime.Parse(datesotr3[i]) > DateTime.Parse(datesotr3[j]))
    //                time = datesotr3[i];
    //                datesotr3[i] = datesotr3[j];
    //                datesotr3[j] = time;
    //        }
    //    }
    //        return new_dt;
    //}
    
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}