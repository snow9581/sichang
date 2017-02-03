<%@ WebHandler Language="C#" Class="update_calibrator" %>

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


public class update_calibrator : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string json = "";
        string ID = context.Request.Params["ID"];
        string BZQMC = context.Request.Params["BZQMC"];
        string BXSJ = DateTime.Now.ToShortDateString();
        string FZR = context.Request.Params["FZR"];
        string WJ = context.Request.Params["WJ"];
   
        HttpPostedFile _upfile = context.Request.Files["WJ"];
        context.Response.ContentType = "text/plain";
        string fileName = "#";//如果没有上传文件，则为#号，不显示下载  
        DB db = new DB();
        string filename = "";
        string idsql = "select WJ from T_CALIBRATOR where ID='" + ID + "'";
        System.Data.DataTable dt1 = db.GetDataTable(idsql);
        if (dt1.Rows.Count > 0)
            filename = dt1.Rows[0]["WJ"].ToString();

        if (_upfile.ContentLength > 0)
        {//有上传文件 先删除原有文件
            //++++++++++++++++++++++++++删除已存在的ftp文件++++++++++++++++++++++
            if (filename != "")
            {
                try
                {
                    FTP ftp1 = new FTP();
                    ftp1.Delete("meter", filename);
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

            fileName = ftp2.FTPUploadFile("meter", s, l, suffix);
            //+++++++++++++++++++++++++更新ftp文件结束++++++++++++++++++++++
        }
      
        string sql = "update T_CALIBRATOR set BZQMC='" + T.preHandleSql(BZQMC) + "',BXSJ= to_date('" + BXSJ + "','yyyy-mm-dd'),FZR='" 
            + FZR + "'";
        if (fileName != "#")
        {
            sql += ",WJ='" + fileName + "'";
        }
            sql += " where ID=" +ID;
         
         bool result=db.ExecuteSQL(sql);
        if (result)
            {
            context.Response.ContentType = "text/plain";
            calibrator calibrator = new calibrator();
            calibrator.ID = ID;
            calibrator.BZQMC = BZQMC;
            calibrator.BXSJ = BXSJ;
            calibrator.FZR = FZR;
 if (fileName != "#")
            {
               calibrator.WJ = fileName;
            }
            else
            {
                calibrator.WJ = filename;
            }
           
            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(calibrator);
            context.Response.Write(json);
            context.Response.End();
        }
        else
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write("<script>alert('  错误!\\n更新失败！');</script>");
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}