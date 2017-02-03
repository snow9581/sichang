<%@ WebHandler Language="C#" Class="update_image" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.SessionState;

public class update_image : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        if (context.Session["userlevel"] == "" || context.Session["userlevel"] == null)
        {
            context.Response.Write("<script>alert('用户已过期,请重新登录！');window.parent.location.href ='../login.aspx'</script>");
        }
        string json = "";
        string ID = context.Request.Params["ID"];
        string DM = context.Request.Params["DM"];
        string KM = context.Request.Params["KM"];
        string CREATEDATE = DateTime.Now.ToString();
        string INTRODUCTION = context.Request.Params["INTRODUCTION"];
        string IMGTYPE = context.Request.Params["IMGTYPE"];
        string IMGNAME = context.Request.Params["IMGNAME"];
        //string PICFILE = context.Request.Params["PICFILE"];

        //////////ftp开始上传///////////////
        HttpPostedFile _upfile = context.Request.Files["PICFILE"];
        context.Response.ContentType = "text/plain";
        string fileName = "#";//如果没有上传文件，则为#号，不显示下载  
        DB db = new DB();
        string filename = "";
        string idsql = "select IMGNAME from T_IMAGE where ID='" + ID + "'";
        System.Data.DataTable dt = db.GetDataTable(idsql);
        if (dt.Rows.Count > 0)
            filename = dt.Rows[0]["IMGNAME"].ToString();

        if (_upfile.ContentLength > 0)
        {//有上传文件 先删除原有文件
            //++++++++++++++++++++++++++删除已存在的ftp文件++++++++++++++++++++++
            if (filename != "")
            {
                try
                {
                    FTP ftp1 = new FTP();
                    ftp1.Delete("ftpupload", filename);
                }
                catch (Exception ex)
                {
                    SClog.insert("error", "ftp delete in update failure" + ex.ToString());
                }
            }
            //++++++++++++++++++++++++++删除ftp文件结束++++++++++++++++++++++
            //++++++++++++++++++++++++++更新ftp文件++++++++++++++++++++++
            System.IO.Stream s = _upfile.InputStream;

            int l = _upfile.ContentLength;

            FTP ftp2 = new FTP();

            //获得文件后缀

            string suffix = System.IO.Path.GetExtension(_upfile.FileName);

            fileName = ftp2.FTPUploadFile("ftpupload", s, l, suffix);
            //+++++++++++++++++++++++++更新ftp文件结束++++++++++++++++++++++
        }
        //////////ftp上传结束///////////////
        
        string sql = "update T_IMAGE set KM='" + KM + "',DM='" + DM + "',INTRODUCTION='" + T.preHandleSql(INTRODUCTION) +
            "',IMGTYPE='" + IMGTYPE + "',CREATEDATE =to_date('" + CREATEDATE + "','yyyy-mm-dd hh24:mi:ss')";
        if (fileName != "#")
        {
            sql += ",IMGNAME='" + fileName + "'";
        }
        sql += " where ID='" + T.preHandleSql(ID) + "'";
        
        bool result=db.ExecuteSQL(sql);
        if (result)
        {
            Image img = new Image();
            img.ID = ID;
            img.KM = KM;
            img.DM = DM;
            img.CREATEDATE = CREATEDATE;
            img.INTRODUCTION = INTRODUCTION.Replace("\r\n", "<br/>");
            if (fileName != "#")
            {
                img.IMGNAME = fileName;
            }
            else
                img.IMGNAME = filename;
            img.IMGTYPE = IMGTYPE;
            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(img);
            context.Response.Write(json);
            context.Response.End();
        }
        else
        {
            context.Response.ContentType = "text/html";
            context.Response.Write("<script>alert('  错误!\\n更新失败！');</script>");
        }
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}