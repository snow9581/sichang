<%@ WebHandler Language="C#" Class="writePlan" %>

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

public class writePlan : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string id = context.Request.Params["HD_ID"];
        HttpFileCollection files = context.Request.Files;
        string username = Convert.ToString(context.Session["username"]);
        string userlevel = Convert.ToString(context.Session["userlevel"]);

        string EstiInvestment = context.Request.Params["EstiInvestment"];
        string hd_DraftSolutionFile = context.Request.Params["hd_DraftSolutionFile"];
        string DraftSolutionFile = context.Request.Files["DraftSolutionFile"].FileName;
        string renewDraftSolutionFile = context.Request.Files["renewDraftSolutionFile"].FileName;
        
        string fileWORDName = hd_DraftSolutionFile;
        context.Response.ContentType = "text/plain";
        if (renewDraftSolutionFile == "" && DraftSolutionFile != "")//第一次上传
        {
            HttpPostedFile _upfileWORD= context.Request.Files["DraftSolutionFile"];
            
            //++++++++++++++++ begin 上传文件+++++++++++++++++++++
            try
            {
                if (_upfileWORD.ContentLength > 0)
                {//有上传文件

                    System.IO.Stream s = _upfileWORD.InputStream;

                    int l = _upfileWORD.ContentLength;

                    FTP ftp = new FTP();

                    //获得文件后缀

                    string suffix = System.IO.Path.GetExtension(_upfileWORD.FileName);

                    fileWORDName = ftp.FTPUploadFile("ftp_planfile", s, l, suffix);

                    //++++++++++++++++ end 上传文件++++++++++++++++
                }

            }
            catch { }

        }
        else if (renewDraftSolutionFile != "" && DraftSolutionFile == "")
        {
            HttpPostedFile _upfile = context.Request.Files["renewDraftSolutionFile"];
            if (_upfile.ContentLength > 0)
            {//有上传文件 先删除原有文件
                //++++++++++++++++++++++++++删除已存在的ftp文件++++++++++++++++++++++
                if (hd_DraftSolutionFile != "")
                {
                    try
                    {
                        FTP ftp1 = new FTP();
                        ftp1.Delete("ftp_planfile", hd_DraftSolutionFile);
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

                fileWORDName = ftp2.FTPUploadFile("ftp_planfile", s, l, suffix);
                //+++++++++++++++++++++++++更新ftp文件结束++++++++++++++++++++++
            }
            //////////ftp上传结束///////////////
        }
       
        DB db = new DB();
        string sql = "update T_PLANRUN_DTZ  set ESTIINVESTMENT='" + T.preHandleSql(EstiInvestment) + "', DRAFTSOLUTIONFILE='" + T.preHandleSql(fileWORDName) + "'";
        if (renewDraftSolutionFile != "" || DraftSolutionFile != "")
            sql = sql + ",SOLUCOMPDATE_R = to_date('" + DateTime.Now.ToString() + "','yyyy-mm-dd hh24:mi:ss')";
        sql=sql+" where PID=" + id;
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
    public bool IsReusable {
        get {
            return false;
        }
    }

}