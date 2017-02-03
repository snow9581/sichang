<%@ WebHandler Language="C#" Class="planrun_part" %>


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
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public class planrun_part : BaseHandler
{
    public override void AjaxProcess(HttpContext context) 
    {
        string ID = context.Request.Params["ID"];
        string PName = context.Request.Params["PName"];
        string SoluSubmitDate = context.Request.Params["SoluSubmitDate"]; 
        string SoluAdviceReplyDate =context.Request.Params["SoluAdviceReplyDate"];
        string SoluApproveDate = context.Request.Params["SoluApproveDate"];
        string SoluCheckDate = context.Request.Params["SoluCheckDate"];
        string PNumber = context.Request.Params["PNumber"].ToString();
        string PLANINVESMENT = context.Request.Params["PLANINVESMENT"];
        string Remark = context.Request.Params["Remark"];

        string in_FinalSolutionFile = context.Request.Params["in_FinalSolutionFile"];
        string in_SoluApproveFile = context.Request.Params["in_SoluApproveFile"];
        string IN_DESICONDITIONTABLE = context.Request.Params["IN_DESICONDITIONTABLE"];
 
        string FileSwitch;
        FileSwitch = System.Configuration.ConfigurationSettings.AppSettings["FileSwitch"].ToString();
        string fileName1 = "#";
        string fileName2 = "#";
        string fileName3 = "#";
        string fileName4 = "#";
        /////////////////文件上传/////////////////////////////////

            HttpPostedFile _upfile = context.Request.Files["FactApprSolutionFile"];     ////厂审通过方案     
            if (_upfile.ContentLength > 0)
            {
                System.IO.Stream s = _upfile.InputStream;
                int l = _upfile.ContentLength;
                FTP ftp1 = new FTP();
                //获得文件后缀
                string suffix = System.IO.Path.GetExtension(_upfile.FileName);
                fileName1 = ftp1.FTPUploadFile("ftp_planfile", s, l, suffix);

            }

            HttpPostedFile _upfile2 = context.Request.Files["FinalSolutionFile"];  ///最终方案文档
            if (_upfile2.ContentLength > 0)
            {//有上传文件
                System.IO.Stream s2 = _upfile2.InputStream;
                int l2 = _upfile2.ContentLength;
                FTP ftp2 = new FTP();
                //获得文件后缀
                string suffix2 = System.IO.Path.GetExtension(_upfile2.FileName);
                fileName2 = ftp2.FTPUploadFile("archives", s2, l2, suffix2);
            }

            HttpPostedFile _upfile3 = context.Request.Files["SoluApproveFile"];  ///批复文件
            if (_upfile3.ContentLength > 0)
            {//有上传文件
                System.IO.Stream s3 = _upfile3.InputStream;
                int l3 = _upfile3.ContentLength;
                FTP ftp3 = new FTP();
                //获得文件后缀
                string suffix3 = System.IO.Path.GetExtension(_upfile3.FileName);
                fileName3 = ftp3.FTPUploadFile("archives", s3, l3, suffix3);
            }

            HttpPostedFile _upfile4 = context.Request.Files["DESICONDITIONTABLE"];  ///设计条件表
            if (_upfile4.ContentLength > 0)
            {//有上传文件
                System.IO.Stream s4 = _upfile4.InputStream;
                int l4 = _upfile4.ContentLength;
                FTP ftp4 = new FTP();
                //获得文件后缀
                string suffix4 = System.IO.Path.GetExtension(_upfile4.FileName);
                fileName4 = ftp4.FTPUploadFile("archives", s4, l4, suffix4);
            }
            
        /////////////////文件上传结束/////////////////////////////////
        string sql = "update T_PLANRUN_DTZ set PNAME='" + PName + "'";
        if (SoluSubmitDate != "" && SoluSubmitDate != null)
            sql += ",SOLUSUBMITDATE=to_date('" + T.preHandleSql(SoluSubmitDate) + "','yyyy-mm-dd')";
        if (SoluAdviceReplyDate != "" && SoluAdviceReplyDate != null)
            sql += ",SOLUADVICEREPLYDATE=to_date('" + T.preHandleSql(SoluAdviceReplyDate) + "','yyyy-mm-dd')";
        if (SoluApproveDate != "" && SoluApproveDate != null)
            sql += ",SOLUAPPROVEDATE=to_date('" + T.preHandleSql(SoluApproveDate) + "','yyyy-mm-dd')";
        if (SoluCheckDate != "" && SoluCheckDate != null)
            sql += ",SOLUCHECKDATE=to_date('" + T.preHandleSql(SoluCheckDate) + "','yyyy-mm-dd')";
        if (PLANINVESMENT != "" && PLANINVESMENT != null)
            sql += ",PLANINVESMENT='" + T.preHandleSql(PLANINVESMENT)+"'" ;
        if (PNumber != "" && PNumber != null)
            sql += ",PNUMBER='" + T.preHandleSql(PNumber) + "'";
        if (Remark != "" && Remark != null)
            sql += ",REMARK='" + T.preHandleSql(Remark) + "'";
        if (fileName1 != "#")
            sql += ",FACTAPPRSOLUTIONFILE='" + T.preHandleSql(fileName1) + "',FACTCHECKDATE_R=to_date('" + DateTime.Now.ToString() + "','yyyy-mm-dd hh24:mi:ss')";
        if (fileName2 != "#")
            sql += ",FINALSOLUTIONFILE='" + T.preHandleSql(fileName2) + "'";
        if (fileName3 != "#")
            sql += ",SOLUAPPROVEFILE='" + T.preHandleSql(fileName3 )+ "'";
        if (fileName4 != "#")
            sql += ",DESICONDITIONTABLE='" + T.preHandleSql(fileName4) + "'";
        sql += " where PID=" + ID;
        
        DB db = new DB();
        bool flag = db.ExecuteSQL(sql);
        //更新工程量信息表
        string ss = "update T_ASSIGNMENTWORKLOAD set PNUMBER='" + T.preHandleSql(PNumber) + "' where pid=" + ID;
        bool flag0 = db.ExecuteSQL(ss);
        if (flag == true && flag0 == true)
        {
            //////////存档/////////////
            
            if (FileSwitch == "1")
            {
                string FID = "p" + ID;
                string pleader = "";
                if (fileName2 != "#" || fileName3 != "#" || fileName4 != "#")
                {
                    DataTable dt = new DataTable();
                    string sql_pleader = "select SOLUCHIEF from T_PLANRUN_DTZ where PID=" + ID + "";
                    dt = db.GetDataTable(sql_pleader);
                    if (dt.Rows.Count > 0)
                    {
                        pleader = dt.Rows[0][0].ToString();
                    }
                }
                bool flag1 = true;
                if (fileName2 != "#")
                {
                    string sql_plan = "insert into T_PLAN(ID,PNAME,PLEADER,PID,FILES,BXRQ,PMONEY)values('" + FID + "','" + T.preHandleSql(PName) + "','" + pleader + "','" + T.preHandleSql(PNumber) + "','" + fileName2 + "',to_date('" + DateTime.Now.ToShortDateString() + "','yyyy-mm-dd'),'" + T.preHandleSql(PLANINVESMENT) + "')";
                    flag1 = db.ExecuteSQL(sql_plan);//最终方案
                }
                else if (in_FinalSolutionFile != "" && (PLANINVESMENT != "" || PNumber!=""))
                {
                    string sql_plan = "update T_PLAN set PID='" + T.preHandleSql(PNumber) + "',PMONEY='" + T.preHandleSql(PLANINVESMENT) + "' where ID='" + FID + "'";
                    flag1 = db.ExecuteSQL(sql_plan);//最终方案
                }
                
                bool flag2 = true;
                if (fileName4 != "#")
                {
                    string sql_DESICONDITIONTABLE = "insert into T_DESICONDITIONTABLE(ID,PNAME,PLEADER,PID,FILES,BXRQ,PMONEY)values('" + FID + "','" + T.preHandleSql(PName) + "','" + pleader + "','" + T.preHandleSql(PNumber) + "','" + fileName4 + "',to_date('" + DateTime.Now.ToShortDateString() + "','yyyy-mm-dd'),'" + T.preHandleSql(PLANINVESMENT) + "')";
                    flag2 = db.ExecuteSQL(sql_DESICONDITIONTABLE);//设计条件表
                }
                else if (IN_DESICONDITIONTABLE != "" && (PLANINVESMENT != "" || PNumber != ""))
                {
                    string sql_plan = "update T_DESICONDITIONTABLE set PID='" + T.preHandleSql(PNumber) + "',PMONEY='" + T.preHandleSql(PLANINVESMENT) + "' where ID='" + FID + "'";
                    flag2 = db.ExecuteSQL(sql_plan);//设计条件表
                }
                
                bool flag3 = true;
                if (fileName3 != "#")
                {
                    string sql_planreply = "insert into T_PLANREPLY(ID,PNAME,PID,FILES,RELEASERQ,PLANMONEY,FILETYPE)values('" + FID + "p','" + T.preHandleSql(PName) + "','" + T.preHandleSql(PNumber) + "','" + fileName3 + "',to_date('" + SoluApproveDate + "','yyyy-mm-dd'),'" + T.preHandleSql(PLANINVESMENT) + "','方案批复')";
                    flag3 = db.ExecuteSQL(sql_planreply);//方案批复
                }
                else if (in_SoluApproveFile != "" && (PLANINVESMENT != "" || PNumber != ""))
                {
                    string sql_planreply = "update T_PLANREPLY set PID='" + T.preHandleSql(PNumber) + "',PLANMONEY='" + T.preHandleSql(PLANINVESMENT) + "' where ID='" + FID + "p'";
                    flag3 = db.ExecuteSQL(sql_planreply);//方案批复
                }
                if (flag1 && flag2 && flag3)
                {
                    context.Response.Write("1");
                }
                else
                {
                    context.Response.Write("0");
                }
            }
            //////////存档结束/////////////  
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