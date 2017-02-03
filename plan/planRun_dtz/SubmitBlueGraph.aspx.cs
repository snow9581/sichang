using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class plan_planRun_dtz_SubmitBlueGraph : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string id = Request.Params["id"];
        string username = Session["username"].ToString();
        //string id = "44";

        DB db = new DB();
        DataTable dt = new DataTable();
        DataTable dd = new DataTable();
        if (id != null && id != "")
        {
            string sql = "select PNAME,PNUMBER,PLANFLAG,DESICHIEF from T_PLANRUN_DTZ where PID=" + id;
            dt = db.GetDataTable(sql); 
        }
       
        if (dt.Rows.Count > 0)
        {
            planDesigner.Value = dt.Rows[0]["DESICHIEF"].ToString();
            PName.Value = dt.Rows[0]["PNAME"].ToString();
            PNumber.Value = dt.Rows[0]["PNUMBER"].ToString();
            planflag.Value = dt.Rows[0]["PLANFLAG"].ToString();
            string sql_blue = "select FILES,BZ from T_CONSTRUCTION where SPECIALPERSON='" + username + "' and PNAME='" + dt.Rows[0]["PNAME"].ToString() + "'";
            dd = db.GetDataTable(sql_blue);
            if (dd.Rows.Count > 0)
            {
                hd_BlueGraph.Value = dd.Rows[0]["FILES"].ToString();
                B_BZ.Value = dd.Rows[0]["BZ"].ToString();
            }
        }
    }
}