<%@ WebHandler Language="C#" Class="insert_CommissionInformation" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public class insert_CommissionInformation : BaseHandler
{
    public override void AjaxProcess (HttpContext context) {
        string json = "";
        //string ID = context.Request.Params["ID"];
        string PNUMBER = context.Request.Params["PNUMBER"];
        string PNAME = context.Request.Params["PNAME"];
        string CONSIGNER = context.Request.Params["CONSIGNER"];
        string CONSIGNERMAJOR = context.Request.Params["CONSIGNERMAJOR"];
        string SENDEE = context.Request.Params["SENDEE"];
        string SENDEEMAJOR = context.Request.Params["SENDEEMAJOR"];
        string RELEASERQ = DateTime.Now.Date.ToString("yyyy-MM-dd");//2014-10-7,MODIFY BY WYA
        string FILETYPE = context.Request.Params["FILETYPE"];
        string BZ = context.Request.Params["BZ"];

        //++++++++++++++++ begin 上传文件++++++++++++++++
        //高俊涛修改 2014-09-07 直接获取上传文件流 文件名称 和文件大小

        context.Response.ContentType = "text/plain";

        HttpPostedFile _upfile = context.Request.Files["FILES"];

        string fileName = "";//如果没有上传文件，则为空，不显示下载，高俊涛改于2014-11-11

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

        string ID = "0";
        DB db = new DB();
        string sql_id = "select SEQ_ComInf.nextval from dual";
        System.Data.DataTable dt = db.GetDataTable(sql_id);
        if (dt.Rows.Count > 0) ID = dt.Rows[0][0].ToString();

        string sql = "insert into T_COMMISSIONINFORMATION(ID,PNUMBER,PNAME,CONSIGNER,CONSIGNERMAJOR,SENDEE,SENDEEMAJOR,RELEASERQ," +
                    "FILETYPE,BZ,files) values (" + ID + ",'" +
                    T.preHandleSql(PNUMBER) + "','" + T.preHandleSql(PNAME) + "','" + T.preHandleSql(CONSIGNER) + "','" + T.preHandleSql(CONSIGNERMAJOR) + "','" + T.preHandleSql(SENDEE) + "','" + T.preHandleSql(SENDEEMAJOR) + "'" +
                    ",to_date('" + RELEASERQ + "','yyyy-mm-dd'),'" + FILETYPE + "','" + T.preHandleSql(BZ) + "','" + fileName + "')";

        bool result = db.ExecuteSQL(sql);
        if (result)
        {
            CommissionInformation CommissionInformation = new CommissionInformation();
            CommissionInformation.ID = ID;
            CommissionInformation.PNUMBER = PNUMBER;
            CommissionInformation.PNAME = PNAME;
            CommissionInformation.CONSIGNER = CONSIGNER;
            CommissionInformation.CONSIGNERMAJOR = CONSIGNERMAJOR;
            CommissionInformation.SENDEE = SENDEE;
            CommissionInformation.SENDEEMAJOR = SENDEEMAJOR;
            CommissionInformation.RELEASERQ = T.ChangeDate(RELEASERQ);
            CommissionInformation.FILETYPE = FILETYPE;
            CommissionInformation.BZ = BZ;
            CommissionInformation.FILES = fileName;

            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(CommissionInformation);
            context.Response.Write(json);
            context.Response.End();
        }
        else
        {
            context.Response.ContentType = "text/html";
            context.Response.Write("<script>alert('  错误!\\n添加失败！');</script>");
        }

    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}