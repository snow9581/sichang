<%@ WebHandler Language="C#" Class="update_desiConditionTable" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public class update_desiConditionTable : BaseHandler {

    public override void AjaxProcess(HttpContext context)
    {
        string json = "";
        string PID = context.Request.Params["PID"];
        string PNAME = context.Request.Params["PNAME"];

        string BXRQ = DateTime.Now.Date.ToString("yyyy-MM-dd");

        string PLEADER = context.Request.Params["PLEADER"];
        string PMONEY = context.Request.Params["PMONEY"];
        string MAINWORK = context.Request.Params["MAINWORK"];
        string KWORDS = context.Request.Params["KWORDS"];
        string INVESTTYPE = context.Request.Params["INVESTTYPE"];
        string REVIEWER = context.Request.Params["REVIEWER"];
        string BZ = context.Request.Params["BZ"];
        string ID = context.Request.Params["ID"];
        //string FILES = context.Request.Params["FILES"];

        //////////ftp开始上传///////////////
        HttpPostedFile _upfile = context.Request.Files["FILES"];
        context.Response.ContentType = "text/plain";
        string fileName = "#";//如果没有上传文件，则为#号，不显示下载  
        DB db = new DB();
        string filename = "";
        string idsql = "select FILES from T_DESICONDITIONTABLE where ID='" + T.preHandleSql(ID) + "'";
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


        string sql = "update T_DESICONDITIONTABLE set PID='" + T.preHandleSql(PID) + "',PNAME='" + T.preHandleSql(PNAME) +
                      "',BXRQ= to_date('" + BXRQ + "','yyyy-mm-dd'),PLEADER='" + T.preHandleSql(PLEADER) + "',PMONEY='" + PMONEY +
                      "',MAINWORK='" + T.preHandleSql(MAINWORK) + "',KWORDS='" + T.preHandleSql(KWORDS) + "',INVESTTYPE='" + INVESTTYPE + "',REVIEWER='" + T.preHandleSql(REVIEWER) +
                      "',BZ='" + T.preHandleSql(BZ) + "'";//高俊涛修改 2014-09-07 把文件名filename存入数据库
        if (fileName != "#")
        {
            sql += ",FILES='" + fileName + "'";
        }
        sql += " where ID='" + T.preHandleSql(ID) + "'";

        bool result = db.ExecuteSQL(sql);
        if (result)
        {
            Plan plan = new Plan();   //设计条件表与方案文档字段相同，使用同一个类
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
            if (fileName != "#")
            {
                plan.FILES = fileName;
            }
            else
            {
                plan.FILES = filename;
            }

            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(plan);
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