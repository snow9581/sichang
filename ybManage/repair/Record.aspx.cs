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

public partial class ybManage_repair_Record : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string ID = Context.Session["ID"].ToString();
        DB db = new DB();
        DataTable dt = db.GetDataTable("select * from T_INSTRUREPAIR where ID=" + ID);
        DW.Value = dt.Rows[0]["DW"].ToString();
        YQYBMC.Value = dt.Rows[0]["YQYBMC"].ToString();
        GGXH.Value = dt.Rows[0]["GGXH"].ToString();
        AZWZ.Value = dt.Rows[0]["AZWZ"].ToString();
        BH.Value = dt.Rows[0]["BH"].ToString();
        WXLB.Value = dt.Rows[0]["WXLB"].ToString();
        WXDW.Value = "规划设计研究所";
        WXR2.Value = dt.Rows[0]["WXR"].ToString();
        if (dt.Rows[0]["WXSJ"].ToString() != ""||Session["userlevel"].ToString()!="1")
        {
            GZXX.Text = dt.Rows[0]["GZXX2"].ToString();
            WXNR.Text = dt.Rows[0]["WXNR"].ToString();
            PJYYQK.Text = dt.Rows[0]["PJYYQK"].ToString();
            WXJG.Text = dt.Rows[0]["WXJG"].ToString();
            JSY.Value = dt.Rows[0]["JSY"].ToString();
            RQ.Value = dt.Rows[0]["WXSJ"].ToString();
            DW.Disabled = true;
            YQYBMC.Disabled = true;
            GGXH.Disabled = true;
            AZWZ.Disabled = true;
            BH.Disabled = true;
            WXLB.Disabled = true;
            GZXX.Enabled = false;
            WXNR.Enabled = false;
            PJYYQK.Enabled = false;
            WXJG.Enabled = false;
            WXDW.Disabled = true;
            WXR2.Disabled = true;
            JSY.Disabled = true;
            RQ.Disabled = true;
            Button1.Visible = false;
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        DB db = new DB();
        string sql = "update T_INSTRUREPAIR set STATE='3',GZXX2='" + GZXX.Text + "',WXNR='" + WXNR.Text +
            "',PJYYQK='" + PJYYQK.Text + "',WXJG='" + WXJG.Text + "',WXDW='" + WXDW.Value +
            "',WXR2='" + WXR2.Value + "',JSY='" + JSY.Value + "',WXSJ='" + RQ.Value + "' where ID=" + Session["ID"].ToString();
        db.ExecuteSQL(sql);
        Response.Write("<script>alert('提交完成');</script>");
        Response.Write("<script>location.href='show_Repair.aspx';</script>");
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Write("<script>location.href='show_Repair.aspx';</script>");
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        DB db = new DB();
        string sql = "update T_INSTRUREPAIR set STATE='3',GZXX2='" + GZXX.Text + "',WXNR='" + WXNR.Text +
            "',PJYYQK='" + PJYYQK.Text + "',WXJG='" + WXJG.Text + "',WXDW='" + WXDW.Value +
            "',WXR2='" + WXR2.Value + "',JSY='" + JSY.Value + "',WXSJ='" + RQ.Value + "' where ID=" + Session["ID"].ToString();
        db.ExecuteSQL(sql);
        //sql="update T"
        Response.Write("<script>alert('提交完成');</script>");
        Response.Write("<script>location.href='show_Repair.aspx';</script>");
    }
}