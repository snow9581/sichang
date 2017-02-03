using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class main : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] != null)
        {
            string username = (string)Session["username"].ToString();
            labelname.Text = username;
            string userlevel = Convert.ToString(Session["userlevel"]);
            userLevel.Value = userlevel;
        }
        else {//开发阶段先注释 方便测试
            //this.Response.Write("<script>alert('对不起，请先登录！');</script>");
            //this.Response.Write("<script language=javascript>location.href='login.aspx';</script>");
        }
      
    }
}
