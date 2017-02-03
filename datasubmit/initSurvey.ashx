<%@ WebHandler Language="C#" Class="initSurvey" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;
using System.Web.SessionState;
using System.Configuration;
using System.IO;

public class initSurvey : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        HttpFileCollection files = context.Request.Files;   
        string username = Convert.ToString(context.Session["username"]);
        string userlevel = Convert.ToString(context.Session["userlevel"]);
        
        string NAME = context.Request.Params["NAME"];
        string LEADER = context.Request.Params["LEADER"];
        string GYKD = context.Request.Params["GYKD"];
        string initdate = DateTime.Now.ToString();
        string state = "0";
        string requirements = context.Request.Params["REQUIREMENTS"];
        
        //++++++++++++++++ begin 上传文件++++++++++++++++
        //高俊涛修改 2014-10-08 直接获取上传文件流 文件名称 和文件大小
        context.Response.ContentType = "text/plain";
        HttpPostedFile _upfileWORD = context.Request.Files["WORDNAME"];
        HttpPostedFile _upfileEXCEL = context.Request.Files["EXCELNAME"];
        string fileWORDName = "#";//如果没有上传文件，则为#号，不显示下载
        string fileEXCELName = "#";

        if (_upfileWORD.ContentLength > 0)
        {//有上传文件

            System.IO.Stream s = _upfileWORD.InputStream;

            int l = _upfileWORD.ContentLength;

            FTP ftp = new FTP();

            //获得文件后缀

            string suffix = System.IO.Path.GetExtension(_upfileWORD.FileName);

            fileWORDName = ftp.FTPUploadFile("materialsubmit", s, l, suffix);

            //++++++++++++++++ end 上传文件++++++++++++++++
        }
        if (_upfileEXCEL.ContentLength > 0)
        {//有上传文件

            System.IO.Stream s = _upfileEXCEL.InputStream;

            int l = _upfileEXCEL.ContentLength;

            FTP ftp = new FTP();

            //获得文件后缀

            string suffix = System.IO.Path.GetExtension(_upfileEXCEL.FileName);

            fileEXCELName = ftp.FTPUploadFile("materialsubmit", s, l, suffix);

            //++++++++++++++++ end 上传文件++++++++++++++++
        }       

        DB db = new DB();
        string sql = "insert into T_INSTITUTEINVESTIGATIONFLOW(ID,INITIATOR,NAME,INITDATE,WORDNAME,EXCELNAME,STATE,GYKD,leader,requirements)" +
            " values (SEQ_INSTITUTEINVESTIGATIONFLOW.nextval,'" + username + "','" + NAME + "',to_date('" + initdate + "','yyyy-mm-dd hh24:mi:ss'),'" +
                    fileWORDName + "','" + fileEXCELName + "','" + state + "','" + GYKD + "','" + LEADER + "','"+requirements+"')";
     
        bool flag=db.ExecuteSQL(sql);        
        
        if (flag == true)
        {
            context.Response.Write("1");
        }
        else {
            context.Response.Write("0");
        }

        
      
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}