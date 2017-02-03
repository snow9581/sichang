﻿<%@ WebHandler Language="C#" Class="update_proofcheck" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public class update_proofcheck : BaseHandler {

    public override void AjaxProcess(HttpContext context)
    {

        string json = "";
        string ID = context.Request.Params["ID"];
        string PID = context.Request.Params["PID"];
        string PNAME = context.Request.Params["PNAME"];

        string DESIGNRQ = DateTime.Now.Date.ToString("yyyy-MM-dd");//2014-10-7,MODIFY BY WYA

        string FILENUMBER = context.Request.Params["FILENUMBER"];
        string DESIGNTYPE = context.Request.Params["DESIGNTYPE"];
        string BZ = context.Request.Params["BZ"];

        //////////ftp开始上传///////////////
        HttpPostedFile _upfile = context.Request.Files["FILES"];
        context.Response.ContentType = "text/plain";
        string fileName = "#";//如果没有上传文件，则为#号，不显示下载  
        DB db = new DB();
        string filename = "";
        string idsql = "select FILES from T_proofcheck where ID='" + T.preHandleSql(ID) + "'";
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


        string sql = "update T_proofcheck set PID='" + T.preHandleSql(PID) + "',PNAME='" + T.preHandleSql(PNAME) +
                      "',DESIGNRQ= to_date('" + DESIGNRQ + "','yyyy-mm-dd'),FILENUMBER='" + T.preHandleSql(FILENUMBER) +
                      "',DESIGNTYPE='" + DESIGNTYPE + 
                      "',BZ='" + T.preHandleSql(BZ) + "'";//高俊涛修改 2014-09-07 把文件名filename存入数据库
        if (fileName != "#")
        {
            sql += ",FILES='" + fileName + "'";
        }
        sql += " where ID='" + T.preHandleSql(ID) + "'";

       bool result=db.ExecuteSQL(sql);
       if (result)
       {
            ProofCheck proofcheck = new ProofCheck();
            proofcheck.ID = ID;
            proofcheck.PID = PID;
            proofcheck.PNAME = PNAME;
            proofcheck.DESIGNRQ = T.ChangeDate(DESIGNRQ);
            proofcheck.FILENUMBER = FILENUMBER;
            proofcheck.DESIGNTYPE = DESIGNTYPE;
            proofcheck.BZ = BZ;
            if (fileName != "#")
            {
                proofcheck.FILES = fileName;
            }
            else
            {
                proofcheck.FILES = filename;
            }

            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(proofcheck);
            context.Response.Write(json);
            context.Response.End();
       }
       else
       {
           context.Response.ContentType = "text/html";
           context.Response.Write("<script>alert('  错误!\\n更新失败！');</script>");
       }
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}