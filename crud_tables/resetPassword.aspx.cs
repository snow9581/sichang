using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class crud_tables_resetPassword : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string userlevel = Convert.ToString(Session["userlevel"]);
        string ID = Request.Params["ID"];
        DB db = new DB();
        string sql = "update T_USER set PASSWORD='123' where id='" + ID + "'";
        db.ExecuteSQL(sql);
        Response.Write("<script>alert('密码已重置为【123】！');window.opener='';window.open('','_self');window.close();</script>");
        Response.End();
    }
}
