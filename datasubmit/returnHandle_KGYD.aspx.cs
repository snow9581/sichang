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

public partial class returnHandle_KGYD : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string id = Request.Params["id"];
            hd_id.Value = id;
            string km = (Session["km"] != null ? Session["km"].ToString() : "");
            string sql = "select mineropinion from t_minerflow where id="+id+" and minername='"+km+"'";
            DB db = new DB();
            DataTable dt = new DataTable();
            dt = db.GetDataTable(sql);
            if (dt.Rows.Count > 0) T_OPINION.Text = dt.Rows[0][0].ToString();
            string sql_dm = "select t.rowid rid, t.teamname,t.excelname from T_TEAM t where t.id=" + id + " and t.minername='" + km + "'";
            DataTable dt1 = new DataTable();
            dt1 = db.GetDataTable(sql_dm);
            Repeater1.DataSource = dt1;
            Repeater1.DataBind();
        }
    }
}
