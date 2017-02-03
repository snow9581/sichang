<%@ WebHandler Language="C#" Class="FullBudget" %>

using System;
using System.Web;
using System.Data;
public class FullBudget : BaseHandler
{

    public override void AjaxProcess(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string id = context.Request.Params["hd_index"];
        string BUDGETCHIEF = context.Request.Params["BUDGETCHIEF"];
        string WORKLOADSUBMITDATE_P = context.Request.Params["WORKLOADSUBMITDATE_P"];
        string WORKLOADSUBMITDATE_R = context.Request.Params["WORKLOADSUBMITDATE_R"];
        //string MAJORDELEGATEDATE_P = context.Request.Params["MAJORDELEGATEDATE_P"];
        //string MAJORDELEGATEDATE_R = context.Request.Params["MAJORDELEGATEDATE_R"];
        string BUDGETCOMPDATE_P = context.Request.Params["BUDGETCOMPDATE_P"];
        string BUDGETCOMPDATE_R = context.Request.Params["BUDGETCOMPDATE_R"];
        string INITIALDESISUBMITDATE_P = context.Request.Params["INITIALDESISUBMITDATE_P"];
        string INITIALDESISUBMITDATE_R = context.Request.Params["INITIALDESISUBMITDATE_R"];
        string BUDGETADJUSTDATE_P = context.Request.Params["BUDGETADJUSTDATE_P"];
        string BUDGETADJUSTDATE_R = context.Request.Params["BUDGETADJUSTDATE_R"];
        string REMARK = context.Request.Params["Remark"];
        //最终概算
        string IN_FINALBUDGETFILE = context.Request.Params["IN_FINALBUDGETFILE"];
        string FINALBUDGETFILE = context.Request.Files["FINALBUDGETFILE"].FileName;
        string FINALBUDGETFILE_N = context.Request.Files["FINALBUDGETFILE_N"].FileName;

        context.Response.ContentType = "text/plain";
        string fileWORDName = IN_FINALBUDGETFILE;
        DB db = new DB();
        if (FINALBUDGETFILE_N == "" && FINALBUDGETFILE != "")//第一次上传
        {
            HttpPostedFile _upfileWORD = context.Request.Files["FINALBUDGETFILE"];
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
        else if (FINALBUDGETFILE_N != "" && FINALBUDGETFILE == "")//更新
        {
            HttpPostedFile _upfile = context.Request.Files["FINALBUDGETFILE_N"];
            if (_upfile.ContentLength > 0)
            {//有上传文件 先删除原有文件
                //++++++++++++++++++++++++++删除已存在的ftp文件++++++++++++++++++++++
                if (IN_FINALBUDGETFILE != "")
                {
                    try
                    {
                        FTP ftp1 = new FTP();
                        ftp1.Delete("archives", IN_FINALBUDGETFILE);
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

        string sql = "update T_PLANRUN_DTZ set BUDGETCHIEF='" + BUDGETCHIEF + "',WORKLOADSUBMITDATE_P=to_date('"
            + WORKLOADSUBMITDATE_P + "','yyyy-mm-dd'),WORKLOADSUBMITDATE_R=to_date('" + WORKLOADSUBMITDATE_R + "','yyyy-mm-dd'),BUDGETCOMPDATE_P=to_date('"
            + BUDGETCOMPDATE_P + "','yyyy-mm-dd'),BUDGETCOMPDATE_R=to_date('" + BUDGETCOMPDATE_R + "','yyyy-mm-dd'),INITIALDESISUBMITDATE_P=to_date('"
            + INITIALDESISUBMITDATE_P + "','yyyy-mm-dd'),INITIALDESISUBMITDATE_R=to_date('" + INITIALDESISUBMITDATE_R + "','yyyy-mm-dd'),BUDGETADJUSTDATE_P=to_date('"
            + BUDGETADJUSTDATE_P + "','yyyy-mm-dd'),BUDGETADJUSTDATE_R=to_date('" + BUDGETADJUSTDATE_R + "','yyyy-mm-dd'),FINALBUDGETFILE='" + fileWORDName + "',REMARK='" + REMARK + "' where PID='" + id + "'";
        bool flag = db.ExecuteSQL(sql);
        if (flag == true)
        {
            string FileSwitch;
            FileSwitch = System.Configuration.ConfigurationSettings.AppSettings["FileSwitch"].ToString();
            if (FileSwitch == "1")
            {
                string FID = "p" + id;
                bool flag1 = true;
                if (INITIALDESISUBMITDATE_R != "")
                {
                    DataTable dt1 = new DataTable();
                    string sql_id = "select * from T_INITPLAN where ID='" + FID + "'";
                    dt1 = db.GetDataTable(sql_id);
                    if (dt1.Rows.Count == 0)
                    {
                        DataTable dt = new DataTable();
                        string sql_pleader = "select SOLUCHIEF,PNUMBER,PNAME from T_PLANRUN_DTZ where PID=" + id + "";
                        dt = db.GetDataTable(sql_pleader);
                        if (dt.Rows.Count > 0)
                        {
                            string sql_PLANREPLY_issued = "insert into T_INITPLAN (ID,PID,PNAME,INITRQ,PLEADER) values('" + FID + "','" + dt.Rows[0]["PNUMBER"].ToString() + "','" + dt.Rows[0]["PNAME"].ToString()
                                + "',to_date('" + INITIALDESISUBMITDATE_R + "','yyyy-mm-dd'),'" + dt.Rows[0]["SOLUCHIEF"].ToString() + "')";
                            flag1 = db.ExecuteSQL(sql_PLANREPLY_issued);//初设上报文档
                        }
                    }
                    else
                    {
                        string sql_INITPLAN = "update T_INITPLAN set INITRQ=to_date('" + INITIALDESISUBMITDATE_R + "','yyyy-mm-dd') where id='" + FID + "'";
                        flag1 = db.ExecuteSQL(sql_INITPLAN);//初设上报文档
                    }
                }
                bool flag2 = true;
                if (FINALBUDGETFILE_N == "" && FINALBUDGETFILE != "")
                {
                    DataTable dt = new DataTable();
                    string sql_pleader = "select PNAME,PNUMBER,PLANINVESMENT,SOLUCHIEF from T_PLANRUN_DTZ where PID=" + id + "";
                    dt = db.GetDataTable(sql_pleader);
                    if (dt.Rows.Count > 0)
                    {
                        string sql_ESTIMATE = "insert into T_ESTIMATE(ID,PNAME,PLEADER,PID,FILES,PMONEY)values('" + FID + "','" + dt.Rows[0]["PNAME"].ToString() + "','" + dt.Rows[0]["SOLUCHIEF"].ToString() + "','" + dt.Rows[0]["PNUMBER"].ToString() + "','" + fileWORDName + "','" + dt.Rows[0]["PLANINVESMENT"].ToString() + "')";
                        flag2 = db.ExecuteSQL(sql_ESTIMATE);//最终（调整后）概算文档
                    }
                }
                else if (FINALBUDGETFILE_N != "" && FINALBUDGETFILE == "")
                {
                    string sql_ESTIMATE = "update T_ESTIMATE set FILES='" + T.preHandleSql(fileWORDName) + "' where ID='" + FID + "'";
                    flag2 = db.ExecuteSQL(sql_ESTIMATE);//最终（调整后）概算文档
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
        }
        else
        {
            context.Response.Write("0");
        }

    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}