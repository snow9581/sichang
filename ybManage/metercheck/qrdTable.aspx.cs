using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class ybManage_Instrument_FinishStateTable : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string FROMID = null;
        FROMID = Context.Request.Params["FROMID"].ToString();
        
        fromid.Value = FROMID;
        string strBM = null;
        string strDW = null;
        DB db=new DB();
        DataTable dt = db.GetDataTable("select * from T_METER_CHECK where ID='" + FROMID + "'");
        strDW = dt.Rows[0]["DEPARTMENT"].ToString();
        strBM = dt.Rows[0]["BM"].ToString().Substring(0, dt.Rows[0]["BM"].ToString().Length - 3) + "(维修)完成情况确认单";
        BM.Value = strBM;
        userLevel.Value=Session["userlevel"].ToString();
        string kongge = "";
        for (int i = 0; i <= 30; i++)
            kongge += "&nbsp;";
        TITLE.Value = "单位：" + strDW + kongge + "审核人：" + dt.Rows[0]["SHR"].ToString() + kongge + "批准人：" + dt.Rows[0]["PZR"].ToString();
        STATE.Value = dt.Rows[0]["STATE"].ToString();
        //4：等待填写确认单
        if (!(dt.Rows[0]["STATE"].ToString() == "4" && (Session["userlevel"].ToString() == "6" && Session["username"].ToString() == dt.Rows[0]["INITIATOR"].ToString() || Session["userlevel"].ToString() == "1")))
        {
            save.Visible = false;
          //  checkresult.Visible = false;            
        }
        if (dt.Rows[0]["QRD_FINISH"].ToString() == "1" || (userLevel.Value != "6" && userLevel.Value != "1"))
            add.Visible = false;
    }
}