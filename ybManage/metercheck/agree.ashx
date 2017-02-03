<%@ WebHandler Language="C#" Class="agree" %>
//审核人通过，批准人通过，管理科通过时执行
using System;
using System.Web;
using System.Data;
public class agree : BaseHandler {

    override public void AjaxProcess(HttpContext context)
    {
        string fromid = context.Request.Params["FROMID"].ToString();
        string NAME = context.Session["username"].ToString();
        string STATE;
        
        DB db = new DB();
        DataTable dt = db.GetDataTable("select * from T_METER_CHECK where ID=" + fromid);
        if (dt.Rows[0]["STATE"].ToString() == "1")//更新流程状态
            STATE = "2";
        else if (dt.Rows[0]["STATE"].ToString() == "2")
            STATE = "3";
        else
            STATE = "4";
        string sql;
        
        if (dt.Rows[0]["STATE"].ToString() == "1")
            sql = "update T_METER_CHECK set STATE='" + STATE + "',SHR='" + context.Session["username"].ToString() + "' where ID=" + fromid;
        else if (dt.Rows[0]["STATE"].ToString() == "2")
            sql = "update T_METER_CHECK set STATE='" + STATE + "',PZR='" + context.Session["username"].ToString() + "' where ID=" + fromid;
        else
        {
            sql = "update T_METER_CHECK set STATE='" + STATE + "' where ID=" + fromid;
            InsertToQRD(fromid);//管理科同意时同时创建确认单
        }
        db.ExecuteSql(sql);
        context.Response.Write("1");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }
    public void InsertToQRD(string FROMID)
    {
        DB db = new DB();
        DataTable dt = db.GetDataTable("select * from T_METER_CHECK_QRD where 1=2");
        DataTable dt2 = db.GetDataTable("select * from T_METER_CHECK_SBB where FROMID='" + FROMID + "'");
        for (int i = 0; i < dt2.Rows.Count; i++)
        {
            DataRow dr = dt.NewRow();
            dr["JLQJMC"] = dt2.Rows[i]["JLQJMC"].ToString();
            dr["GGXH"] = dt2.Rows[i]["GGXH"].ToString();
            dr["JLLB"] = dt2.Rows[i]["JLLB"].ToString();
            dr["JDWCSL"] = dt2.Rows[i]["SL"].ToString();
            dr["JDHGSL"] = dt2.Rows[i]["SL"].ToString();
            dr["JLQJSYDW"] = dt2.Rows[i]["SYDW"].ToString();
            dr["JLQJJDDW"] = dt2.Rows[i]["JDDW"].ToString();
            dr["JDDJ"] = dt2.Rows[i]["E_JDDJ"].ToString();
            dr["JDFYHJ"] = dt2.Rows[i]["E_JDFYHJ"].ToString();
            dr["TSQKSM"] = dt2.Rows[i]["SM"].ToString();
            dt.Rows.Add(dr);
        }
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            string str_id = "select SEQ_Table.nextval from dual";
            string id = db.GetDataTable(str_id).Rows[0][0].ToString();
            string sql = "insert into T_METER_CHECK_QRD (TYPE,JLQJMC,GGXH,JLLB,JDWCSL,JDHGSL,JLQJSYDW,JLQJJDDW,JDDJ,JDFYHJ,TSQKSM,ID,FROMID) Values('1','" +
                dt.Rows[i]["JLQJMC"].ToString() + "','" + dt.Rows[i]["GGXH"].ToString() + "','" + dt.Rows[i]["JLLB"].ToString()
                + "','" + dt.Rows[i]["JDWCSL"].ToString() + "','" + dt.Rows[i]["JDHGSL"].ToString() + "','" + dt.Rows[i]["JLQJSYDW"].ToString()
                + "','" + dt.Rows[i]["JLQJJDDW"].ToString() + "','" + dt.Rows[i]["JDDJ"].ToString() + "','" + dt.Rows[i]["JDFYHJ"].ToString()
                + "','" + dt.Rows[i]["TSQKSM"].ToString() + "','" + id + "','" + FROMID + "')";
            db.ExecuteNonQuery(sql);
        }
    }
}