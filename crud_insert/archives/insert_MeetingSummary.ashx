<%@ WebHandler Language="C#" Class="insert_MeetingSummary" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public class insert_MeetingSummary : BaseHandler {

    public override void AjaxProcess(HttpContext context)
    {

        string json = "";
        string NAME = context.Request.Params["FNAME"];
        string XFBM = context.Request.Params["XFBM"];
        string Fnumber = context.Request.Params["FNUMBER"];
        string SCRQ = "";
       
        //++++++++++++++++ begin 上传文件++++++++++++++++
        //高俊涛修改 2014-09-07 直接获取上传文件流 文件名称 和文件大小

        context.Response.ContentType = "text/plain";

        HttpPostedFile _upfile = context.Request.Files["FILES"];

        string fileName = "";//如果没有上传文件，则为空，不显示下载

        if (_upfile.ContentLength > 0)
        {//有上传文件

            System.IO.Stream s = _upfile.InputStream;

            int l = _upfile.ContentLength;

            FTP ftp = new FTP();

            //获得文件后缀

            string suffix = System.IO.Path.GetExtension(_upfile.FileName);

            fileName = ftp.FTPUploadFile("archives", s, l, suffix);


        }
        //++++++++++++++++ end 上传文件++++++++++++++++

        if (fileName != "")
            SCRQ = DateTime.Now.ToString();
        string ID = "0";
        DB db = new DB();
        string sql_id = "select SEQ_MeetingSummary.nextval from dual";
        System.Data.DataTable dt = db.GetDataTable(sql_id);
        if (dt.Rows.Count > 0) ID = dt.Rows[0][0].ToString();

        string sql = "insert into T_MeetingSummary(FID,XFBM,FNAME,FNUMBER,SCRQ,FILES) values (" + ID + ",'" + T.preHandleSql(XFBM) + "','" + T.preHandleSql(NAME) + "','" + T.preHandleSql(Fnumber) + "',to_date('" + SCRQ + "','yyyy-mm-dd hh24:mi:ss'),'" + fileName + "'";
        sql = sql + ")";
        bool result = db.ExecuteSQL(sql);
        if (result)
        {
            MeetingSummary meetingSummary = new MeetingSummary();
            meetingSummary.FID = ID;
            meetingSummary.FNAME = NAME;
            meetingSummary.SCRQ = SCRQ;
            meetingSummary.FNUMBER = Fnumber;
            meetingSummary.XFBM = XFBM;
            meetingSummary.FILES = fileName;//高俊涛修改 2014-09-07 所文件名传回主界面处理。

            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(meetingSummary);
            context.Response.Write(json);
            context.Response.End();
        }
        else
        {
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