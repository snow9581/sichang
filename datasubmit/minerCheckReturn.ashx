<%@ WebHandler Language="C#" Class="minerCheckReturn" %>

using System;
using System.Web;
using System.Configuration;
using System.Web.SessionState;

public class minerCheckReturn : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string id = context.Request.Params["HD_ID"];
        string tjfs = context.Request.Params["TJFS"];
        string WORDNAME = context.Request.Params["WORDNAME"];
        string EXCELNAME = context.Request.Params["EXCELNAME"];
        string initdate = DateTime.Now.ToString();
        //++++++++++++++++ begin 上传文件++++++++++++++++
        context.Response.ContentType = "text/plain";
        HttpPostedFile _upfileEXCEL = context.Request.Files["EXCELNAME"];
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
        string sql = "update t_minerflow set minerteamcheck = '1', minerTime = to_date('" + DateTime.Now.ToString() + "','yyyy-mm-dd hh24:mi:ss'),minercheck = null,mineropinion = '', submittype ='" + tjfs + "',excelname='" + fileEXCELName + "' where id=" + id + " and minername='" + km + "'";
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