<%@ WebHandler Language="C#" Class="WorkloadFile" %>

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

public class WorkloadFile : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string pid = context.Request.Params["hd_id"];
        string username = Convert.ToString(context.Session["username"]);
        string userlevel = Convert.ToString(context.Session["userlevel"]);
        string major = Convert.ToString(context.Session["major"]);

        string H_workloadFile = context.Request.Params["hd_WorkloadFile"];
        //++++++++++++++++ begin 上传文件++++++++++++++++
        //高俊涛修改 2014-10-08 直接获取上传文件流 文件名称 和文件大小
        context.Response.ContentType = "text/plain";
        HttpPostedFile _upfileWORD = context.Request.Files["W_FILE"];
        DB db = new DB();
        string sql = "";
        string fileWORDName = "";
        if (H_workloadFile == "")
        {
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
            catch
            {

            }
            sql = "insert into T_WORKLOADSUBMIT (W_ID,W_NAME,W_FILE,W_DATE,W_PID,W_MAJOR) values(SEQ_WORKLOADSUBMIT.nextval,'" + T.preHandleSql(username) + "','" + T.preHandleSql(fileWORDName) + "',to_date('" + DateTime.Now.ToString() + "','yyyy-mm-dd hh24:mi:ss')," + T.preHandleSql(pid) + ",'" + major + "')";
        }
        else
        {
            try
            {
                if (_upfileWORD.ContentLength > 0)
                {//有上传文件 先删除原有文件
                    //++++++++++++++++++++++++++删除已存在的ftp文件++++++++++++++++++++++
                    try
                    {
                        FTP ftp1 = new FTP();
                        ftp1.Delete("ftp_planfile", H_workloadFile);
                    }
                    catch (Exception ex)
                    {
                        SClog.insert("error", "ftp delete in update failure" + ex.ToString());
                    }
                }
                //++++++++++++++++++++++++++删除ftp文件结束++++++++++++++++++++++
                //++++++++++++++++++++++++++更新ftp文件++++++++++++++++++++++
                System.IO.Stream s = _upfileWORD.InputStream;

                int l = _upfileWORD.ContentLength;

                FTP ftp2 = new FTP();

                //获得文件后缀

                string suffix = System.IO.Path.GetExtension(_upfileWORD.FileName);

                fileWORDName = ftp2.FTPUploadFile("ftp_planfile", s, l, suffix);
                //+++++++++++++++++++++++++更新ftp文件结束++++++++++++++++++++++
            }
            catch { }
            sql = "update T_WORKLOADSUBMIT set W_FILE='" + fileWORDName + "',W_DATE=to_date('" + DateTime.Now.ToString() + "','yyyy-mm-dd hh24:mi:ss') where W_PID=" + pid + " and W_NAME='" + username + "'";
        }
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