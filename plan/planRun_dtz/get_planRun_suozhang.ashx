<%@ WebHandler Language="C#" Class="get_planRun_suozhang" %>

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
using System.Collections;
public class get_planRun_suozhang : BaseHandler
{ 
    public override void AjaxProcess(HttpContext context) {
        string userlevel = Convert.ToString(context.Session["userlevel"]);
        string username = Convert.ToString(context.Session["username"]);
        string DM = Convert.ToString(context.Session["dm"]);
        int page = Convert.ToInt32(context.Request.Params["page"]);//页索引
        int rows = Convert.ToInt32(context.Request.Params["rows"]);
        string buf = context.Request.Params["buf"];
        ///条件查询 begin

        string PYear = context.Request.Params["PYEAR"];
        string PSource = context.Request.Params["PSOURCE"];
        string PNumber = context.Request.Params["PNumber"];
        string stage = context.Request.Params["stage"];
        string QSentence = " where 1=1 and BUFFER=" + buf;  //定义一个查询子句，当有一个或多个条件不为空时，使用该子句

        if (PYear != null && PYear != "")
        {
            if(PYear!="其他")
                QSentence = QSentence + " and PNUMBER like 'S(" + T.preHandleSql(PYear) + ")%'";
            else
                QSentence = QSentence + " and (PNUMBER not like 'S%' or PNUMBER is null)";
        }
        if (PSource != null && PSource != "")
        {
            if (PYear != "其他")
                QSentence = QSentence + " and PSOURCE like '%" + T.preHandleSql(PSource) + "%'";
            else
                QSentence = QSentence + " and (PSOURCE not like '%房屋维修%' and PSOURCE not like '%安全隐患%' and PSOURCE not like '%环保工程%' and PSOURCE not like '%结余资金%' and PSOURCE not like '%老区改造%' and PSOURCE not like '%生产维修%' or PSOURCE is null)";
        }
        if (PNumber != null && PNumber != "")
        {
            QSentence = QSentence + " and PNUMBER like '%" + T.preHandleSql(PNumber) + "%'";
        }
        if (stage != null && stage != "")
        {
            QSentence = QSentence + sql_stage(stage);
        }
        string sqlstr = "select * from(select t.*,rownum rn from(select * from T_PLANRUN_DTZ " + QSentence + " Order By PNUMBER asc) t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + " ";
        ///条件查询 end

        string sql = "select count(*) from T_PLANRUN_DTZ" + QSentence;

        DB db = new DB();
        int Count = db.GetCount(sql);//获取总条数
        DataTable dt = db.GetDataTable(sqlstr); //获取当前页的数据

        //增加列
        dt.Columns.Add("workitem");
        dt.Columns.Add("CURRENTPROGRESS");

        CTaskList tl = new CTaskList();
        tl.userName = username;
        tl.userlevel = userlevel;
        tl.Organization = DM;

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            tl = tl.getSingleTask(dt.Rows[i]);
            dt.Rows[i]["workitem"] = tl.workItem;
            dt.Rows[i]["CURRENTPROGRESS"] = what_stage(dt.Rows[i]);
        }
        
        String jsonData = T.ToJson(dt, Count);
        context.Response.Write(jsonData);
        context.Response.End();
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
    //拼接按阶段查询的sql查询语句
    public string sql_stage(string stage)
    {
        Hashtable htStage = new Hashtable(); //创建一个Hashtable实例  
        htStage.Add("solution", "and ( PNUMBER is null or DESICONDITIONTABLE is null ) ");//添加key/value键值对  
        htStage.Add("design", " and PNUMBER is not null and DESICONDITIONTABLE is not null and WORKLOADSUBMITDATE_R is null ");
        htStage.Add("budget", " and WORKLOADSUBMITDATE_R is not null and PLANARRIVALDATE is null ");
        htStage.Add("graph", " and PLANARRIVALDATE is not null and BLUEGRAPHARRIVALDATE is null");
        htStage.Add("finished", " and BLUEGRAPHARRIVALDATE is not null and PNUMBER is not null and DESICONDITIONTABLE is not null ");

        return htStage[stage].ToString();
    }
    
    //判断数据行属于哪个阶段
    public string what_stage(DataRow dr)
    {
        if (dr["PNUMBER"].ToString() != "" && dr["DESICONDITIONTABLE"].ToString() != "" && dr["WORKLOADSUBMITDATE_R"].ToString() == "")
            return "初设阶段";
        else if (dr["WORKLOADSUBMITDATE_R"].ToString() != "" && dr["PLANARRIVALDATE"].ToString() == "")
            return "概算阶段";
        else if (dr["PLANARRIVALDATE"].ToString() != "" && dr["BLUEGRAPHARRIVALDATE"].ToString() == "")
            return "施工图阶段";
        else if (dr["DESICONDITIONTABLE"].ToString() == "" || dr["PNUMBER"].ToString() == "")
            return "方案阶段";
        else
            return "已完成";
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
        int[] up_low_low = new int[dt.Rows.Count];
        int p = 0;
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (dt.Rows[i]["workitem"].ToString() == "结束")
            {
                low[n] = i;
                n++;
            }
            else if (dt.Rows[i]["workitem"].ToString() == "等待中")
            {
                up_low_low[m] = i;
                m++;
            }
            else if (dt.Rows[i]["workitem"].ToString() == "退回方案")
            {
                up_low[p] = i;
                p++;
            }
            else
            {
                up[q] = i;
                q++;
            }
        }

        for (int i = 0; i < q; i++)
        {
            new_dt.ImportRow(dt.Rows[up[i]]);
        }
        for (int i = 0; i < p; i++)
        {
            new_dt.ImportRow(dt.Rows[up_low[i]]);
        }
        for (int i = 0; i < m; i++)
        {
            new_dt.ImportRow(dt.Rows[up_low_low[i]]);
        }

        for (int i = 0; i < n; i++)
        {
            new_dt.ImportRow(dt.Rows[low[i]]);
        }
        return new_dt;
    }

}