<%@ WebHandler Language="C#" Class="destroy_meter" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
public class destroy_meter : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string ID = context.Request.Params["ID"];
        DB db = new DB();

        string filename = "";

        string sql = "delete from T_METER where ID=" + ID.ToString();
        bool result = db.ExecuteSQL(sql);

        if (result)
        {
            if (filename != "")
            {
                try
                {
                    FTP ftp = new FTP();
                    ftp.Delete("ftpimage", filename);
                }
                catch (Exception ex)
                {
                    SClog.insert("error", "ftp delete failure" + ex.ToString());
                }
            }

            context.Response.Write("1");//删除之后给其那台的返回值
            context.Response.End();
        }
        else
        {
            context.Response.Write("0");
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