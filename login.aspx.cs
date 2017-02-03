using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.OracleClient;

public partial class login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string username = TextBox1.Text.Trim();
        string psw = TextBox2.Text.Trim();
        // Session["usename"] = username;
        string sqlstr = "select s.dm, s.userlevel ,s.major, t.km  from T_USER s, T_DEPT t where s.username='" + username + "' and s.password='" + psw + "' and s.dm=t.dm";
        DB db = new DB();
        DataTable dt = new DataTable();
        dt = db.GetDataTable(sqlstr);
        int count = dt.Rows.Count;
        string userlevel = "";
        string dm = "";
        string km = "";
        string major = "";

        if (count > 0)
        {
            //userlevel = dt.Rows[0]["userlevel"].ToString();
            //dm = dt.Rows[0]["dm"].ToString();
            //km = dt.Rows[0]["km"].ToString();

            userlevel = dt.Rows[0][1].ToString();
            dm = dt.Rows[0][0].ToString();
            km = dt.Rows[0][3].ToString();
            major = dt.Rows[0][2].ToString();

            Session["username"] = username;
            Session["userlevel"] = userlevel;
            Session["dm"] = dm;
            Session["km"] = km;
            Session["major"] = major;

            //高俊涛增加代码 2014-09-07 根据不同类型用户进入不同主操作界面 
            switch (userlevel)
            {
                case "0": Response.Redirect("main_0.aspx"); break;
                case "1": Response.Redirect("main_1.aspx"); break;
                case "2": Response.Redirect("main_2.aspx"); break;
                case "3": Response.Redirect("main_3.aspx"); break;
                case "4": Response.Redirect("main_4.aspx"); break;
                case "5": Response.Redirect("main_5.aspx"); break;
                case "6":                                           //某室普通员工
                case "7":                                           //某室副主任
                case "8": Response.Redirect("main_6.aspx"); break;  //某室特殊员工
                case "9": Response.Redirect("main_9.aspx"); break;  //矿计量员
                default: Response.Redirect("main.aspx"); break;

            }


        }
        else
        {
            Response.Write("<script> alert('用户名或密码错误，请重新登录!');</script>");

        }

    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        TextBox1.Text = "";
        TextBox2.Text = "";
    }
}
