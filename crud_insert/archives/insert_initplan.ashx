<%@ WebHandler Language="C#" Class="insert_initplan" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
///<summary> 
///模块编号：archives-02 电子档案管理子系统2号模块 insert功能代码   
///作用：<向数据库中T_INITPLAN表中录入数据>
///作者：by wya 
///编写日期：2014-08-26  
///</summary>
public class insert_initplan : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string json = "";
        //string ID = context.Request.Params["ID"];
        string PID = context.Request.Params["PID"];
        string PNAME = context.Request.Params["PNAME"];

        string INITRQ = DateTime.Now.Date.ToString("yyyy-MM-dd");//2014-10-7,MODIFY BY WYA

        string PLEADER = context.Request.Params["PLEADER"];
        string KWORDS = context.Request.Params["KWORDS"];
        string DESIGNSPECIAL = context.Request.Params["DESIGNSPECIAL"];
        string FILENUMBER = context.Request.Params["FILENUMBER"];
        string REVIEWER = context.Request.Params["REVIEWER"];
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
        string sql_id = "select SEQ_INITPLAN.nextval from dual";
        System.Data.DataTable dt = db.GetDataTable(sql_id);
        if (dt.Rows.Count > 0) ID = dt.Rows[0][0].ToString();
        
        string sql = "insert into T_INITPLAN(ID,PID,PNAME,INITRQ,PLEADER,KWORDS," +
                    "DESIGNSPECIAL,FILENUMBER,REVIEWER,BZ,FILES) values ("+ID+",'" +
                    T.preHandleSql(PID) + "','" + T.preHandleSql(PNAME) + "'," +
                    "to_date('" + INITRQ + "','yyyy-mm-dd'),'" + T.preHandleSql(PLEADER) + "','" + T.preHandleSql(KWORDS) + "','" +
                    DESIGNSPECIAL + "','" + T.preHandleSql(FILENUMBER) + "','" + T.preHandleSql(REVIEWER) + "','" + T.preHandleSql(BZ) + "','"+fileName+"')";
        
        bool result=db.ExecuteSQL(sql);
        if (result)
        {
            InitPlan initplan = new InitPlan();
            initplan.ID = ID;
            initplan.PID = PID;
            initplan.PNAME = PNAME;
            initplan.INITRQ = T.ChangeDate(INITRQ);
            initplan.PLEADER = PLEADER;

            initplan.KWORDS = KWORDS;
            initplan.DESIGNSPECIAL = DESIGNSPECIAL;
            initplan.FILENUMBER = FILENUMBER;
            initplan.REVIEWER = REVIEWER;
            initplan.BZ = BZ;
            initplan.FILES = fileName;
        
            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(initplan);
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