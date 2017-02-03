using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
//1审核  2审批  3结束  4驳回  5填记录单
public partial class ybManage_repair_input_Repair : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DW.Value = Session["KM"].ToString();
            //初始化信息
            string x = Context.Request.Params["ID"];
            if (x != null)
            {
                int ID = Convert.ToInt32(x);
                DB db = new DB();
                DataTable dt = db.GetDataTable("select * from T_INSTRUREPAIR where ID=" + ID);
                DW.Value = dt.Rows[0]["DW"].ToString();
                WXLB.Value = dt.Rows[0]["WXLB"].ToString();
                azwz1.Value = dt.Rows[0]["AZWZ"].ToString();
                yqybmc1.Value = dt.Rows[0]["YQYBMC"].ToString();
                ggxh1.Value = dt.Rows[0]["GGXH"].ToString();
                RQ.Value = Convert.ToDateTime(dt.Rows[0]["RQ"].ToString()).ToShortDateString();
                TextBox1.Text = dt.Rows[0]["GZXX"].ToString();
                SHR.InnerText = "审核人：" + dt.Rows[0]["SHR"].ToString();
                SPR.InnerText = "审批人：" + dt.Rows[0]["SPR"].ToString();
                AllDisable();
                Session["ID"] = ID;
                Session["DR"] = dt.Rows[0];
            }
            else
            {
                int ID = -1;
                Session["ID"] = ID;
            }
            //判断身份
            SetControls();
        }
    }
    public int HaveState()
    {
        if (Session["userlevel"].ToString() == "1")
            return 1;
        else if (Session["userlevel"].ToString() == "5")
            return 2;
        else
            return 3;
    }
    public void SetControls()
    {
        DB db = new DB();
        //设置按钮文本
        int state = HaveState();
        DataRow dr = (DataRow)Session["DR"];
        int ID = (int)Session["ID"];
        if (state == 1)
        {
            if (ID == -1)
            {
                Button1.Text = "清空";
                Button2.Text = "提交";
            }
            else if(dr["STATE"].ToString()=="1"||dr["STATE"].ToString()=="2")
            {
                Button1.Visible = false;
                Button2.Visible = false;
            }
            else if (dr["STATE"].ToString() == "5")
            {
                Button1.Visible = false;
                Button2.Visible = false;
                Record.Visible = true;
                Record.InnerText = "填单";
            }
            else
            {
                Button1.Visible = false;
                Button2.Visible = false;
                Record.Visible = true;
                Record.InnerText = "查单";
            }
        }
        else if (state == 2)
        {
            if (dr["STATE"].ToString() == "1")
            {
                Button1.Text = "通过";
                Button2.Text = "驳回";
            }
            else if (dr["STATE"].ToString() == "3" || dr["STATE"].ToString() == "4")
            {
                Button1.Visible = false;
                Button2.Visible = false;
                Record.Visible = true;
                Record.InnerText = "查单";
            }
            else
            {
                Button1.Visible = false;
                Button2.Visible = false;
                Record.Visible = true;
                Record.InnerText = "查单";
            }
        }
        else
        {
            if (dr["STATE"].ToString() == "2")
            {           
                Button1.Text = "通过";
                Button2.Text = "驳回";
                Label1.Visible = true;
                WXR.Visible = true;
            }
            else if (dr["STATE"].ToString() == "3" || dr["STATE"].ToString() == "4")
            {
                Button1.Visible = false;
                Button2.Visible = false;
                Record.Visible = true;
                Record.InnerText = "查单";
            }
            else
            {
                Button1.Visible = false;
                Button2.Visible = false;
                Record.Visible = true;
                Record.InnerText = "查单";
            }

        }
    }
    public void AllDisable()
    {
        WXLB.Disabled = true;
        AZWZ.Disabled = true;
        YQYBMC.Disabled = true;
        GGXH.Disabled = true;
        RQ.Disabled = true;
        TextBox1.Enabled = false;
    }
    public void Close()
    {
        Response.Write("<script>location.href='show_Repair.aspx';</script>");
    }
    public void Agree()
    {
        string sql;
        int ID = (int)Session["ID"];
        if (Session["userlevel"].ToString() == "5")
            sql = "update T_INSTRUREPAIR set SHR='" + Session["username"].ToString() + "',state='2' where id=" + ID;
        else
        {
            sql = "update T_INSTRUREPAIR set SPR='" + Session["username"].ToString() + "',state='5',WXR='" + WXR.Value + "' where id=" + ID;
        }
        DB db = new DB();
        db.ExecuteSQL(sql);
        Response.Write("<script>alert('提交成功');</script>");
        Close();
    }
    public void Disagree()
    {
        string sql;
        int ID = (int)Session["ID"];
        if (Session["userlevel"].ToString() == "5")
            sql = "update T_INSTRUREPAIR set SHR='" + Session["username"].ToString() + "',state='4' where id=" + ID;
        else
            sql = "update T_INSTRUREPAIR set SPR='" + Session["username"].ToString() + "',state='4' where id=" + ID;
        DB db = new DB();
        db.ExecuteSQL(sql);
        Response.Write("<script>alert('提交成功');</script>");
        Close();
    }
    public void Submit()
    {
        string s_DW = Session["KM"].ToString();
        string s_WXLB = WXLB.Value;
        string s_AZWZ = AZWZ.Value;
        string s_YQYBMC = YQYBMC.Value;
        string s_GGXH = GGXH.Value;
        string s_RQ = RQ.Value;
        string s_GZXX = TextBox1.Text;
        DB db = new DB();
        string sql_id = "select SEQ_Table.nextval from dual";
        string id = db.GetDataTable(sql_id).Rows[0][0].ToString();
        string sql = "insert into T_INSTRUREPAIR (DW,WXLB,AZWZ,YQYBMC,GGXH,RQ,GZXX,ID,STATE) values ('" + s_DW +
            "','" + s_WXLB + "','" + s_AZWZ + "','" + s_YQYBMC + "','" + s_GGXH + "',to_date('" + s_RQ + "','yyyy-mm-dd'),'"
            + s_GZXX + "'," + id + ",'1')";
        db.ExecuteSQL(sql);
        Response.Write("<script>alert('提交成功');</script>");
        Close();
    }
    public void Reset()
    {
        WXLB.Value = "";
        AZWZ.Value = "";
        YQYBMC.Value = "";
        GGXH.Value = "";
        RQ.Value = "";
        TextBox1.Text = "";
        SHR.InnerText = "审核人：";
        SPR.InnerText = "审批人：";
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        Close();
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        int state = HaveState();
        DataRow dr = (DataRow)Session["DR"];
        int ID = (int)Session["ID"];
        if (state == 1)
        {
            if (ID == -1)
                Submit();
        }
        else if (state == 2)
        {
            if (dr["STATE"].ToString() == "1")
                Disagree();
        }
        else
        {
            if (dr["STATE"].ToString() == "2")
                Disagree();
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        int state = HaveState();
        DataRow dr = (DataRow)Session["DR"];
        int ID = (int)Session["ID"];
        if (state == 1)
        {
            if (ID == -1)
                Reset();
        }
        else if (state == 2)
        {
            if (dr["STATE"].ToString() == "1")
                Agree();
        }
        else
        {
            if (dr["STATE"].ToString() == "2")
                Agree();
        }
    }
}