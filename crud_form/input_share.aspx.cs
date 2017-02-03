using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class crud_form_input_share : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        userlevel.Value =Session["userlevel"].ToString();
        DB db = new DB();
        string index = Request.Params["index"];
        hd_index.Value = index;
        string SH_NAME = Request.Params["SH_NAME"];
        string sql = "select ID from T_SHARE where SH_NAME='"+SH_NAME+"'";
        DataTable dt = new DataTable();
        dt = db.GetDataTable(sql);
        string ID = "";
        if(dt.Rows.Count>0)
        {
            ID = dt.Rows[0][0].ToString();
        }
        hd_ID.Value = ID;
    }
}