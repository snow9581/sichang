<%@ WebHandler Language="C#" Class="teamSubmit" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Configuration;

public class teamSubmit : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string teamname = "";
        string km = "";
        if (context.Session["username"] != null)
        {
            teamname = context.Session["username"].ToString();
            km = GetKM(teamname);
        }
        string id = context.Request.Params["HD_ID"];
        string initdate = DateTime.Now.ToString();
      
        //++++++++++++++++ begin 上传文件++++++++++++++++
        //高俊涛修改 2014-10-08 直接获取上传文件流 文件名称 和文件大小
        context.Response.ContentType = "text/plain";      
        HttpPostedFile _upfileEXCEL = context.Request.Files["EXCELNAME"];
       // string fileWORDName = "#";
        string fileEXCELName = "#";//如果没有上传文件，则为#号，不显示下载

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
        string sql = "update t_team set excelname = '" + fileEXCELName + "',starttime = to_date('" + DateTime.Now.ToString() + "','yyyy-mm-dd hh24:mi:ss'),type = '已填写调查报告' where id = '" + id + "' and teamname = '" + teamname + "'";
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
    public string  GetKM(string DM)
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