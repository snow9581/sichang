<%@ WebHandler Language="C#" Class="ShowBlueGraph" %>

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
using System.Configuration;
using System.IO;
public class ShowBlueGraph : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string pid = context.Request.Params["b_pid"];
        string username = Convert.ToString(context.Session["username"]);
        string userlevel = Convert.ToString(context.Session["userlevel"]);
        string BlueGraph = context.Request.Params["BlueGraph"];
        string major = Convert.ToString(context.Session["major"]);
        
        //++++++++++++++++ begin 上传文件++++++++++++++++
        //高俊涛修改 2014-10-08 直接获取上传文件流 文件名称 和文件大小
        context.Response.ContentType = "text/plain";
        HttpPostedFile _upfileWORD = context.Request.Files["B_FILE"];
        DB db = new DB();
        string sql = "";
        string fileWORDName = "";
        if (BlueGraph == "")
        {
            try
            {
                if (_upfileWORD.ContentLength > 0)
                {//有上传文件

                    System.IO.Stream s = _upfileWORD.InputStream;

                    int l = _upfileWORD.ContentLength;

                    FTP ftp = new FTP();

                    //获得文件后缀

                    string suffix = System.IO.Path.GetExtension(_upfileWORD.FileName);

                    fileWORDName = ftp.FTPUploadFile("archives", s, l, suffix);

                    //++++++++++++++++ end 上传文件++++++++++++++++
                }
            }
            catch
            {

            }
            sql = "insert into T_BLUEGRAPH (B_ID,B_NAME,B_FILE,B_DATE,B_PID,B_MAJOR) values(SEQ_BLUEGRAPH.nextval,'" + T.preHandleSql(username) + "','" + T.preHandleSql(fileWORDName) + "',to_date('" + DateTime.Now.ToString() + "','yyyy-mm-dd hh24:mi:ss')," + T.preHandleSql(pid) + ",'" + major + "')";
        }
        else
        {
            try
            {
                if (_upfileWORD.ContentLength > 0)
                {//有上传文件 先删除原有文件
                    //++++++++++++++++++++++++++删除已存在的ftp文件++++++++++++++++++++++
                    try
                    {
                        FTP ftp1 = new FTP();
                        ftp1.Delete("archives", BlueGraph);
                    }
                    catch (Exception ex)
                    {
                        SClog.insert("error", "ftp delete in update failure" + ex.ToString());
                    }
                }
                //++++++++++++++++++++++++++删除ftp文件结束++++++++++++++++++++++
                //++++++++++++++++++++++++++更新ftp文件++++++++++++++++++++++
                System.IO.Stream s = _upfileWORD.InputStream;

                int l = _upfileWORD.ContentLength;

                FTP ftp2 = new FTP();

                //获得文件后缀

                string suffix = System.IO.Path.GetExtension(_upfileWORD.FileName);

                fileWORDName = ftp2.FTPUploadFile("archives", s, l, suffix);
                //+++++++++++++++++++++++++更新ftp文件结束++++++++++++++++++++++
            }
            catch { }
            sql = "update T_BLUEGRAPH set B_FILE='" + fileWORDName + "',B_DATE=to_date('" + DateTime.Now.ToString() + "','yyyy-mm-dd hh24:mi:ss') where B_PID=" + pid + " and B_NAME='" + username + "'";
        }
        bool flag = db.ExecuteSQL(sql);
        if (flag == true)
        {
            //////////存档/////////////
            string FileSwitch;
            FileSwitch = System.Configuration.ConfigurationSettings.AppSettings["FileSwitch"].ToString();
            if (FileSwitch == "1")
            {
                string FID = "p" + pid;
                bool flag1 = true;
                if (fileWORDName != "")
                {
                    if (BlueGraph == "")
                    {
                        DataTable dt = new DataTable();
                        string sql_pleader = "select PNAME,PNUMBER,DESICHIEF from T_PLANRUN_DTZ where PID=" + pid + "";
                        dt = db.GetDataTable(sql_pleader);
                        if (dt.Rows.Count > 0)
                        {
                            string sql_construction = "insert into T_construction (ID,PID,PNAME,PLEADER,DESIGNRQ,DESIGNSPECIAL,SPECIALPERSON,FILES) values('" + FID + username + "','" + dt.Rows[0]["PNUMBER"].ToString() + "','" + dt.Rows[0]["PNAME"].ToString() + "','" + dt.Rows[0]["DESICHIEF"].ToString() + "',to_date('" + DateTime.Now.ToShortDateString() + "','yyyy-mm-dd'),'" + major + "','" + username + "','" + T.preHandleSql(fileWORDName) + "')";
                            flag1 = db.ExecuteSQL(sql_construction);//蓝图
                        }
                    }
                    else
                    {
                        string sql_construction = "update T_construction set FILES='" + T.preHandleSql(fileWORDName) + "',DESIGNRQ=to_date('" + DateTime.Now.ToShortDateString() + "','yyyy-mm-dd') where PNAME = (select PNAME from T_PLANRUN_DTZ where PID='" + pid + "') and SPECIALPERSON='" + username + "'";
                        flag1 = db.ExecuteSQL(sql_construction);//蓝图 
                    }
                }
                if (flag1)
                {
                    context.Response.Write("1");
                }
                else
                {
                    context.Response.Write("0");
                }
            }
            ///////////存档结束//////////////
            else
                context.Response.Write("1");
        }
        else
        {
            context.Response.Write("0");
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}