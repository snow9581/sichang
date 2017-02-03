<%@ WebHandler Language="C#" Class="get_Table" %>
//员工发起仪表检定时，选择完仪表后，开始进行仪表信息确认时加载所选择的仪表
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

public class get_Table : BaseHandler
{
    string DM;
    override public void AjaxProcess(HttpContext context)
    {
        DM = Convert.ToString(context.Session["dm"]);
        string IDs = context.Request.Params["ID"].ToString().Replace("'", "");//获取挑选仪表的ID集
        string[] ID = IDs.Split(new[] { ',' });
        DB db = new DB();
        string sql = "select * from T_METER where 1=0 ";
        if (ID.Length != 0)
        {
            for (int i = 0; i < ID.Length - 1; i++)
            {
                sql += " or ID=" + ID[i];
            }
        }
        DataTable dt = db.GetDataTable(sql);//获得所选仪表的信息
        string[] JLQJMC = GetStringArray(dt,2);
        string[] GGXH = GetStringArray(dt, 6);
        string[] JLLB = GetStringArray(dt, 1);
        string[] JDZQ = GetStringArray(dt, 12);
        string[] JDDJ = GetStringArray(dt, 10);
        string[] JDRQ = GetStringArray(dt, 14);
        string[] JDDW = GetStringArray(dt, 13);
        DataTable all_dt = Add(ID.Length-1, JLQJMC, GGXH, JLLB, JDZQ, JDDJ, JDRQ, JDDW);
        for (int i = 0; i < all_dt.Rows.Count; i++)//填写使用单位
        {
            all_dt.Rows[i]["SYDW"] = context.Session["dm"].ToString();
        }
        String jsonData = wjz_tools.ToJson(all_dt, all_dt.Rows.Count, new List<string> { "JDRQ" });
        context.Response.Write(jsonData);
        context.Response.End();
    }
    public string[] GetStringArray(DataTable dt, int num)//把表的某列所有信息转化为数组
    {
        List<String> str = new List<string>();
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            str.Add(dt.Rows[i][num].ToString());
        }
        return str.ToArray();
    }
    public DataTable Add(int count, string[] JLQJMC, string[] GGXH, string[] JLLB, string[] JDZQ, string[] JDDJ, string[] JDRQ, string[] JDDW)//将相同的仪表合并
    {
        string sql = "select * from T_METER_CHECK_SBB where 0=1";
        DB db = new DB();
        DataTable dt = db.GetDataTable(sql);
        for (int i = 0; i < count; i++)
        {
            int number = Exist(dt, JLQJMC[i], GGXH[i], JLLB[i], JDZQ[i], JDDJ[i], JDRQ[i]);
            if (number == -1)
            {
                DataRow dr = dt.NewRow();
                if (JLQJMC[i] != "")
                    dr["JLQJMC"] = JLQJMC[i];
                else
                    dr["JLQJMC"] = DBNull.Value;
                if (GGXH[i] != "")
                    dr["GGXH"] = GGXH[i];
                else
                    dr["GGXH"] = DBNull.Value;
                if (JLLB[i] != "")
                    dr["JLLB"] = JLLB[i];
                else
                    dr["JLLB"] = DBNull.Value;
                if (JDZQ[i] != "")
                    dr["JDZQ"] = JDZQ[i];
                else
                    dr["JDZQ"] = DBNull.Value;
                if (JDDW[i] != "")
                    dr["JDDW"] = JDDW[i];
                else
                    dr["JDDW"] = DBNull.Value;
                if (JDRQ[i] != "")
                    dr["JDRQ"] = JDRQ[i];
                else
                    dr["JDRQ"] = DBNull.Value;
                if (JDDJ[i] != "")
                    dr["JDDJ"] = JDDJ[i];
                else
                    dr["JDDJ"] = DBNull.Value;
                dr["SL"] = 1;
                dr["SYDW"] = DM;
                dr["JDFS"] = "送检";
                dr["E_JDFYHJ"] = DBNull.Value;
                dr["E_JDDJ"] = DBNull.Value;
                dt.Rows.Add(dr);
            }
            else
            {
                dt.Rows[i].ItemArray[5] = Convert.ToInt32(dt.Rows[i].ItemArray[5]) + 1;
                if (!dt.Rows[i].ItemArray[8].ToString().Contains(JDDW[i]))
                    dt.Rows[i].ItemArray[8] += "," + JDDW[i];
            }
        }
        return dt;
    }
    public int Exist(DataTable dt, string JLQJMC, string GGXH, string JLLB, string JDZQ, string JDDJ, string JDRQ)//指定信息在表中的第几行
    {
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (dt.Rows[i].ItemArray[0].ToString() == JLQJMC && dt.Rows[i].ItemArray[1].ToString() == GGXH && dt.Rows[i].ItemArray[2].ToString() == JLLB && dt.Rows[i].ItemArray[3] == JDZQ && dt.Rows[i].ItemArray[4] == JDDJ && dt.Rows[i].ItemArray[6] == JDRQ)
                return i;
        }
        return -1;
    }
    public bool IsReusable {
        get {
            return false;
        }
    }
}