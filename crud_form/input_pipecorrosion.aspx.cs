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
using System.Web.Script.Serialization;

public partial class easyui_crud_demo_show_form : BasePage
{

    protected void Page_Load(object sender, EventArgs e)
    {
        string index = Request.Params["index"];
        hd_index.Value = index;
        string id = Request.Params["id"];
        string userlevel = Convert.ToString(Session["userlevel"]);
        userLevel.Value = userlevel;
        DB db = new DB();
        DataTable dt = new DataTable();
        if (id != null && id != "")
        {
            string sql = "select GDGG from T_PIPECORROSION where id=" + id;
            dt = db.GetDataTable(sql); //数据源    
            if (dt.Rows.Count > 0)
            {
                string GDGG = dt.Rows[0]["GDGG"].ToString();
                if (GDGG != "")
                {
                    GDGG = GDGG.Remove(0, 1);
                    string[] sArray1 = GDGG.Split('×');
                    GDGG1.Value = sArray1[0];
                    GDGG2.Value = sArray1[1];
                }
            }

        }
    }
}
