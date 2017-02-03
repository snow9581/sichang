<%@ WebHandler Language="C#" Class="update_contactchange" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public class update_contactchange : BaseHandler {

    public override void AjaxProcess(HttpContext context)
    {

        string json = "";
        string ID = context.Request.Params["ID"];
        string PID = context.Request.Params["PID"];
        string PNAME = context.Request.Params["PNAME"];
        string PLEADER = context.Request.Params["PLEADER"];
        string SPECIALLEADER = context.Request.Params["SPECIALLEADER"];
        string CHANGERQ = DateTime.Now.Date.ToString("yyyy-MM-dd");//2014-10-7,MODIFY BY WYA
        string CHANGEDETAIL = context.Request.Params["CHANGEDETAIL"];
        string CHANGEREASON = context.Request.Params["CHANGEREASON"];
        string INVESTCHANGE = context.Request.Params["INVESTCHANGE"];
        string FILETYPE = context.Request.Params["FILETYPE"];
        string BZ = context.Request.Params["BZ"];

        //////////ftp开始上传///////////////
        HttpPostedFile _upfile = context.Request.Files["FILES"];
        context.Response.ContentType = "text/plain";
        string fileName = "#";//如果没有上传文件，则为#号，不显示下载  
        DB db = new DB();
        string filename = "";
        string idsql = "select FILES from T_ContactChange where ID='" + T.preHandleSql(ID) + "'";
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


        string sql = "update T_ContactChange set PID='" + T.preHandleSql(PID) + "',PNAME='" + T.preHandleSql(PNAME) + "',PLEADER='" + T.preHandleSql(PLEADER) + "',SPECIALLEADER='" + T.preHandleSql(SPECIALLEADER) +
                      "',CHANGERQ= to_date('" + CHANGERQ + "','yyyy-mm-dd'),CHANGEDETAIL='" + T.preHandleSql(CHANGEDETAIL) + "',CHANGEREASON='" + T.preHandleSql(CHANGEREASON) +
                      "',INVESTCHANGE='" + INVESTCHANGE + "',FILETYPE='" + FILETYPE + 
                      "',BZ='" + T.preHandleSql(BZ) + "'";//高俊涛修改 2014-09-07 把文件名filename存入数据库

        if (fileName != "#")
        {
            sql += ",FILES='" + fileName + "'";
        }
        sql += " where ID='" + T.preHandleSql(ID) + "'";
        
       bool result=db.ExecuteSQL(sql);
       if (result)
       {
            ContactChange ContactChange = new ContactChange();
            ContactChange.ID = ID;
            ContactChange.PID = PID;
            ContactChange.PNAME = PNAME;
            ContactChange.PLEADER = PLEADER;
            ContactChange.SPECIALLEADER = SPECIALLEADER;
            ContactChange.CHANGERQ = T.ChangeDate(CHANGERQ);
            ContactChange.CHANGEDETAIL = CHANGEDETAIL;
            ContactChange.CHANGEREASON = CHANGEREASON;
            ContactChange.INVESTCHANGE = INVESTCHANGE;
            ContactChange.FILETYPE = FILETYPE;
            ContactChange.BZ = BZ;
            if (fileName != "#")
            {
                ContactChange.FILES = fileName;
            }
            else
            {
                ContactChange.FILES = filename;
            }

            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(ContactChange);
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