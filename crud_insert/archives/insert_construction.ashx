<%@ WebHandler Language="C#" Class="insert_construction" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
///<summary> 
///模块编号：archives-04 电子档案管理子系统4号模块 insert功能代码   
///作用：<向数据库中T_Construction表中录入数据>
///作者：by wya 
///编写日期：2014-08-26  
///</summary>
public class insert_construction : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string json = "";
        string PID = context.Request.Params["PID"];
        string PNAME = context.Request.Params["PNAME"];

        string DESIGNRQ = DateTime.Now.Date.ToString("yyyy-MM-dd");//2014-10-7,MODIFY BY WYA

        string PLEADER = context.Request.Params["PLEADER"];
        string MAINWORK = context.Request.Params["MAINWORK"];
        string KWORDS = context.Request.Params["KWORDS"];
        string DESIGNSPECIAL = context.Request.Params["DESIGNSPECIAL"];
        string SPECIALPERSON = context.Request.Params["SPECIALPERSON"];
        string FILENUMBER = context.Request.Params["FILENUMBER"];
        string REVIEWER = context.Request.Params["REVIEWER"];
        string BZ = context.Request.Params["BZ"];
        string ARRIVALDATE = context.Request.Params["ARRIVALDATE"];
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
        string sql_id = "select SEQ_CONSTRUCTION.nextval from dual";
        System.Data.DataTable dt = db.GetDataTable(sql_id);
        if (dt.Rows.Count > 0) ID = dt.Rows[0][0].ToString();
        
        string sql = "insert into T_construction(ID,PID,PNAME,DESIGNRQ,PLEADER,MAINWORK,KWORDS," +
                    "DESIGNSPECIAL,SPECIALPERSON,FILENUMBER,REVIEWER,BZ,files,ARRIVALDATE) values (" + ID + ",'" +
                    T.preHandleSql(PID) + "','" + T.preHandleSql(PNAME) + "'," +"to_date('" + DESIGNRQ + "','yyyy-mm-dd'),'" +
                    T.preHandleSql(PLEADER) + "','" + T.preHandleSql(MAINWORK) + "','" + T.preHandleSql(KWORDS) + "','" +
                    DESIGNSPECIAL + "','" + SPECIALPERSON + "','" + T.preHandleSql(FILENUMBER) + "','" + T.preHandleSql(REVIEWER) + "','" + T.preHandleSql(BZ) + "','" + fileName + "',to_date('" + ARRIVALDATE + "','yyyy-mm-dd'))";
        
       bool result=db.ExecuteSQL(sql);
       if (result)
       {
           Construction construction = new Construction();
           construction.ID = ID;
           construction.PID = PID;
           construction.PNAME = PNAME;
           construction.DESIGNRQ = T.ChangeDate(DESIGNRQ);
           construction.PLEADER = PLEADER;
           construction.MAINWORK = MAINWORK;
           construction.KWORDS = KWORDS;
           construction.DESIGNSPECIAL = DESIGNSPECIAL;
           construction.SPECIALPERSON = SPECIALPERSON;
           construction.FILENUMBER = FILENUMBER;
           construction.REVIEWER = REVIEWER;
           construction.BZ = BZ;
           construction.FILES = fileName;
           construction.ARRIVALDATE = ARRIVALDATE;
           JavaScriptSerializer jss = new JavaScriptSerializer();
           json = jss.Serialize(construction);
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