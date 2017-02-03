<%@ WebHandler Language="C#" Class="update_share" %>

using System;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Data;

public class update_share : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        string json = "";
        DB db = new DB();
        string ID =context.Request.Params["ID"];
        string SH_NAME = context.Request.Params["SH_NAME"];
        string SH_PROJECT = context.Request.Params["SH_PROJECT"];
        string SH_INFOR = context.Request.Params["SH_INFOR"];
        string SH_AUTHOR = context.Request.Params["SH_AUTHOR"];
        string SH_CHAIRMAN = context.Request.Params["SH_CHAIRMAN"];
        string SH_DATE = context.Request.Params["SH_DATE"];
        string sql_se = "select ID from T_share where SH_NAME='" + SH_NAME + "'";
        /////////////////////////////////////
         //////////ftp开始上传///////////////
         ////////////////////////////////////
        HttpPostedFile _upfile = context.Request.Files["FILES"];
        context.Response.ContentType = "text/plain";
        string fileName = "#";//如果没有上传文件，则为#号，不显示下载  
        string filename = "";
        string idsql = "select FILES from T_SHARE where ID='" + ID + "'";
        System.Data.DataTable dt = db.GetDataTable(idsql);
        if (dt.Rows.Count > 0)
            filename = dt.Rows[0]["FILES"].ToString();

        if (_upfile.ContentLength > 0)
        {//有上传文件 先删除原有文件
            //++++++++++++++++++++++++++删除已存在的ftp文件++++++++++++++++++++++
            if (filename != "")
            {
                try
                {
                    FTP ftp1 = new FTP();
                    ftp1.Delete("share", filename);
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

            fileName = ftp2.FTPUploadFile("share", s, l, suffix);
            //+++++++++++++++++++++++++更新ftp文件结束++++++++++++++++++++++
        }
        //////////ftp上传结束///////////////
        DataTable dt_id = new DataTable();
        dt_id = db.GetDataTable(sql_se);
        if(dt_id.Rows.Count>0)
        {
            ID = dt_id.Rows[0][0].ToString();
        }
        string sql_up = "update T_share set SH_NAME='" + SH_NAME + "',SH_PROJECT='" + SH_PROJECT + "',SH_INFOR='" + SH_INFOR + "',SH_AUTHOR='" + SH_AUTHOR + "',SH_CHAIRMAN='" + SH_CHAIRMAN + "',SH_DATE=to_date('" + SH_DATE + "','yyyy-mm-dd')";
        if (fileName != "#")
        {
            sql_up += ",FILES='" + fileName + "'";
        }
        sql_up += " where ID='" + T.preHandleSql(ID) + "'";
        bool result = db.ExecuteSQL(sql_up);
        if(result)
        {
            Share cs = new Share();
            cs.SH_AUTHOR = SH_AUTHOR;
            cs.SH_CHAIRMAN = SH_CHAIRMAN;
            cs.SH_DATE = SH_DATE;
            cs.SH_INFOR = SH_INFOR;
            cs.SH_NAME = SH_NAME;
            cs.SH_PROJECT = SH_PROJECT;
            if (fileName != "#")
            {
                cs.FILES = fileName;
            }
            else
            {
                cs.FILES = filename;
            }
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