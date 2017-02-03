<%@ WebHandler Language="C#" Class="insert_calibrator" %>

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
public class insert_calibrator : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string json = "";
        string BZQMC = context.Request.Params["BZQMC"];
        string BXSJ = DateTime.Now.ToShortDateString();    
        string FZR = context.Request.Params["FZR"];
        string WJ = context.Request.Params["WJ"]; 
        //高俊涛修改 2014-09-07 直接获取上传文件流 文件名称 和文件大小

        context.Response.ContentType = "text/plain";
        
        HttpPostedFile _upfile = context.Request.Files["WJ"];

        string fileName = "";//如果没有上传文件，则为空，不显示下载，高俊涛改于2014-11-11

        if (_upfile.ContentLength > 0)            
        {//有上传文件

            System.IO.Stream s = _upfile.InputStream;

            int l = _upfile.ContentLength;

            FTP ftp = new FTP();

            //获得文件后缀

            string suffix = System.IO.Path.GetExtension(_upfile.FileName);

            fileName = ftp.FTPUploadFile("meter", s, l, suffix);

            //++++++++++++++++ end 上传文件++++++++++++++++
        }                                               
        string ID = "0";
        DB db = new DB();
        string sql_id = "select SEQ_CALIBRATOR.nextval from dual";
        System.Data.DataTable dt = db.GetDataTable(sql_id);
        if (dt.Rows.Count > 0) ID = dt.Rows[0][0].ToString();

        string sql = "insert into T_CALIBRATOR(ID,BZQMC,BXSJ,FZR,WJ) values (" + ID + ",'" + BZQMC + "',to_date('" + BXSJ + "','yyyy-mm-dd'),'" + T.preHandleSql(FZR) + "','" + fileName + "')";
        bool result=db.ExecuteSQL(sql);

        if (result)
        {
            calibrator calibrator = new calibrator();
            calibrator.ID = ID;
            calibrator.BZQMC = BZQMC;
            calibrator.BXSJ = BXSJ;
            calibrator.FZR = FZR;
            calibrator.WJ = fileName;
            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(calibrator);
            context.Response.Write(json);
            context.Response.End();
        }
        else {
            context.Response.ContentType = "text/html";
            context.Response.Write("<script>alert('  错误!\\n添加失败！');</script>");
        }
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}