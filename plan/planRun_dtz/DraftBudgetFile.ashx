<%@ WebHandler Language="C#" Class="DraftBudgetFile" %>

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

public class DraftBudgetFile : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string id = context.Request.Params["w_pid"];
        string username = Convert.ToString(context.Session["username"]);
        string userlevel = Convert.ToString(context.Session["userlevel"]);
        string hd_DraftBudgetFile = context.Request.Params["hd_DraftBudgetFile"];
        
        //++++++++++++++++ begin 上传文件++++++++++++++++
        //高俊涛修改 2014-10-08 直接获取上传文件流 文件名称 和文件大小
        context.Response.ContentType = "text/plain";
        string fileWORDName = "";
        try
        {
            HttpPostedFile _upfile = context.Request.Files["DraftBudgetFile"];
            if (_upfile.ContentLength > 0)
            {//有上传文件 先删除原有文件
                //++++++++++++++++++++++++++删除已存在的ftp文件++++++++++++++++++++++
                if (hd_DraftBudgetFile != "")
                {
                    try
                    {
                        FTP ftp1 = new FTP();
                        ftp1.Delete("ftp_planfile", hd_DraftBudgetFile);
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
        catch{ }
        DB db = new DB();
        bool flag = true;
        if (fileWORDName != "")
        {
            string sql = "update T_PLANRUN_DTZ  set DRAFTBUDGETFILE='" + T.preHandleSql(fileWORDName) + "', BUDGETCOMPDATE_R = to_date('" + DateTime.Now.ToString() + "','yyyy-mm-dd hh24:mi:ss') where PID=" + id;
            flag = db.ExecuteSQL(sql);
        }
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