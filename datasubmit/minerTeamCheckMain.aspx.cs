﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class datasubmit_minerTeamCheckMain : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DB db = new DB();
        string sql = "select distinct id,(select name from t_instituteinvestigationflow where id = t.id) as name from t_team t where type = '已填写调查报告'";
        DataTable dt = new DataTable();
        dt = db.GetDataTable(sql); //数据源     
        Repeater1.DataSource = dt;
        Repeater1.DataBind();
    }

    protected void Button1_Click(object sender, EventArgs e)
    {

    }
}