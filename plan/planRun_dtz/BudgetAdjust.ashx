<%@ WebHandler Language="C#" Class="BudgetAdjust" %>

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

public class BudgetAdjust : BaseHandler
{

    public override void AjaxProcess(HttpContext context)
    {
        string id = context.Request.Params["HD_ID"];
        string username = Convert.ToString(context.Session["username"]);
        string userlevel = Convert.ToString(context.Session["userlevel"]);
        string Remark = context.Request.Params["Remark"];

        string hd_FinalBudgetFile = context.Request.Params["hd_FinalBudgetFile"];
        string FinalBudgetFile = context.Request.Files["FinalBudgetFile"].FileName;
        string renewFinalBudgetFile = context.Request.Files["renewFinalBudgetFile"].FileName;
        string FileSwitch;
        FileSwitch = System.Configuration.ConfigurationSettings.AppSettings["FileSwitch"].ToString();
        context.Response.ContentType = "text/plain";
        string fileWORDName = hd_FinalBudgetFile;//调整后概算
        //string F_fileName = "#";
        DB db = new DB();
        if (renewFinalBudgetFile == "" && FinalBudgetFile != "")//第一次上传
        {
            HttpPostedFile _upfileWORD = context.Request.Files["FinalBudgetFile"];
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
        else if (renewFinalBudgetFile != "" && FinalBudgetFile == "")//更新
        {
            HttpPostedFile _upfile = context.Request.Files["renewFinalBudgetFile"];
            if (_upfile.ContentLength > 0)
            {//有上传文件 先删除原有文件
                //++++++++++++++++++++++++++删除已存在的ftp文件++++++++++++++++++++++
                if (hd_FinalBudgetFile != "")
                {
                    try
                    {
                        FTP ftp1 = new FTP();
                        ftp1.Delete("archives", hd_FinalBudgetFile);
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

        string sql = "update T_PLANRUN_DTZ  set FINALBUDGETFILE='" + T.preHandleSql(fileWORDName) + "'";
        if (renewFinalBudgetFile != "" || FinalBudgetFile != "")
            sql+=",BUDGETADJUSTDATE_R = to_date('" + DateTime.Now.ToString() + "','yyyy-mm-dd hh24:mi:ss')";
        sql+=",REMARK='" + T.preHandleSql(Remark) + "' where PID=" + id;
        bool flag = db.ExecuteSQL(sql);

        if (flag == true)
        {
            //////////存档/////////////
            
            if (FileSwitch == "1")
            {
                bool flag1=true;
                string FID = "p" + id;
                if (renewFinalBudgetFile == "" && FinalBudgetFile != "")
                {
                    DataTable dt = new DataTable();
                    string sql_pleader = "select PNAME,PNUMBER,PLANINVESMENT,SOLUCHIEF from T_PLANRUN_DTZ where PID=" + id + "";
                    dt = db.GetDataTable(sql_pleader);
                    if (dt.Rows.Count > 0)
                    {
                        string sql_ESTIMATE = "insert into T_ESTIMATE(ID,PNAME,PLEADER,PID,FILES,PMONEY)values('" + FID + "','" + dt.Rows[0]["PNAME"].ToString() + "','" + dt.Rows[0]["SOLUCHIEF"].ToString() + "','" + dt.Rows[0]["PNUMBER"].ToString() + "','" + fileWORDName + "','" + dt.Rows[0]["PLANINVESMENT"].ToString() + "')";
                        flag1 = db.ExecuteSQL(sql_ESTIMATE);//最终（调整后）概算文档
                    }
                }
                else if (renewFinalBudgetFile != "" && FinalBudgetFile == "")
                {
                    string sql_ESTIMATE = "update T_ESTIMATE set FILES='" + T.preHandleSql(fileWORDName) + "' where ID='" + FID + "'";
                    flag1 = db.ExecuteSQL(sql_ESTIMATE);//最终（调整后）概算文档
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