using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Instrument_TableShow : BasePage
{
    string FROMID;
    DataTable table2;
    //1、申请结束，待审核
    //2、审核结束，待审批
    //3、审批结束，待确认
    //4、确认结束，待填写
    //5、完成
    //6、拒绝
    protected void Page_Load(object sender, EventArgs e)
    {
       /* try
        {
            string x = Session["DM"].ToString();
        }
        catch
        {
            Response.Write("<script>alert('请重新登录');parent.location.href='../login.aspx';</script>");
            Response.End();
        }*/
        FROMID=Context.Request.Params["FROMID"];
        DB db = new DB();
        DataTable table1 = db.GetDataTable("select * from T_Table where FROMID=" + FROMID);
        table2 = db.GetDataTable("select * from T_Instrument where FROMID=" + FROMID);
        Label5.Text = "审核人：" + table2.Rows[0]["SHR"].ToString();
        Label6.Text = "批准人：" + table2.Rows[0]["PZR"].ToString();

        for (int i = table1.Rows.Count%10; i < 10; i++)
        {
            DataRow dr = table1.NewRow();
            table1.Rows.Add(dr);
        }
        table1.Columns.Add("XH", typeof(int));
        for (int i = 0; i < table1.Rows.Count; i++)
            table1.Rows[i]["XH"] = (i + 1);

        GridView1.DataSource = table1;
        GridView1.DataBind();
        BM.Text = table2.Rows[0][1].ToString();
        TIME.Text = "填报日期：" + Convert.ToDateTime(table2.Rows[0][2].ToString()).ToString("yyyy-MM-dd");
        DEPARTMENT.Text = "单位：" + table2.Rows[0][5].ToString();
        string userlevel = Session["userlevel"].ToString();
        if (userlevel == "2")
        {
            if (table2.Rows[0]["STATE"].ToString() != "1")
            {
                Button1.Visible = false;
                Button3.Visible = false;
            }
        }
        else if (userlevel == "4")
        {
            if (table2.Rows[0]["STATE"].ToString() != "2")
            {
                Button1.Visible = false;
                Button3.Visible = false;
            }
        }
        else if (userlevel == "0")
        {
            if (table2.Rows[0]["STATE"].ToString() != "3")
            {
                Button1.Visible = false;
                Button3.Visible = false;
            }
        }
        else
        {
            Button1.Visible = false;
            Button3.Visible = false;
        }
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        int start = 10 * e.NewPageIndex -9;
        int end = 10 * e.NewPageIndex;
        DB db = new DB();
        DataTable table1 = db.GetDataTable("select * from T_Table where FROMID=" + FROMID);
        for (int i = table1.Rows.Count%11; i < 10; i++)
        {
            DataRow dr = table1.NewRow();
            table1.Rows.Add(dr);
        }
        table1.Columns.Add("XH", typeof(int));
        for (int i = 0; i < table1.Rows.Count; i++)
            table1.Rows[i]["XH"] = (i + 1);
        DataTable dt = table1.Clone();
        for (; start <= end; start++)
        {
            dt.Rows.Add(table1.Rows[start]);
        }
        GridView1.DataSource = dt;
        GridView1.DataBind();
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        string sql;
        if (Session["userlevel"].ToString() == "2")
            sql = "update T_Instrument set STATE='6',SHR='" + Session["username"].ToString() + "' where FROMID=" + FROMID;
        else if(Session["userlevel"].ToString()=="4")
            sql = "update T_Instrument set STATE='6',PZR='" + Session["username"].ToString() + "' where FROMID=" + FROMID;
        else
            sql = "update T_Instrument set STATE='6' where FROMID=" + FROMID;
        DB db = new DB();
        db.ExecuteSql(sql);
        Response.Write("<script>self.location.href = 'Instrument.aspx';</script>");
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Write("<script>self.location.href = 'Instrument.aspx';</script>");
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string NAME = Session["username"].ToString();
        string STATE;
        if (table2.Rows[0]["STATE"].ToString() == "1")
            STATE = "2";
        else if (table2.Rows[0]["STATE"].ToString() == "2")
            STATE = "3";
        else
            STATE = "4";
        string sql;
        if (Session["userlevel"].ToString() == "2")
            sql = "update T_Instrument set STATE='" + STATE + "',SHR='" + Session["username"].ToString() + "' where FROMID=" + FROMID;
        else if (Session["userlevel"].ToString() == "4")
            sql = "update T_Instrument set STATE='" + STATE + "',PZR='" + Session["username"].ToString() + "' where FROMID=" + FROMID;
        else
        {
            sql = "update T_Instrument set STATE='" + STATE + "' where FROMID=" + FROMID;
            InsertToQRD();
        }
        DB db = new DB();
        db.ExecuteSql(sql);
        Response.Write("<script>self.location.href = 'Instrument.aspx';</script>");
    }
    public void InsertToQRD()
    {
        DB db = new DB();
        DataTable dt = db.GetDataTable("select * from T_INSTRUMENT_QRD where 1=2");
        DataTable dt2 = db.GetDataTable("select * from T_TABLE where FROMID='" + FROMID + "'");
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
            dr["JDDJ"] = "";
            dr["JDFYHJ"] = "";
            dr["TSQKSM"] = dt2.Rows[i]["SM"].ToString();
            dt.Rows.Add(dr);
        }
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            string str_id = "select SEQ_Table.nextval from dual";
            string id = db.GetDataTable(str_id).Rows[0][0].ToString();
            string sql = "insert into T_INSTRUMENT_QRD (JLQJMC,GGXH,JLLB,JDWCSL,JDHGSL,JLQJSYDW,JLQJJDDW,JDDJ,JDFYHJ,TSQKSM,ID,FROMID) Values('" +
                dt.Rows[i]["JLQJMC"].ToString() + "','" + dt.Rows[i]["GGXH"].ToString() + "','" + dt.Rows[i]["JLLB"].ToString()
                + "','" + dt.Rows[i]["JDWCSL"].ToString() + "','" + dt.Rows[i]["JDHGSL"].ToString() + "','" + dt.Rows[i]["JLQJSYDW"].ToString()
                + "','" + dt.Rows[i]["JLQJJDDW"].ToString() + "','" + dt.Rows[i]["JDDJ"].ToString() + "','" + dt.Rows[i]["JDFYHJ"].ToString()
                + "','" + dt.Rows[i]["TSQKSM"].ToString() + "','" + id + "','" + FROMID + "')";
            db.ExecuteNonQuery(sql);
        }
    }
}