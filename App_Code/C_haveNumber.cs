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
/// <summary>
///C_haveNumber 的摘要说明
/// </summary>
public class C_haveNumber
{
    public string userName;//用户名
    public string Organization;//组织机构
    public string userlevel;//用户等级
    public string workItem;//工作任务
    public string workUrl;//工作表单链接
	public C_haveNumber()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}
    public int dtz_number()
    {
        int num=0;
        string sql = "";
        sql += "select * from T_PLANRUN_DTZ where 1=1 and BUFFER=0";
        if (userlevel == "2"&& Organization == "规划室")
        {
            sql = sql + "and (PLANFLAG=0 or PLANFLAG=1)";
        }
        if (userlevel == "2" && Organization == "矿区室")
        {
            sql = sql + "and (PLANFLAG=2 OR PLANFLAG_DESIGN=1)";
        }
        if (userlevel == "2" && Organization == "设计室")
        {
            sql = sql + "and PLANFLAG_DESIGN=0";
        }
        if (userlevel == "4")
        {
            sql = sql + "and (CHECKSTATE=1 OR CHECKSTATE is null)";
        }
        DB db = new DB();
        DataTable dt = db.GetDataTable(sql);
        //增加列
        dt.Columns.Add("workitem");
        dt.Columns.Add("workurl");
        CTaskList tl = new CTaskList();
        tl.userName = userName;
        tl.userlevel = userlevel;
        tl.Organization = Organization;

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            tl = tl.getSingleTask(dt.Rows[i]);
            dt.Rows[i]["workitem"] = tl.workItem;
            dt.Rows[i]["workurl"] = tl.workUrl;
            if (dt.Rows[i]["workitem"].ToString() != "结束" && dt.Rows[i]["workitem"].ToString() != "等待中" && dt.Rows[i]["workitem"].ToString() != "退回方案")
                num++;
        }
        return num;
    }
    public int zcq_number()
    {
        int num = 0;
        string sql = "";
        if (userlevel == "2")
            sql += "select * from T_PLANRUN_ZCQ where 1=1 and BUFFER=0";
        else
            sql += "select * from T_PLANRUN_ZCQ where SOLUCHIEF='" + userName + "' and BUFFER=0";
        //if (Organization == "矿区室")
        //    sql += " and FLAGS=2";
        //else if (Organization == "规划室")
        //    sql += " and FLAGS=1";
        //else
        //    sql += " and FLAGS=0";
        DB db = new DB();
        DataTable dt = db.GetDataTable(sql);
        //增加列
        dt.Columns.Add("workitem");
        dt.Columns.Add("workurl");
        CTaskList tl = new CTaskList();
        tl.userName = userName;
        tl.userlevel = userlevel;
        tl.Organization = Organization;

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            tl = tl.getSingleTask_longplan(dt.Rows[i]);
            dt.Rows[i]["workitem"] = tl.workItem;
            dt.Rows[i]["workurl"] = tl.workUrl;
            if (dt.Rows[i]["workitem"].ToString() != "结束" && dt.Rows[i]["workitem"].ToString() != "等待中")
                num++;
        }
        return num;

    }
    public int bdtz_number()
    {
        int num = 0;
        string sql = "";
        if ((userlevel == "2" || userlevel == "8") && (Organization == "设计室" || Organization == "规划室" || Organization == "综合室"))
            sql += "select * from T_PLANRUN_BDTZ  where BUFFER=0";
        else
            sql += "select * from T_PLANRUN_BDTZ where 1=0";
        DB db = new DB();
        DataTable dt = db.GetDataTable(sql);
        //增加列
        dt.Columns.Add("workitem");
        dt.Columns.Add("workurl");
        CTaskList tl = new CTaskList();
        tl.userName = userName;
        tl.userlevel = userlevel;
        tl.Organization = Organization;

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            tl = tl.getSingleTask_bdtz(dt.Rows[i]);
            dt.Rows[i]["workitem"] = tl.workItem;
            dt.Rows[i]["workurl"] = tl.workUrl;
            if (dt.Rows[i]["workitem"].ToString() != "结束" && dt.Rows[i]["workitem"].ToString() != "等待中")
                num++;
        }
        return num;

    }
}
