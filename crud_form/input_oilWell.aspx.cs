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

public partial class crud_form_input_oilWell : BasePage
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
            string sql = "select JYGXGG,CSGXGG from T_oilWell where id=" + id;
            dt = db.GetDataTable(sql); //数据源    
            if (dt.Rows.Count > 0)
            {
                string JYGXGG = dt.Rows[0]["JYGXGG"].ToString();
                if (JYGXGG != "")
                {
                    JYGXGG = JYGXGG.Remove(0, 1);
                    string[] sArray1 = JYGXGG.Split('×');
                    JYGXGG1.Value = sArray1[0];
                    JYGXGG2.Value = sArray1[1];
                }
                string CSGXGG = dt.Rows[0]["CSGXGG"].ToString();
                if (CSGXGG != "")
                {
                    CSGXGG = CSGXGG.Remove(0, 1);
                    string[] sArray2 = CSGXGG.Split('×');
                    CSGXGG1.Value = sArray2[0];
                    CSGXGG2.Value = sArray2[1];
                }
            }
        }
    }
}