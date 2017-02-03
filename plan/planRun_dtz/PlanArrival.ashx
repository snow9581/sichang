<%@ WebHandler Language="C#" Class="PlanArrival" %>

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

public class PlanArrival : BaseHandler
{

    public override void AjaxProcess(HttpContext context)
    {
        string id = context.Request.Params["HD_ID"];
        string username = Convert.ToString(context.Session["username"]);
        string userlevel = Convert.ToString(context.Session["userlevel"]);
        string date = context.Request.Params["PLANARRIVALDATE"];
        string number = context.Request.Params["PLANARRIVALFILENUMBER"];
        string Remark = context.Request.Params["Remark"];
        string WHITEGRAPHCHECKDATE_P = context.Request.Params["WHITEGRAPHCHECKDATE_P"];
        string BLUEGRAPHDOCUMENT_P = context.Request.Params["BLUEGRAPHDOCUMENT_P"];

        string hd_PlanArrivalFile = context.Request.Params["hd_PlanArrivalFile"];
        string PlanArrivalFile = context.Request.Files["PlanArrivalFile"].FileName;
        string renewPlanArrivalFile = context.Request.Files["renewPlanArrivalFile"].FileName;
        string FileSwitch;
        FileSwitch = System.Configuration.ConfigurationSettings.AppSettings["FileSwitch"].ToString();
        context.Response.ContentType = "text/plain";
        string fileWORDName = hd_PlanArrivalFile;//上传计划下达文档 
        DB db = new DB();
        if (renewPlanArrivalFile == "" && PlanArrivalFile != "")//第一次上传
        {
            HttpPostedFile _upfileWORD = context.Request.Files["PlanArrivalFile"];
            //++++++++++++++++ begin 上传文件+++++++++++++++++++++
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
            catch { }

        }
        else if (renewPlanArrivalFile != "" && PlanArrivalFile == "")//更新
        {
            HttpPostedFile _upfile = context.Request.Files["renewPlanArrivalFile"];
            if (_upfile.ContentLength > 0)
            {//有上传文件 先删除原有文件
                //++++++++++++++++++++++++++删除已存在的ftp文件++++++++++++++++++++++
                if (hd_PlanArrivalFile != "")
                {
                    try
                    {
                        FTP ftp1 = new FTP();
                        ftp1.Delete("archives", hd_PlanArrivalFile);
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

                fileWORDName = ftp2.FTPUploadFile("archives", s, l, suffix);
                //+++++++++++++++++++++++++更新ftp文件结束++++++++++++++++++++++
            }
            //////////ftp上传结束///////////////
        }

        string sql = "update T_PLANRUN_DTZ  set PLANARRIVALFILE='" + T.preHandleSql(fileWORDName) + "' ,PLANARRIVALFILENUMBER='" + T.preHandleSql(number) +
            "', PLANARRIVALDATE = to_date('" + T.preHandleSql(date) + "','yyyy-mm-dd'), WHITEGRAPHCHECKDATE_P = to_date('" + T.preHandleSql(WHITEGRAPHCHECKDATE_P) + "','yyyy-mm-dd'), BLUEGRAPHDOCUMENT_P = to_date('" + T.preHandleSql(BLUEGRAPHDOCUMENT_P) + "','yyyy-mm-dd'),REMARK='" + T.preHandleSql(Remark) + "' where PID=" + id;
        bool flag = db.ExecuteSQL(sql);

        if (flag == true)
        {
            //////////存档/////////////
           
            if (FileSwitch == "1")
            {
                string FID = "p" + id;

                bool flag1 = true;
                if (renewPlanArrivalFile == "" && PlanArrivalFile != "")
                {
                    DataTable dt = new DataTable();
                    string sql_pleader = "select PNAME,PNUMBER,PLANINVESMENT from T_PLANRUN_DTZ where PID=" + id + "";
                    dt = db.GetDataTable(sql_pleader);
                    if (dt.Rows.Count > 0)
                    {
                        string sql_PLANREPLY_issued = "insert into T_PLANREPLY (ID,PID,PNAME,RELEASERQ,FILENUMBER,PLANMONEY,FILETYPE,FILES) values('" + FID + "i" + "','" + dt.Rows[0]["PNUMBER"].ToString() + "','" + dt.Rows[0]["PNAME"].ToString()
                            + "',to_date('" + T.preHandleSql(date) + "','yyyy-mm-dd'),'" + T.preHandleSql(number) + "','" + dt.Rows[0]["PLANINVESMENT"].ToString() + "','下达计划','" + T.preHandleSql(fileWORDName) + "')";
                        flag1 = db.ExecuteSQL(sql_PLANREPLY_issued);//计划下达
                    }
                }
                else
                {
                    string sql_PLANREPLY_issued = "update T_PLANREPLY set FILENUMBER='" + T.preHandleSql(number) + "',RELEASERQ=to_date('" + T.preHandleSql(date) + "','yyyy-mm-dd')";
                    if (renewPlanArrivalFile != "" && PlanArrivalFile == "")
                    {
                        sql_PLANREPLY_issued += ",FILES='" + T.preHandleSql(fileWORDName) + "'";
                    }
                    sql_PLANREPLY_issued+=" where ID='" + FID + "i" + "'";
                    flag1 = db.ExecuteSQL(sql_PLANREPLY_issued);//计划下达
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