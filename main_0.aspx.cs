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

public partial class main_0 : BasePage
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
        else
        {//开发阶段先注释 方便测试
            //this.Response.Write("<script>alert('对不起，请先登录！');</script>");
            //this.Response.Write("<script language=javascript>location.href='login.aspx';</script>");
        }

    }
}
