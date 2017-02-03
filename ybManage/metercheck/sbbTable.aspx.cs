using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class ybManage_Instrument_sbbTable : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string FROMID = Context.Request.Params["FROMID"].ToString();
        fromid.Value = FROMID;
        DB db = new DB();
        DataTable dt = db.GetDataTable("select * from T_METER_CHECK where ID=" + FROMID);
        BM.Value = dt.Rows[0]["BM"].ToString();
        string kongge = "";
        for (int i = 0; i <= 30; i++)
            kongge += "&nbsp;";
        TITLE.Value = "单位：" + dt.Rows[0]["DEPARTMENT"].ToString() +kongge + "审核人：" + dt.Rows[0]["SHR"].ToString() + kongge + "批准人：" + dt.Rows[0]["PZR"].ToString();
        string userlevel = Session["userlevel"].ToString();
        disagree.Visible = false;
        string userName=Session["username"].ToString();
        if (userlevel == "2")
        {
            if (dt.Rows[0]["STATE"].ToString() != "1")
            {
                
                agree.Visible = false;
                disagree.Visible = false;
            }
        }
        else if (userlevel == "4")
        {
            if (dt.Rows[0]["STATE"].ToString() != "2")
            {
                agree.Visible = false;
                disagree.Visible = false;
            }
        }
        else if (userlevel == "6")
        {
            if (dt.Rows[0]["STATE"].ToString() != "3" && dt.Rows[0]["STATE"].ToString() != "2" && dt.Rows[0]["STATE"].ToString() != "1")
            {
                agree.Visible = false;
                disagree.Visible = false;
            }
            if (userName != dt.Rows[0]["INITIATOR"].ToString())
            {
                agree.Visible = false;
                disagree.Visible = false;
                //exportExcel.Visible = false;
            }
        }
        else
        {
            agree.Visible = false;
            disagree.Visible = false;
        }
    }
}