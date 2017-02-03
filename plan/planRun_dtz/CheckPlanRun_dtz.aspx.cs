using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;


public partial class plan_planRun_dtz_CheckPlanRun_dtz : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string id = Request.Params["id"];
            string Name = "";
            string Source = "";
            string estiInvestment = "";
            string wordname = "#";
            DB db = new DB();
            DataTable dt = new DataTable();
            if (id != null && id != "")
            {
                string sql = "select PNAME,PSOURCE,ESTIINVESTMENT,DRAFTSOLUTIONFILE,CHECKOPINION from T_PLANRUN_DTZ where PID=" + id;
                dt = db.GetDataTable(sql); //数据源    
            }
            if (dt.Rows.Count > 0)
            {
                Name = dt.Rows[0]["PNAME"].ToString();
                Source = dt.Rows[0]["PSOURCE"].ToString();
                estiInvestment = dt.Rows[0]["ESTIINVESTMENT"].ToString();
                wordname = dt.Rows[0]["DRAFTSOLUTIONFILE"].ToString();
                CHECKOPINION.Value = dt.Rows[0]["CHECKOPINION"].ToString();
            }
            hd_id.Value = id;
            PName.Value = Name;
            PSource.Value = Source;
            EstiInvestment.Value = estiInvestment;
            if (wordname != "#" && wordname != "") WORDNAME.Value = wordname;
            else DG.Visible = false;
        }
    }
}
