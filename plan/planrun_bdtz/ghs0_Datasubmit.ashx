<%@ WebHandler Language="C#" Class="ghs0_Datasubmit" %>

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

public class ghs0_Datasubmit : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string hi_id = context.Request.Params["HD_ID"];
        string YCZLSubmitDate = context.Request.Params["YCZLSubmitDate"];
        string CYZLSubmitDate = context.Request.Params["CYZLSubmitDate"];
        string DMZLDelegateDate = context.Request.Params["DMZLDelegateDate"];
        string in_DMZLFILE=context.Request.Params["in_DMZLFILE"].ToString();
        string in_CYZLFILE=context.Request.Params["in_CYZLFILE"].ToString();
        string in_YCZLFILE = context.Request.Params["in_YCZLFILE"].ToString();
        string fileName1 = "#";
        string fileName2 = "#";
        string fileName3 = "#";
        
        /////////////////文件上传/////////////////////////////////
        try
        {
            HttpPostedFile _upfile = context.Request.Files["YCZLFILE"];
            if (_upfile.ContentLength > 0)
            {

                System.IO.Stream s = _upfile.InputStream;
                int l = _upfile.ContentLength;
                FTP ftp = new FTP();
                //获得文件后缀
                string suffix = System.IO.Path.GetExtension(_upfile.FileName);
                fileName1 = ftp.FTPUploadFile("ftp_planfile", s, l, suffix);
            }
            else
                fileName1 = in_YCZLFILE;

            HttpPostedFile _upfile2 = context.Request.Files["CYZLFILE"];
            if (_upfile2.ContentLength > 0)
            {//有上传文件

                System.IO.Stream s2 = _upfile2.InputStream;
                int l2 = _upfile2.ContentLength;
                FTP ftp = new FTP();
                //获得文件后缀
                string suffix2 = System.IO.Path.GetExtension(_upfile2.FileName);
                fileName2 = ftp.FTPUploadFile("ftp_planfile", s2, l2, suffix2);
            }
            else
                fileName2 = in_CYZLFILE;

            HttpPostedFile _upfile3 = context.Request.Files["DMZLFILE"];
            if (_upfile3.ContentLength > 0)
            {//有上传文件

                System.IO.Stream s3 = _upfile3.InputStream;
                int l3 = _upfile3.ContentLength;
                FTP ftp = new FTP();
                //获得文件后缀
                string suffix3 = System.IO.Path.GetExtension(_upfile3.FileName);
                fileName3 = ftp.FTPUploadFile("ftp_planfile", s3, l3, suffix3);
            }
            else
                fileName3 = in_DMZLFILE;
        }
        catch
        {
        }
        DB db = new DB();
        string sql = "update T_PLANRUN_BDTZ set YCZLFILE='" + fileName1 + "' ,CYZLFILE='" + fileName2 + "' ,DMZLFILE='" + fileName3 + "' ,YCZLSUBMITDATE=to_date('" + YCZLSubmitDate + "','yyyy-mm-dd hh'),CYZLSUBMITDATE=to_date('" + CYZLSubmitDate + "','yyyy-mm-dd hh'),DMZLDELEGATEDATE=to_date('" + DMZLDelegateDate + "','yyyy-mm-dd hh') where PID=" + hi_id;
       

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