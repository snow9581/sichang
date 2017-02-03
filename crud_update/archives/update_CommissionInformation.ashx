<%@ WebHandler Language="C#" Class="update_CommissionInformation" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public class update_CommissionInformation : BaseHandler 
{
    public override void AjaxProcess(HttpContext context)
    {
        string json = "";
        string ID = context.Request.Params["ID"];
        string PNUMBER = context.Request.Params["PNUMBER"];
        string PNAME = context.Request.Params["PNAME"];
        string CONSIGNER = context.Request.Params["CONSIGNER"];
        string CONSIGNERMAJOR = context.Request.Params["CONSIGNERMAJOR"];
        string SENDEE = context.Request.Params["SENDEE"];
        string SENDEEMAJOR = context.Request.Params["SENDEEMAJOR"];
        
        string RELEASERQ = DateTime.Now.Date.ToString("yyyy-MM-dd");//2014-10-7,MODIFY BY WYA
        string FILETYPE = context.Request.Params["FILETYPE"];
        string BZ = context.Request.Params["BZ"];

        //////////ftp开始上传///////////////
        HttpPostedFile _upfile = context.Request.Files["FILES"];
        context.Response.ContentType = "text/plain";
        string fileName = "#";//如果没有上传文件，则为#号，不显示下载  
        DB db = new DB();
        string filename = "";
        string idsql = "select FILES from T_COMMISSIONINFORMATION where ID='" + T.preHandleSql(ID) + "'";
        System.Data.DataTable dt = db.GetDataTable(idsql);
        if (dt.Rows.Count > 0)
            filename = dt.Rows[0]["FILES"].ToString();

        if (_upfile.ContentLength > 0)
        {//有上传文件 先删除原有文件
            //++++++++++++++++++++++++++删除已存在的ftp文件++++++++++++++++++++++
            if (filename != "")
            {
                try
                {
                    FTP ftp1 = new FTP();
                    ftp1.Delete("archives", filename);
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

            fileName = ftp2.FTPUploadFile("archives", s, l, suffix);
            //+++++++++++++++++++++++++更新ftp文件结束++++++++++++++++++++++
        }
        //////////ftp上传结束///////////////

        string sql = "update T_COMMISSIONINFORMATION set PNUMBER='" + T.preHandleSql(PNUMBER) + "',PNAME='" + T.preHandleSql(PNAME) +
                        "',CONSIGNER='" + T.preHandleSql(CONSIGNER) + "',CONSIGNERMAJOR='" + T.preHandleSql(CONSIGNERMAJOR) +
                        "',SENDEE='" + T.preHandleSql(SENDEE) + "',SENDEEMAJOR='" + T.preHandleSql(SENDEEMAJOR) +
                      "',RELEASERQ= to_date('" + RELEASERQ + "','yyyy-mm-dd'),FILETYPE='" + FILETYPE +
                      "',BZ='" + T.preHandleSql(BZ) + "'";//高俊涛修改 2014-09-07 把文件名filename存入数据库
        if (fileName != "#")
        {
            sql += ",FILES='" + fileName + "'";
        }
        sql += " where ID='" + T.preHandleSql(ID) + "'";

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
          
            if (fileName != "#")
            {
                CommissionInformation.FILES = fileName;
            }
            else
            {
                CommissionInformation.FILES = filename;
            }

            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(CommissionInformation);
            context.Response.Write(json);
            context.Response.End();
        }
        else
        {
            context.Response.ContentType = "text/html";
            context.Response.Write("<script>alert('  错误!\\n更新失败！');</script>");
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