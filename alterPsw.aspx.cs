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
//alter password
public partial class Manage_AlterPsw : BasePage
{
   string username = "";
   
    protected void Page_Load(object sender, EventArgs e)
    {
         if (Session["username"] != null && Session["username"].ToString() != "")
        {
            username = (string)Session["username"].ToString();

          
        }
        else {

            this.Response.Write("<script>alert('对不起，请先登录！');</script>");
            this.Response.Write("<script language=javascript>location.href='login.aspx';</script>");
           
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        
        
        if (TextBox1.Text.Trim().Length == 0)
        {
           
            Response.Write("<script>alert('请输入原始密码！');</script>");
            return;
        }
        if (TextBox2.Text.Trim().Length == 0 )
        {
            Response.Write("<script>alert('请输入新密码！');</script>");
            return;
        }

        if (TextBox2.Text.Trim() != TextBox3.Text.Trim())
        {
            Response.Write("<script>alert('两次密码输入不一致！');</script>");
            return;
        }

         DB db = new DB();
         DataTable dt = new DataTable();
         String sql = "SELECT * FROM T_USER where username= '" + username + "' and password = '" + TextBox1.Text.Trim()+"'";
         dt = db.GetDataTable(sql);
         if (dt.Rows.Count > 0)
         {
             sql = "UPDATE T_USER set password ='" + TextBox2.Text.Trim() + "' where username= '" + username + "'";
             int flag = db.ExecuteSql(sql);
             if (flag > 0) {
                 Response.Write("<script>alert('密码修改成功！');window.opener='';window.open('','_self');window.close();</script>");
             }

         }
         else {
             Response.Write("<script>alert('原密码错误！');</script>");
             return;
         }
    
    }
        
    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Write("<script>window.opener='';window.open('','_self');window.close();</script>");
       
    }
}
