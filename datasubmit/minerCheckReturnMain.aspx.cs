﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class datasubmit_minerCheckReturnMain : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string km = "";
        string dm = "";
        if (Session["km"] != null) km = Session["km"].ToString();
        
        DB db = new DB();
        string sql = "select distinct id,(select name from t_instituteinvestigationflow where id = t.id) as name from t_minerflow t where MINERCHECK =0 and  minername = '" + km + "'";
        DataTable dt = new DataTable();
        dt = db.GetDataTable(sql); //数据源     
        Repeater1.DataSource = dt;
        Repeater1.DataBind();
    }

    protected void Button1_Click(object sender, EventArgs e)
    {

    }

    public string GetKM(string DM)
    {
        string km = "";
        DB db = new DB();
        string sql = "select km from t_dept where dm = '" + DM + "'";
        System.Data.DataTable dt = new System.Data.DataTable();
        dt = db.GetDataTable(sql);
        if (dt.Rows.Count > 0)
        {
            km = dt.Rows[0][0].ToString();
        }
        return km;

    }


}