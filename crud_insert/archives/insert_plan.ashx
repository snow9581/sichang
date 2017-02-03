<%@ WebHandler Language="C#" Class="insert_plan" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
///<summary> 
///模块编号：archives-01 电子档案管理子系统1号模块 insert功能代码   
///作用：<向数据库中T_PLAN表中录入数据>
///作者：by wya 
///编写日期：2014-08-26  
///</summary>
public class insert_plan : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string json = "";

        string PID = context.Request.Params["PID"];
        string PNAME = context.Request.Params["PNAME"];
        //string BXRQ = context.Request.Params["BXRQ"];
        string BXRQ = DateTime.Now.Date.ToString("yyyy-MM-dd");
        //if (BXRQ.Contains("-")) //如果不为空，为日期格式，还没细判断
        //{
        //    BXRQ = Convert.ToDateTime(BXRQ).ToShortDateString();
        //}

        string PLEADER = context.Request.Params["PLEADER"];
        string PMONEY = context.Request.Params["PMONEY"];
        string MAINWORK = context.Request.Params["MAINWORK"];
        string KWORDS = context.Request.Params["KWORDS"];
        string INVESTTYPE = context.Request.Params["INVESTTYPE"];
        string REVIEWER = context.Request.Params["REVIEWER"];
        string BZ = context.Request.Params["BZ"];
        //string FILES = context.Request.Params["FILES"];
        //string ARCHIVES=context.Request.Params["ARCHIVES"];

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

        string ID = "0";
        DB db = new DB();
        string sql_id = "select SEQ_PLAN.nextval from dual";
        System.Data.DataTable dt = db.GetDataTable(sql_id);
        if (dt.Rows.Count > 0) ID = dt.Rows[0][0].ToString();
       
        string sql = "insert into T_PLAN(ID,PID,PNAME,BXRQ,PLEADER,PMONEY,MAINWORK,KWORDS," +
                    "INVESTTYPE,REVIEWER,BZ,FILES) values ("+ID+",'" +
                    T.preHandleSql(PID) + "','" +T.preHandleSql(PNAME) + "'," +
                    "to_date('" + BXRQ + "','yyyy-mm-dd'),'" + T.preHandleSql(PLEADER) + "','" + PMONEY + "','" +
                    T.preHandleSql(MAINWORK) + "','" + T.preHandleSql(KWORDS) + "','" + INVESTTYPE + "','" + T.preHandleSql(REVIEWER) + "','" + T.preHandleSql(BZ) + "','" + fileName + "')";
        
        bool result=db.ExecuteSQL(sql);
        if (result)
        {
            Plan plan = new Plan();
            plan.ID = ID;
            plan.PID = PID;
            plan.PNAME = PNAME;
            plan.BXRQ = T.ChangeDate(BXRQ);
            plan.PLEADER = PLEADER;
            plan.PMONEY = PMONEY;
            plan.MAINWORK = MAINWORK;
            plan.KWORDS = KWORDS;
            plan.INVESTTYPE = INVESTTYPE;
            plan.REVIEWER = REVIEWER;
            plan.BZ = BZ;
            plan.FILES = fileName;//高俊涛修改 2014-09-07 所文件名传回主界面处理。
        
            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(plan);
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