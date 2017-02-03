<%@ WebHandler Language="C#" Class="long_plan2" %>

using System;
using System.Web;

public class long_plan2 : BaseHandler {

    public override void AjaxProcess(HttpContext context)
    {

        string ID = context.Request.Params["ID"];
        string PName = context.Request.Params["PName"];
        //string SoluCompDate_R = context.Request.Params["SoluCompDate_R"];
        //string InstCheckDate_R =context.Request.Params["InstCheckDate_R"];
        //string FactCheckDate_R = context.Request.Params["FactCheckDate_R"];
        string SoluCompDate_R="";
        string InstCheckDate_R = ""; 
        string FactCheckDate_R ="";
        string sql = "update T_PLANRUN_ZCQ set PNAME='"+T.preHandleSql(PName)+"'";
        string fileName1 = context.Request.Params["DraftSolutionFile"];
        string fileName2 = context.Request.Params["InstApprSolutionFile"];
        string fileName3 = context.Request.Params["FactAppSolutionFile"];
        //如果曾经已经上传过文件，就将文件名变为原来的文件名
        if (context.Request.Params["in_DraftSolutionFile"] != "" && context.Request.Params["in_DraftSolutionFile"] != "#")
            fileName1 = context.Request.Params["in_DraftSolutionFile"];
        else
            fileName1 = "#";
        if (context.Request.Params["in_InstApprSolutionFile"] != "" && context.Request.Params["in_InstApprSolutionFile"] != "#")
            fileName2 = context.Request.Params["in_InstApprSolutionFile"];
        else
            fileName2 = "#";
        if (context.Request.Params["in_FactAppSolutionFile"] != "" && context.Request.Params["in_FactAppSolutionFile"] != "#")
            fileName3 = context.Request.Params["in_FactAppSolutionFile"];
        else
            fileName3 = "#";
        /////////////////文件上传/////////////////////////////////
        try
        {
            HttpPostedFile _upfile = context.Request.Files["DraftSolutionFile"];
            if (_upfile.ContentLength > 0)
            {
                System.IO.Stream s = _upfile.InputStream;
                int l = _upfile.ContentLength;
                FTP ftp = new FTP();
                //获得文件后缀
                string suffix = System.IO.Path.GetExtension(_upfile.FileName);
                fileName1 = ftp.FTPUploadFile("ftp_planfile", s, l, suffix);
                SoluCompDate_R = havetime();
            }
          
            HttpPostedFile _upfile2 = context.Request.Files["InstApprSolutionFile"];
            if (_upfile2.ContentLength > 0)
            {//有上传文件
                System.IO.Stream s2 = _upfile2.InputStream;
                int l2 = _upfile2.ContentLength;
                FTP ftp = new FTP();
                //获得文件后缀
                string suffix2 = System.IO.Path.GetExtension(_upfile2.FileName);
                fileName2 = ftp.FTPUploadFile("ftp_planfile", s2, l2, suffix2);
                InstCheckDate_R = havetime();
            }

            HttpPostedFile _upfile3 = context.Request.Files["FactAppSolutionFile"];
            if (_upfile3.ContentLength > 0)
            {//有上传文件
                System.IO.Stream s3 = _upfile3.InputStream;
                int l3 = _upfile3.ContentLength;
                FTP ftp = new FTP();
                //获得文件后缀
                string suffix3 = System.IO.Path.GetExtension(_upfile3.FileName);
                fileName3 = ftp.FTPUploadFile("ftp_planfile", s3, l3, suffix3);
                FactCheckDate_R = havetime();
            }

            if (fileName1 == "")
                fileName1 = "#";
            if (fileName2 == "")
                fileName2 = "#";
            if (fileName3 == "")
                fileName3 = "#";        
        }
        catch
        {
        }
        /////////////////文件上传结束/////////////////////////////////
        if (SoluCompDate_R != ""&&SoluCompDate_R != null)
            sql += ",SoluCompDate_R=to_date('" + SoluCompDate_R + "','yyyy-mm-dd')";
        if (InstCheckDate_R != "" && InstCheckDate_R != null)
            sql += ",InstCheckDate_R=to_date('" + InstCheckDate_R + "','yyyy-mm-dd')";
        if (FactCheckDate_R != "" && FactCheckDate_R != null)
            sql += ",FactCheckDate_R=to_date('" + FactCheckDate_R + "','yyyy-mm-dd')";
        sql = sql + ",DRAFTSOLUTIONFILE='" + fileName1 + "',INSTAPPRSOLUTIONFILE='" + fileName2 + "',FACTAPPRSOLUTIONFILE='" + fileName3 + "'";
        sql += " where PID=" + ID;
        DB db = new DB();
        bool flag = db.ExecuteSQL(sql);

        if (flag == true)
        {
            context.Response.Write("1");
        }
        else
        {
            context.Response.Write("0");
        }
    }
    public string havetime()
    {
        return DateTime.Now.ToString("yyyy-MM-dd");
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}