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

public partial class crud_form_input_injectionWell : BasePage
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
            string sql = "select GXGG from T_injectionWell where id=" + id;
            dt = db.GetDataTable(sql); //数据源            
            if (dt.Rows.Count > 0)
            {
                string GXGG = dt.Rows[0]["GXGG"].ToString();
                if (GXGG != "")
                {
                    GXGG = GXGG.Remove(0, 1);
                    string[] sArray = GXGG.Split('×');
                    GXGG1.Value = sArray[0];
                    GXGG2.Value = sArray[1];
                }
            }
        }
    }
}