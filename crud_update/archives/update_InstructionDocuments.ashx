<%@ WebHandler Language="C#" Class="update_InstructionDocuments" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public class update_InstructionDocuments : BaseHandler {

    public override void AjaxProcess(HttpContext context)
    {
        string json = "";
        string NAME = context.Request.Params["FNAME"];
        string QSBM = context.Request.Params["QSBM"];
        string SCRQ = DateTime.Now.ToString();
        string ID = context.Request.Params["ID"];
        
        //////////ftp开始上传///////////////
        HttpPostedFile _upfile = context.Request.Files["FILES"];
        context.Response.ContentType = "text/plain";
        string fileName = "#";//如果没有上传文件，则为#号，不显示下载
        DB db = new DB();
        string filename = "";
        string scrq = "";
        string idsql = "select FILES,SCRQ from T_InstructionDocuments where FID='" + T.preHandleSql(ID) + "'";
        System.Data.DataTable dt = db.GetDataTable(idsql);
        if (dt.Rows.Count > 0)
        {
            filename = dt.Rows[0]["FILES"].ToString();
            scrq = dt.Rows[0]["SCRQ"].ToString();
        }

        if (_upfile.ContentLength > 0)
        {//有上传文件 先删除原有文件
            //++++++++++++++++++++++++++删除已存在的ftp文件++++++++++++++++++++++
            if (filename != "")
            {
                try
                {
                    FTP ftp1 = new FTP();
                    ftp1.Delete("archives", filename);
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

            fileName = ftp2.FTPUploadFile("archives", s, l, suffix);
            //+++++++++++++++++++++++++更新ftp文件结束++++++++++++++++++++++
        }
        //////////ftp上传结束///////////////
        string sql = "update T_InstructionDocuments set FNAME='" + T.preHandleSql(NAME) + "',QSBM='" + QSBM+"'";
        if (fileName != "#")
        {
            sql += ",SCRQ= to_date('" + SCRQ + "','yyyy-mm-dd hh24:mi:ss'),FILES='" + fileName + "'";
        }
        sql += "where FID='" + T.preHandleSql(ID) + "'";

        bool result = db.ExecuteSQL(sql);
        if (result)
        {
            InstructionDocuments instructionDocuments = new InstructionDocuments();
            instructionDocuments.FID = ID;
            instructionDocuments.FNAME = NAME;
            instructionDocuments.QSBM = QSBM;
            if (fileName != "#")
            {
                instructionDocuments.SCRQ = SCRQ;
                instructionDocuments.FILES = fileName;
            }
            else
            {
                instructionDocuments.SCRQ = scrq;
                instructionDocuments.FILES = filename;
            }

            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(instructionDocuments);
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