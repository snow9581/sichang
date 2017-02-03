<%@ WebHandler Language="C#" Class="insert_share" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public class insert_share : BaseHandler
{

    public override void AjaxProcess(HttpContext context)
    {
        context.Response.ContentType = "text/plain";

        HttpPostedFile _upfile = context.Request.Files["FILES"];

        string fileName = "";//如果没有上传文件，则为空，不显示下载

        if (_upfile.ContentLength > 0)
        {//有上传文件

            System.IO.Stream s = _upfile.InputStream;

            int l = _upfile.ContentLength;

            FTP ftp = new FTP();

            //获得文件后缀

            string suffix = System.IO.Path.GetExtension(_upfile.FileName);

            fileName = ftp.FTPUploadFile("Share", s, l, suffix);


        }
        //++++++++++++++++ end 上传文件++++++++++++++++
        string json =" ";
        string SH_NAME = context.Request.Params["SH_NAME"];
        string SH_PROJECT = context.Request.Params["SH_PROJECT"];
        string SH_INFOR = context.Request.Params["SH_INFOR"];
        string SH_AUTHOR = context.Request.Params["SH_AUTHOR"];
        string SH_CHAIRMAN = context.Request.Params["SH_CHAIRMAN"];
        string SH_DATE = context.Request.Params["SH_DATE"];
        string FILES = context.Request.Params["FILES"];
        int ID = 0;
        DB db = new DB();
        string sql_id = "select SEQ_T_SHARE.nextval from dual";
        DataTable dt_id = new DataTable();
        dt_id = db.GetDataTable(sql_id);
        if (dt_id.Rows.Count > 0)
            ID = Convert.ToInt32(dt_id.Rows[0][0].ToString());
        string sql_insert = "insert into T_SHARE  (ID,SH_NAME,SH_PROJECT,SH_INFOR,SH_AUTHOR,SH_CHAIRMAN,SH_DATE,FILES) values ("+ID+",'" + SH_NAME + "','" + SH_PROJECT + "','" + SH_INFOR + "','" + SH_AUTHOR + "','" + SH_CHAIRMAN + "',to_date('" + SH_DATE + "','yyyy-mm-dd'),'"+fileName+"')";
        bool result = db.ExecuteSQL(sql_insert);
        if(result)
        {
            Share cs = new Share();
            cs.SH_NAME = SH_NAME;
            cs.SH_PROJECT = SH_PROJECT;
            cs.SH_INFOR = SH_INFOR;
            cs.SH_AUTHOR = SH_AUTHOR;
            cs.SH_CHAIRMAN = SH_CHAIRMAN;
            cs.SH_DATE = SH_DATE;
            cs.FILES = FILES;
            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(cs);
            context.Response.Write(json);
            context.Response.End();
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}