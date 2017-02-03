using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class plan_planRun_dtz_AssignmentWorkload : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    { 
        string username=Session["username"].ToString();
        string userlevel = Session["userlevel"].ToString();
        userLevel.Value = userlevel;
        km.Value = Session["km"].ToString();
        if (userlevel != "3")
        {
            string pid = Request.Params["id"].ToString();
            PID.Value = pid;
            string sql = "select * from T_PLANRUN_DTZ where PID=" + pid;
            DB db = new DB();
            DataTable dt = db.GetDataTable(sql);
            if (dt.Rows[0]["SOLUCHIEF"].ToString() == username || dt.Rows[0]["DESICHIEF"].ToString() == username)
            {
                jurisdiction.Value = "1";//确定权限，如果为方案负责人或设计负责人可以进行添加删除修改操作
            }
            else
            {
                jurisdiction.Value = "0";
            }
        }
        else
        {
            PID.Value = "";
            jurisdiction.Value = "0";
        }
    }
}