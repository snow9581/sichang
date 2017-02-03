<%@ WebHandler Language="C#" Class="insert_contactchange" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
///<summary> 
///模块编号：archives-06 电子档案管理子系统6号模块 insert功能代码   
///作用：<向数据库中T_CONTACTCHANGE表中录入数据>
///作者：by wya 
///编写日期：2014-08-26  
///</summary>
public class insert_contactchange : BaseHandler
{    
    public override void AjaxProcess (HttpContext context) {
        string json = "";
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

        //++++++++++++++++ begin 上传文件++++++++++++++++
        //高俊涛修改 2014-09-07 直接获取上传文件流 文件名称 和文件大小

        context.Response.ContentType = "text/plain";

        HttpPostedFile _upfile = context.Request.Files["FILES"];

        string fileName = "";//如果没有上传文件，则为空，不显示下载，高俊涛改于2014-11-11

        if (_upfile.ContentLength > 0)
        {//有上传文件

            System.IO.Stream s = _upfile.InputStream;

            int l = _upfile.ContentLength;

            FTP ftp = new FTP();

            //获得文件后缀

            string suffix = System.IO.Path.GetExtension(_upfile.FileName);

            fileName = ftp.FTPUploadFile("archives", s, l, suffix);


        }
        //++++++++++++++++ end 上传文件++++++++++++++++


        string ID = "0";
        DB db = new DB();
        string sql_id = "select SEQ_CONTACTCHANGE.nextval from dual";
        System.Data.DataTable dt = db.GetDataTable(sql_id);
        if (dt.Rows.Count > 0) ID = dt.Rows[0][0].ToString();
        
        string sql = "insert into T_ContactChange(ID,PID,PNAME,PLEADER,SPECIALLEADER,CHANGERQ," +
                    "CHANGEDETAIL,CHANGEREASON,INVESTCHANGE,FILETYPE,BZ,files) values ("+ID+",'" +
                    T.preHandleSql(PID) + "','" + T.preHandleSql(PNAME) + "','" + T.preHandleSql(PLEADER) + "','" + T.preHandleSql(SPECIALLEADER) + "'," +
                    "to_date('" + CHANGERQ + "','yyyy-mm-dd'),'" + T.preHandleSql(CHANGEDETAIL) + "','" + T.preHandleSql(CHANGEREASON) + "','" +
                    INVESTCHANGE + "','" + FILETYPE + "','" + T.preHandleSql(BZ) + "','" + fileName + "')";
        
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
            ContactChange.FILES = fileName;

            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(ContactChange);
            context.Response.Write(json);
            context.Response.End();
        }
        else
        {
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