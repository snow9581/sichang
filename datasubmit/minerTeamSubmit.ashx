<%@ WebHandler Language="C#" Class="minerTeamSubmit" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Configuration;

public class minerTeamSubmit : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string id = context.Request.Params["HD_ID"];
        string tjfs = context.Request.Params["TJFS"];//是直接提交，还是汇总提交
           
        string initdate = DateTime.Now.ToString();
        //++++++++++++++++ begin 上传文件++++++++++++++++
        //高俊涛修改 2014-10-08 直接获取上传文件流 文件名称 和文件大小
        context.Response.ContentType = "text/plain";
   //     HttpPostedFile _upfileWORD = context.Request.Files["WORDNAME"];
        HttpPostedFile _upfileEXCEL = context.Request.Files["EXCELNAME"];
        //string fileWORDName = "#";//如果没有上传文件，则为#号，不显示下载
        string fileEXCELName = "#";
        if (_upfileEXCEL.ContentLength > 0)
        {//有上传文件

            System.IO.Stream s = _upfileEXCEL.InputStream;

            int l = _upfileEXCEL.ContentLength;

            FTP ftp = new FTP();

            //获得文件后缀

            string suffix = System.IO.Path.GetExtension(_upfileEXCEL.FileName);

            fileEXCELName = ftp.FTPUploadFile("materialsubmit", s, l, suffix);
        }       

        //++++++++++++++++ end 上传文件++++++++++++++++

        string km = "";

        if (context.Session["km"] != null) km = context.Session["km"].ToString();

        DB db = new DB();
        string sql = "update t_minerflow set minerteamcheck = '1', minerTime = to_date('" + DateTime.Now.ToString() + "','yyyy-mm-dd hh24:mi:ss'), submittype ='" + tjfs + "',excelname='" + fileEXCELName + "' where id=" + id + " and minername='" + km + "'";
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
    public string GetKM(string DM)
    {
        string km = "";
        DB db = new DB();
        string sql = "select km from t_dept where dm = '" + DM + "'";
        System.Data.DataTable dt = new System.Data.DataTable();
        dt = db.GetDataTable(sql);
        if (dt.Rows.Count > 0)
        {
            km = dt.Rows[0][0].ToString();
        }
        return km;

    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}