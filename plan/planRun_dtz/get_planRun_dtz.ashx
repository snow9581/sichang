<%@ WebHandler Language="C#" Class="get_planRun_dtz" %>

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

public class get_planRun_dtz : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string userlevel = Convert.ToString(context.Session["userlevel"]);
        string username = Convert.ToString(context.Session["username"]);
        string DM = Convert.ToString(context.Session["dm"]);
        int page = Convert.ToInt32(context.Request.Params["page"]);//页索引
        int rows = Convert.ToInt32(context.Request.Params["rows"]);
        string buf = context.Request.Params["buf"];
        ///条件查询 begin
        string PName = context.Request.Params["PName"];
        string SoluChief = context.Request.Params["SoluChief"];
        string PNumber = context.Request.Params["PNumber"];
        string DESICHIEF = context.Request.Params["DESICHIEF"];
        string stage = context.Request.Params["stage"];
        string QSentence = " where 1=1 and BUFFER="+buf;  //定义一个查询子句，当有一个或多个条件不为空时，使用该子句

        if (PName != null && PName != "")
        {
            QSentence = QSentence + " and PNAME like '%" + T.preHandleSql(PName) + "%'";
        }
        if (SoluChief != null && SoluChief != "")
        {
            QSentence = QSentence + " and SOLUCHIEF like '%" + T.preHandleSql(SoluChief) + "%'";
        }
        if (DESICHIEF != null && DESICHIEF != "")
        {
            QSentence = QSentence + " and DESICHIEF like '%" + T.preHandleSql(DESICHIEF) + "%'";
        }
        if (PNumber != null && PNumber != "")
        {
            QSentence = QSentence + " and PNUMBER like '%" + T.preHandleSql(PNumber) + "%'";
        }
        if (stage != null && stage != "")
        {
            QSentence = QSentence + sql_stage(stage);
        }
        //if (userlevel == "6"&& DM != "设计室")
        //{
        //    QSentence = QSentence + "and (SOLUCHIEF ='" + username + "' OR MAJORPROOFREADER='" + username + "' OR BUDGETCHIEF='" + username + "')";
        //}
        //if (DM == "规划室")
        //{
        //    QSentence = QSentence + "and (PLANFLAG=0 or PLANFLAG=1)";
        //}
        //if (DM == "矿区室")
        //{
        //    QSentence = QSentence + "and PLANFLAG=2 ";
        //}
        string type = context.Request.Params["type"];
        if (type != null && type != "")
        {
            if (type == "gh")
                QSentence += " and (PLANINVESMENT IS NULL or PNUMBER is null)";
            if (type == "sj")
                QSentence += " and ((FINALSOLUTIONFILE IS NOT NULL and PNUMBER is not null and DESICONDITIONTABLE is not null) or (PLANFLAG = '1')) and BLUEGRAPHARRIVALDATE IS NULL";
        }
        
        string sqlstr = "select * from(select t.*,rownum rn from(select * from T_PLANRUN_DTZ " + QSentence + " Order By INITDATE DESC) t where rownum<=" + page * rows + ") where rn>" + (page - 1) * rows + " ";
        ///条件查询 end

        string sql = "select count(*) from T_PLANRUN_DTZ" + QSentence;
        
        DB db = new DB();       
        int Count = db.GetCount(sql);//获取总条数
        DataTable dt = db.GetDataTable(sqlstr); //获取当前页的数据
         
        //增加列
        dt.Columns.Add("workitem");
        dt.Columns.Add("workurl");
        
        CTaskList tl = new CTaskList();
        tl.userName = username;
        tl.userlevel = userlevel;
        tl.Organization = DM;
        
        for (int i = 0; i < dt.Rows.Count;i++ )
        {
            tl = tl.getSingleTask(dt.Rows[i]);
            dt.Rows[i]["workitem"] = tl.workItem;
            dt.Rows[i]["workurl"] = tl.workUrl;
        }

        dt = data_up(dt);
        String jsonData = T.ToJson(dt,Count);
        context.Response.Write(jsonData);
        context.Response.End();
    }
  
    public bool IsReusable {
        get {
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