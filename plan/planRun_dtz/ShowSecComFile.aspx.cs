using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class plan_planRun_dtz_SubmitSecComFile : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string id = Request.Params["id"];
            string username = Session["username"].ToString();
            //string id = "44";
            string Name = "";
            DB db = new DB();
            DataTable dt = new DataTable();
            DataTable dd = new DataTable();
            if (id != null && id != "")
            {
                string sql = "select PNAME from T_PLANRUN_DTZ where PID=" + id;
                dt = db.GetDataTable(sql); //数据源        
            }
            if (dt.Rows.Count > 0)
            {
                Name = dt.Rows[0]["PNAME"].ToString();
            }
            hd_id.Value = id;
            H_PName.Value = Name;
            userName.Value = username;
        }
    }
}