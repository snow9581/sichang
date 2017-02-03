<%@ WebHandler Language="C#" Class="insert_image" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.SessionState;

public class insert_image :  BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string json = "";
        string DM = Convert.ToString(context.Session["DM"]);
        string KM = Convert.ToString(context.Session["KM"]);
        string CREATEDATE = DateTime.Now.ToString();
        string INTRODUCTION = context.Request.Params["INTRODUCTION"];
        string IMGNAME = context.Request.Params["IMGNAME"];
        string IMGTYPE = context.Request.Params["IMGTYPE"];


        //++++++++++++++++ begin 上传文件++++++++++++++++
        //高俊涛修改 2014-09-07 直接获取上传文件流 文件名称 和文件大小

        context.Response.ContentType = "text/plain";

        HttpPostedFile _upfile = context.Request.Files["PICFILE"];

        string fileName = "";//如果没有上传文件，则为空，不显示下载，高俊涛改于2014-11-11

        if (_upfile.ContentLength > 0)
        {//有上传文件

            System.IO.Stream s = _upfile.InputStream;

            int l = _upfile.ContentLength;

            FTP ftp = new FTP();

            //获得文件后缀

            string suffix = System.IO.Path.GetExtension(_upfile.FileName);

            fileName = ftp.FTPUploadFile("ftpupload", s, l, suffix);

            //++++++++++++++++ end 上传文件++++++++++++++++
        }

        string ID = "0";
        DB db = new DB();
        string sql_id = "select SEQ_IMAGE.nextval from dual";
        System.Data.DataTable dt = db.GetDataTable(sql_id);
        if (dt.Rows.Count > 0) ID = dt.Rows[0][0].ToString();

        string sql = "insert into T_IMAGE(ID,KM,DM,INTRODUCTION,IMGNAME,IMGTYPE,CREATEDATE) values (" + ID + ",'" + KM + "','" + DM + "','" +
                     T.preHandleSql(INTRODUCTION) + "','" + fileName + "','" + IMGTYPE + "',to_date('" + CREATEDATE + "','yyyy-mm-dd hh24:mi:ss'))";
        bool result=db.ExecuteSQL(sql);

        if (result)
        {
            Image img = new Image();
            img.ID = ID;
            img.KM = KM;
            img.DM = DM;
            img.INTRODUCTION = INTRODUCTION.Replace("\r\n", "<br/>");
            img.IMGNAME = fileName;
            img.IMGTYPE = IMGTYPE;
            img.CREATEDATE = CREATEDATE;
            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(img);
            context.Response.Write(json);
            context.Response.End();
        }
        else {
            context.Response.ContentType = "text/html";
            context.Response.Write("<script>alert('  错误!\\n添加失败！');</script>");
        }
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}