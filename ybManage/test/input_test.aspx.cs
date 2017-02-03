using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class ybManage_text_input_text : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string index = Request.Params["index"];
        hd_DM.Value= Convert.ToString(Session["dm"].ToString());
        hd_index.Value = index;
        string id = Request.Params["id"];
        ID.Value = id;               
        string userlevel = Convert.ToString(Session["userlevel"]);
        ul.Value = userlevel;
        DB db = new DB();
        string sql = "select * from T_METERTEXT,T_METER where T_ID=ID AND T_ID='" + id + "'";
        DataTable dt = new DataTable();
        dt = db.GetDataTable(sql);
        COMPANY.Value = dt.Rows[0]["COMPANY"].ToString();
        YBMC.Value = dt.Rows[0]["YBMC"].ToString();
        GGXH.Value = dt.Rows[0]["GGXH"].ToString();
        CCBH.Value = dt.Rows[0]["CCBH"].ToString();
        ZQDDJ.Value = dt.Rows[0]["ZQDDJ"].ToString();
        SCCJ.Value = dt.Rows[0]["SCCJ"].ToString();
        JDJG.Value = dt.Rows[0]["JDJG"].ToString();
        COMPETENT.Value = dt.Rows[0]["COMPETENT"].ToString();
        CHECKER.Value = dt.Rows[0]["CHECKER"].ToString();
        TEXTER.Value = dt.Rows[0]["TEXTER"].ToString();
        TEXTDATE.Value = dt.Rows[0]["TEXTDATE"].ToString();
        VALIDDATE.Value = dt.Rows[0]["VALIDDATE"].ToString();
        DATA3.Value = dt.Rows[0]["DATA3"].ToString();
        DATA1.Value = dt.Rows[0]["DATA1"].ToString();
        DATA2.Value = dt.Rows[0]["DATA2"].ToString();
        DATA9.Value = dt.Rows[0]["DATA9"].ToString();
        DATA10.Value = dt.Rows[0]["DATA10"].ToString();
        DATA11.Value = dt.Rows[0]["DATA11"].ToString();
        DATA12.Value = dt.Rows[0]["DATA12"].ToString();
        DATA13.Value = dt.Rows[0]["DATA13"].ToString();
        DATA14.Value = dt.Rows[0]["DATA14"].ToString();
        DATA15.Value = dt.Rows[0]["DATA15"].ToString();
        DATA16.Value = dt.Rows[0]["DATA16"].ToString();
        DATA17.Value = dt.Rows[0]["DATA17"].ToString();
        DATA18.Value = dt.Rows[0]["DATA18"].ToString();
        DATA19.Value = dt.Rows[0]["DATA19"].ToString();
        DATA20.Value = dt.Rows[0]["DATA20"].ToString();
        DATA21.Value = dt.Rows[0]["DATA21"].ToString();
        DATA22.Value = dt.Rows[0]["DATA22"].ToString();
        DATA23.Value = dt.Rows[0]["DATA23"].ToString();
        DATA24.Value = dt.Rows[0]["DATA24"].ToString();
        DATA25.Value = dt.Rows[0]["DATA25"].ToString();
        DATA26.Value = dt.Rows[0]["DATA26"].ToString();
        DATA27.Value = dt.Rows[0]["DATA27"].ToString();
        DATA28.Value = dt.Rows[0]["DATA28"].ToString();
        DATA29.Value = dt.Rows[0]["DATA29"].ToString();
        DATA30.Value = dt.Rows[0]["DATA30"].ToString();
        DATA31.Value = dt.Rows[0]["DATA31"].ToString();
        DATA32.Value = dt.Rows[0]["DATA32"].ToString();
        DATA33.Value = dt.Rows[0]["DATA33"].ToString();
        DATA34.Value = dt.Rows[0]["DATA34"].ToString();
        DATA35.Value = dt.Rows[0]["DATA35"].ToString();
        DATA36.Value = dt.Rows[0]["DATA36"].ToString();
        DATA37.Value = dt.Rows[0]["DATA37"].ToString();
        DATA38.Value = dt.Rows[0]["DATA38"].ToString();
        MAXERROR.Value = dt.Rows[0]["MAXERROR"].ToString();

    }
}