<%@ WebHandler Language="C#" Class="DesignFile" %>

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

public class DesignFile : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string id = context.Request.Params["HD_ID"];
        string username = Convert.ToString(context.Session["username"]);
        string userlevel = Convert.ToString(context.Session["userlevel"]);
        string PName = context.Request.Params["PName"];
        string PNumber = context.Request.Params["PNumber"];
        string SoluChief = context.Request.Params["SOLUCHIEF"];
        //++++++++++++++++ begin 上传文件++++++++++++++++
        //高俊涛修改 2014-10-08 直接获取上传文件流 文件名称 和文件大小
        context.Response.ContentType = "text/plain";
        HttpPostedFile _upfileWORD = context.Request.Files["INITDESIGNFILE"];
        string FileSwitch;
        FileSwitch = System.Configuration.ConfigurationSettings.AppSettings["FileSwitch"].ToString();

        string fileWORDName = "#";//如果没有上传文件，则为#号，不显示下载

        if (_upfileWORD.ContentLength > 0)
        {//有上传文件

            System.IO.Stream s = _upfileWORD.InputStream;

            int l = _upfileWORD.ContentLength;

            FTP ftp = new FTP();

            //获得文件后缀

            string suffix = System.IO.Path.GetExtension(_upfileWORD.FileName);

            fileWORDName = ftp.FTPUploadFile("archives", s, l, suffix);

            //++++++++++++++++ end 上传文件++++++++++++++++
        }

        DB db = new DB();
        string sql = "update T_PLANRUN_BDTZ  set INITDESIGNFILE='" + fileWORDName + "' ,INITIALDESISUBMITDATE_R = to_date('" + DateTime.Now.ToString() + "','yyyy-mm-dd hh24:mi:ss') where PID=" + id;
        bool flag = db.ExecuteSQL(sql);
          if (flag == true)
        {
             //////////存档/////////////
            
            if (FileSwitch == "1")
            {
                if (fileWORDName != "#")
                {
                    string FID = "p" + id;
                    string sql_INITPLAN = "insert into T_INITPLAN(ID,PID,PNAME,PLEADER,INITRQ,FILES)values ('" + FID + "','" + T.preHandleSql(PNumber) + "','" + T.preHandleSql(PName) + "','" + T.preHandleSql(SoluChief) + "',to_date('" + DateTime.Now.ToShortDateString() + "','yyyy-mm-dd'),'" + T.preHandleSql(fileWORDName) + "')";
                    bool flag1 = db.ExecuteSQL(sql_INITPLAN);//初设上报文档
                   
                    if (flag1)
                    {
                        context.Response.Write("1");
                    }
                    else
                    {
                        context.Response.Write("0");
                    }
                }
            }
            else
                context.Response.Write("1");
        }
        else
        {
            context.Response.Write("0");
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}