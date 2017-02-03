using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class ybManage_meterrepair_jldTable : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string id = Context.Request.Params["ID"];
        ID.Value = id;
        USERLEVEL.Value = Context.Session["userlevel"].ToString();
        DB db = new DB();
        DataTable dt = db.GetDataTable("select * from T_METER_REPAIR where ID=" + id);
        USERNAME.Value = Context.Session["username"].ToString();
        WXR.Value = dt.Rows[0]["WXR"].ToString();
        DW.Value = dt.Rows[0]["DW"].ToString();

        WXR_NAME.Value = dt.Rows[0]["WXRQZ"].ToString();
        SCDW_NAME.Value = dt.Rows[0]["SCDWQZ"].ToString();

        if (dt.Rows[0]["STATE"].ToString() == "6" && USERLEVEL.Value == "1"){
           jlyok.Visible = true;
           jlyrefuse.Visible = true;
        }            
        else{
           jlyok.Visible = false;
           jlyrefuse.Visible = false;
        }

        if (dt.Rows[0]["STATE"].ToString() == "3" && (USERLEVEL.Value == "6" && belongToBanzu(USERNAME.Value, WXR.Value)))
        {
            save.Visible = true;
            ok.Visible = true;
        }
        else
        {
            save.Visible = false;
            ok.Visible = false;
        }   
    }
    //判断某用户是否属于仪表室特定班组。高俊涛 2016-08-19
    bool belongToBanzu(string user,string banzu) {
        DB db = new DB();
        DataTable dt = db.GetDataTable("select * from t_user where username='" +user+"' and major='"+banzu+"'");
        if (dt.Rows.Count > 0) return true;
        else return false;
    }
}