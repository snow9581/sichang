<%@ WebHandler Language="C#" Class="update_user" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.SessionState;
public class update_user : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        if (context.Session["userlevel"] == "" || context.Session["userlevel"] == null)
        {
            context.Response.Write("<script>alert('用户已过期,请重新登录！');window.parent.location.href ='../login.aspx'</script>");
        }
        string json = "";
        string ID = context.Request.Params["ID"];
        string USERNAME =context.Request.Params["USERNAME"];
        string USERLEVEL = context.Request.Params["USERLEVEL"];
        string MAJOR = context.Request.Params["MAJOR"];
        string DM = context.Request.Params["DM"];//高俊涛修改 2014-10-09 用户表将DEPT字段分解为DM和KM两个字段，此外定义的只是队名，矿名可根据队名获取。
        string KM = "";
        string PICTURE = context.Request.Params["PICTURE"];
        string position = User.Position(USERLEVEL);

        //////////ftp开始上传///////////////
        HttpPostedFile _upfile = context.Request.Files["PICFILE"];
        context.Response.ContentType = "text/plain";
        string fileName = "#";//如果没有上传文件，则为#号，不显示下载  
        DB db = new DB();
        string filename = "";
        string idsql = "select PICTURE from T_USER where ID='" + T.preHandleSql(ID) + "'";
        System.Data.DataTable dt = db.GetDataTable(idsql);
        if (dt.Rows.Count > 0)
            filename = dt.Rows[0]["PICTURE"].ToString();

        if (_upfile.ContentLength > 0)
        {//有上传文件 先删除原有文件
            //++++++++++++++++++++++++++删除已存在的ftp文件++++++++++++++++++++++
            if (filename != "")
            {
                try
                {
                    FTP ftp1 = new FTP();
                    ftp1.Delete("signature", filename);
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

            fileName = ftp2.FTPUploadFile("signature", s, l, suffix);
            //+++++++++++++++++++++++++更新ftp文件结束++++++++++++++++++++++
        }
        //////////ftp上传结束///////////////

        KM = db.GetKM(DM);
        string sql = "update T_USER set USERNAME='" + USERNAME + "',USERLEVEL='" + USERLEVEL +
                       "',DM='" + DM + "',MAJOR='" + MAJOR + "'";
        if (fileName != "#")
        {
            sql += ",PICTURE='" + fileName + "'";
        }
        sql = sql + " where id='" + ID + "'";
       bool result=db.ExecuteSQL(sql);
       if (result)
       {
            User user = new User();
            user.ID = ID;
            user.USERNAME = USERNAME;
            user.POSITION = position;
            user.USERLEVEL = USERLEVEL;
            user.MAJOR = MAJOR;
            user.DM = DM;
            if (fileName != "#")
            {
                user.PICTURE = fileName;
            }
            else
            {
                user.PICTURE = filename;
            }
            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(user);
            context.Response.Write(json);
            context.Response.End();
       }
       else
       {
           context.Response.Write("<script>alert('  错误!\\n更新失败！');</script>");
       }
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}