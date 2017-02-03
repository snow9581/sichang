using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class crud_form_input_container : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string index = Request.Params["index"];
        string id = Request.Params["id"];
        hd_index.Value = index;
        string userlevel = Convert.ToString(Session["userlevel"]);
        userLevel.Value = userlevel;
        DB db = new DB();
        DataTable dt = new DataTable();
        if (id != null && id != "")
        {
            string sql = "select GGXH from T_container where id=" + id;
            dt = db.GetDataTable(sql); //数据源         
            if (dt.Rows.Count > 0)
            {
                string GGXH = dt.Rows[0]["GGXH"].ToString();
                if (GGXH != "")
                {          
                    GGXH = GGXH.Remove(0, 1);
                    string[] sArray = GGXH.Split('×');
                    GGXH1.Value = sArray[0];
                    GGXH2.Value = sArray[1];
                }
            }
        }
    }
}