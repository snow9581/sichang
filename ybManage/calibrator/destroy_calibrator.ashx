<%@ WebHandler Language="C#" Class="destroy_calibrator" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;
using System.Web.SessionState;

public class destroy_calibrator : BaseHandler
{

    public override void AjaxProcess(HttpContext context)
    {
        string ID = context.Request.Params["id"];
        DB db = new DB();

        string filename = "";
        string idsql = "select WJ from T_CALIBRATOR where ID='" + ID + "'";
        string sql = "delete from T_CALIBRATOR where ID='" + ID + "'";

        System.Data.DataTable dt = db.GetDataTable(idsql);
        if (dt.Rows.Count > 0)
        {
            filename = dt.Rows[0]["WJ"].ToString();
           
        }

        bool result = db.ExecuteSQL(sql);

        if (result)
        {
            if (filename != "" && filename != "#")
            {
                try
                {
                    FTP ftp = new FTP();
                    ftp.Delete("meter", filename);
                }
                catch (Exception ex)
                {
                    SClog.insert("error", "ftp delete failure" + ex.ToString());
                }
            }
            string state = "{\"success\":true}";

            context.Response.Write(state);
            context.Response.End();
        }
        else
        {
            context.Response.Write("<script>alert('  错误!删除失败！');</script>");
        }     
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}