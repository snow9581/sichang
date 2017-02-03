<%@ WebHandler Language="C#" Class="long_plan1" %>

using System;
using System.Web;
using System.Data;
public class long_plan1 : BaseHandler {

    public override void AjaxProcess(HttpContext context)
    {
 
        string ID = context.Request.Params["ID"];
        string PName = context.Request.Params["PName"];
        string SoluChief = context.Request.Params["SoluChief"];
        string SoluSubmitDate = context.Request.Params["SoluSubmitDate"]; 
        string SoluCheckDate = context.Request.Params["SoluCheckDate"];
        string SoluAdviceReplyDate = context.Request.Params["SoluAdviceReplyDate"];
        string SoluApproveDate = "";
        string sql = "update T_PLANRUN_ZCQ set PNAME='"+T.preHandleSql(PName)+"'";
        string fileName4 = context.Request.Params["FinalSolutionFile"];
        string fileName1 = context.Request.Params["APPROVEFILE"];
        if (context.Request.Params["in_FinalSolutionFile"] != "" && context.Request.Params["in_FinalSolutionFile"] != "#")
            fileName4 = context.Request.Params["in_FinalSolutionFile"];
        else
            fileName4 = "#";
        if (context.Request.Params["in_APPROVEFILE"] != "" && context.Request.Params["in_APPROVEFILE"] != "#")
            fileName1 = context.Request.Params["in_APPROVEFILE"];
        else
            fileName1 = "#";
        string FileSwitch;
        FileSwitch = System.Configuration.ConfigurationSettings.AppSettings["FileSwitch"].ToString();
        /////////////////文件上传/////////////////////////////////
        try
        {
            HttpPostedFile _upfile4 = context.Request.Files["FinalSolutionFile"];
            if (_upfile4.ContentLength > 0)
            {
                System.IO.Stream s4 = _upfile4.InputStream;
                int l4 = _upfile4.ContentLength;
                FTP ftp = new FTP();
                //获得文件后缀
                string suffix = System.IO.Path.GetExtension(_upfile4.FileName);
                fileName4 = ftp.FTPUploadFile("archives", s4, l4, suffix);
            }
            HttpPostedFile _upfile1 = context.Request.Files["APPROVEFILE"];
            if (_upfile1.ContentLength > 0)
            {
                System.IO.Stream s1 = _upfile1.InputStream;
                int l1 = _upfile1.ContentLength;
                FTP ftp = new FTP();
                string suffix = System.IO.Path.GetExtension(_upfile1.FileName);
                fileName1 = ftp.FTPUploadFile("archives", s1, l1, suffix);
                SoluApproveDate = havetime();
            }
        }
        catch
        {
        }
        /////////////////文件上传结束/////////////////////////////////
        if (SoluSubmitDate != "" && SoluSubmitDate != null)
            sql += ",SoluSubmitDate=to_date('" + SoluSubmitDate + "','yyyy-mm-dd')";
        if (SoluCheckDate != "" && SoluCheckDate != null)
            sql += ",SoluCheckDate=to_date('" + SoluCheckDate + "','yyyy-mm-dd')";
        if (SoluApproveDate != "" && SoluApproveDate != null)
            sql += ",SoluApproveDate=to_date('" + SoluApproveDate + "','yyyy-mm-dd')";
        if (SoluAdviceReplyDate != "" && SoluAdviceReplyDate != null)
            sql += ",SoluAdviceReplyDate=to_date('" + SoluAdviceReplyDate + "','yyyy-mm-dd')";
        sql = sql + ",FINALSOLUTIONFILE='" + fileName4 + "'";
        sql = sql + ",APPROVEFILE='" + fileName1 + "'";
        sql += " where PID=" + ID;
        DB db = new DB();
        bool flag = db.ExecuteSQL(sql);
        if (flag == true)
        {
            //////////存档/////////////
            if (FileSwitch == "1")
            {
                string FID = "p" + ID;
                bool flag1 = true;
                bool flag2 = true;
                if (fileName4 != "#")
                {
                    string sql_plan = "insert into T_PLAN(ID,PNAME,PLEADER,BXRQ,FILES)values ('" + FID + "','" + T.preHandleSql(PName) + "','" + T.preHandleSql(SoluChief) + "',to_date('" + DateTime.Now.ToShortDateString() + "','yyyy-mm-dd'),'" + T.preHandleSql(fileName4) + "')";
                    flag1 = db.ExecuteSQL(sql_plan);//最终方案
                }
                if (fileName1 != "#")
                {
                    string sql_PLANREPLY_plan = "insert into T_PLANREPLY(ID,PNAME,RELEASERQ,FILES,FILETYPE)values ('" + FID + "p" + "','" + T.preHandleSql(PName) + "',to_date('" + SoluApproveDate + "','yyyy-mm-dd'),'" + T.preHandleSql(fileName1) + "','方案批复')";
                    flag2 = db.ExecuteSQL(sql_PLANREPLY_plan);//方案批复
                }

                if (flag1 && flag2)
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

    public string havetime()
    {
        return DateTime.Now.ToString("yyyy-MM-dd");
    }
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}