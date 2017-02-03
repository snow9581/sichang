<%@ WebHandler Language="C#" Class="SubmitBlueGraph" %>

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

public class SubmitBlueGraph : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string pname = context.Request.Params["PName"];
        string pnum = context.Request.Params["PNumber"];
        string pdesigner = context.Request.Params["planDesigner"];
        string username = Convert.ToString(context.Session["username"]);
        string hd_BlueGraph = context.Request.Params["hd_BlueGraph"];
        string b_bz = context.Request.Params["B_BZ"];
        string major = Convert.ToString(context.Session["major"]);

        //++++++++++++++++ begin 上传文件++++++++++++++++
        //高俊涛修改 2014-10-08 直接获取上传文件流 文件名称 和文件大小
        context.Response.ContentType = "text/plain";
        HttpPostedFile _upfileWORD = context.Request.Files["B_FILE"];
        DB db = new DB();
        string sql = "";
        string fileWORDName = "";
        if (hd_BlueGraph == "")
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

                    fileWORDName = ftp.FTPUploadFile("archives", s, l, suffix);

                    //++++++++++++++++ end 上传文件++++++++++++++++
                }
            }
            catch
            {

            }
            sql = "insert into T_CONSTRUCTION (ID,PNAME,PLEADER,SPECIALPERSON,FILES,DESIGNRQ,PID,DESIGNSPECIAL,BZ) values(SEQ_CONSTRUCTION.nextval,'"+pname+"','" + pdesigner + "','" + T.preHandleSql(username) + "','" + T.preHandleSql(fileWORDName) + "',to_date('" + DateTime.Now.ToString() + "','yyyy-mm-dd hh24:mi:ss'),'" + T.preHandleSql(pnum) + "','" + major + "','" + b_bz + "')";
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
                        ftp1.Delete("archives", hd_BlueGraph);
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

                fileWORDName = ftp2.FTPUploadFile("archives", s, l, suffix);
                //+++++++++++++++++++++++++更新ftp文件结束++++++++++++++++++++++
            }
            catch { }
            sql = "update T_CONSTRUCTION set FILES='" + fileWORDName + "',DESIGNRQ=to_date('" + DateTime.Now.ToString() + "','yyyy-mm-dd hh24:mi:ss'),BZ='" + b_bz + "' where SPECIALPERSON='" + username + "' and PNAME='"+pname+"'";
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