<%@ WebHandler Language="C#" Class="destroy_CommissionInformation" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
public class destroy_CommissionInformation : BaseHandler {

    public override void AjaxProcess(HttpContext context)
    {
        string ID = context.Request.Params["ID"];
        DB db = new DB();
        string filename = "";

        string idsql = "select FILES from T_COMMISSIONINFORMATION where ID='" + T.preHandleSql(ID) + "'";

        System.Data.DataTable dt = db.GetDataTable(idsql);
        if (dt.Rows.Count > 0) filename = dt.Rows[0]["FILES"].ToString();

        string sql = "delete from T_COMMISSIONINFORMATION where ID='" + T.preHandleSql(ID) + "'";

        bool result = db.ExecuteSQL(sql);
        if (result)
        {
            if (filename != "")
            {
                try
                {
                    FTP ftp = new FTP();
                    ftp.Delete("archives", filename);
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
            context.Response.Write("<script>alert('  错误!\\n删除失败！');</script>");
        }

    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }



}