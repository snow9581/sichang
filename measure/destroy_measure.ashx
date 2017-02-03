<%@ WebHandler Language="C#" Class="destroy_measure" %>
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public class destroy_measure : IHttpHandler {
    
   public void ProcessRequest (HttpContext context) {
        string ID = context.Request.Params["ID"];
        DB db = new DB();

        string filename = "";

        string sql = "delete from T_MEASURE where ID=" + ID.ToString();
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
            string state = "{\"success\":true}";

            context.Response.Write("1");
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