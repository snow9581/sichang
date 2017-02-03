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
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public partial class plan_planRun_dtz_SubmitWorkLoad : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string id = Request.Params["id"];
            string username=Session["username"].ToString();
            //string id = "44";
            string Name = "";
            string workloadFile = "";
            string flag="";
            DB db = new DB();
            DataTable dt = new DataTable();
            DataTable dd = new DataTable();
            if (id != null && id != "")
            {
                string sql = "select PNAME,MAJORDELEGATEDATE_R,DESICHIEF from T_PLANRUN_DTZ where PID=" + id;
                dt = db.GetDataTable(sql); //数据源        
            }
            if (dt.Rows.Count > 0)
            {
                Name = dt.Rows[0]["PNAME"].ToString();
                flag = dt.Rows[0]["MAJORDELEGATEDATE_R"].ToString()==""?"":"1";
                string sql_workload = "select W_FILE from T_WORKLOADSUBMIT where W_PID=" + id +" and W_NAME='"+username+"'";
                dd = db.GetDataTable(sql_workload); //数据源 
                if (dd.Rows.Count > 0)
                    workloadFile = dd.Rows[0]["W_FILE"].ToString();
                
            }
            hd_id.Value = id;
            H_PName.Value = Name;
            H_workloadFile.Value = workloadFile;
            hd_comflag.Value = flag;
            userName.Value = username;
        }
    }
}