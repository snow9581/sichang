<%@ WebHandler Language="C#" Class="insert_user" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public class insert_user : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string json = "";
        string USERNAME = context.Request.Params["USERNAME"];
        string USERLEVEL = context.Request.Params["USERLEVEL"];
        string MAJOR = context.Request.Params["MAJOR"];
        string DM = context.Request.Params["DM"];//高俊涛修改 2014-10-09 用户表将DEPT字段分解为DM和KM两个字段，此外定义的只是队名，矿名可根据队名获取。
        string PASSWORD = "123";
       // string KM = "";
        string position = User.Position(USERLEVEL);
        //string PICTURE = context.Request.Params["PICFILE"];
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

            fileName = ftp.FTPUploadFile("signature", s, l, suffix);

            //++++++++++++++++ end 上传文件++++++++++++++++
        }
        
        string ID = "0";
        DB db = new DB();
        string sql_id = "select SEQ_USER.nextval from dual";
        System.Data.DataTable dt = db.GetDataTable(sql_id);
        if (dt.Rows.Count > 0) ID = dt.Rows[0][0].ToString();
        
    //    KM = db.GetKM(DM);
    //    string sql = "insert into T_USER(ID,USERNAME,PASSWORD,USERLEVEL,MAJOR,DM,KM,PICTURE) values (" + ID + ",'" +
    //                 USERNAME + "','" + PASSWORD + "','" + USERLEVEL + "','" + MAJOR + "','" + DM + "','" + KM + "','" + fileName + "')";

        string sql = "insert into T_USER(ID,USERNAME,PASSWORD,USERLEVEL,MAJOR,DM,PICTURE) values (" + ID + ",'" +
                   USERNAME + "','" + PASSWORD + "','" + USERLEVEL + "','" + MAJOR + "','" + DM + "','" + fileName + "')";
        
        bool result=db.ExecuteSQL(sql);
        if (result)
        {
            User user = new User();
            user.ID = ID;
            user.USERNAME = USERNAME;
            user.PASSWORD = PASSWORD;
            user.POSITION = position;
            user.USERLEVEL = USERLEVEL;
            user.MAJOR = MAJOR;
            user.DM = DM;
            user.PICTURE = fileName;
            
            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(user);
            context.Response.Write(json);
            context.Response.End();
        }
        else
        {
            context.Response.Write("<script>alert('  错误!\\n添加失败！');</script>");
        }
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}