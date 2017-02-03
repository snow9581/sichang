<%@ WebHandler Language="C#" Class="FullDesign" %>

using System;
using System.Web;
using System.Data;
public class FullDesign : BaseHandler {

    public override void AjaxProcess(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string id = context.Request.Params["hd_index"];
        string DESICHIEF = context.Request.Params["DESICHIEF"];
        string MAJORPROOFREADER = context.Request.Params["MAJORPROOFREADER"];
        string PLANARRIVALFILENUMBER = context.Request.Params["PLANARRIVALFILENUMBER"];
        string PLANARRIVALDATE = context.Request.Params["PLANARRIVALDATE"];
        string DESIAPPROVALARRIVALFILENUMBER = context.Request.Params["DESIAPPROVALARRIVALFILENUMBER"];
        string DESIAPPROVALARRIVALDATE = context.Request.Params["DESIAPPROVALARRIVALDATE"];
        string WHITEGRAPHCHECKDATE_P = context.Request.Params["WHITEGRAPHCHECKDATE_P"];
        string WHITEGRAPHCHECKDATE_R = context.Request.Params["WHITEGRAPHCHECKDATE_R"];
        string BLUEGRAPHDOCUMENT_P = context.Request.Params["BLUEGRAPHDOCUMENT_P"];
        string BLUEGRAPHDOCUMENT_R = context.Request.Params["BLUEGRAPHDOCUMENT_R"];
        string MAJORDELEGATEDATE_P = context.Request.Params["MAJORDELEGATEDATE_P"];
        string MAJORDELEGATEDATE_R = context.Request.Params["MAJORDELEGATEDATE_R"];
        string SECONDCOMMISSIONDATE = context.Request.Params["SECONDCOMMISSIONDATE"];
        string REMARK = context.Request.Params["Remark"];
        
        //设计批复下达
        string IN_DESIAPPRFILE = context.Request.Params["IN_DESIAPPRFILE"];
        string DESIAPPRFILE = context.Request.Files["DESIAPPRFILE"].FileName;
        string DESIAPPRFILE_N = context.Request.Files["DESIAPPRFILE_N"].FileName;

        string FileSwitch;
        FileSwitch = System.Configuration.ConfigurationSettings.AppSettings["FileSwitch"].ToString();
        context.Response.ContentType = "text/plain";
        string fileWORDName = IN_DESIAPPRFILE;
        DB db = new DB();
        if (DESIAPPRFILE_N == "" && DESIAPPRFILE != "")//第一次上传
        {
            HttpPostedFile _upfileWORD = context.Request.Files["DESIAPPRFILE"];
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
        else if (DESIAPPRFILE_N != "" && DESIAPPRFILE == "")//更新
        {
            HttpPostedFile _upfile = context.Request.Files["DESIAPPRFILE_N"];
            if (_upfile.ContentLength > 0)
            {//有上传文件 先删除原有文件
                //++++++++++++++++++++++++++删除已存在的ftp文件++++++++++++++++++++++
                if (IN_DESIAPPRFILE != "")
                {
                    try
                    {
                        FTP ftp1 = new FTP();
                        ftp1.Delete("archives", IN_DESIAPPRFILE);
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
        //计划下达文件
        string IN_PLANARRIVALFILE = context.Request.Params["IN_PLANARRIVALFILE"];
        string PLANARRIVALFILE = context.Request.Files["PLANARRIVALFILE"].FileName;
        string PLANARRIVALFILE_N = context.Request.Files["PLANARRIVALFILE_N"].FileName;

        string fileWORDName2 = IN_PLANARRIVALFILE;
        if (PLANARRIVALFILE_N == "" && PLANARRIVALFILE != "")//第一次上传
        {
            HttpPostedFile _upfileWORD = context.Request.Files["PLANARRIVALFILE"];
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

                    fileWORDName2 = ftp.FTPUploadFile("archives", s, l, suffix);
                    //++++++++++++++++ end 上传文件++++++++++++++++
                }

            }
            catch { }

        }
        else if (PLANARRIVALFILE_N != "" && PLANARRIVALFILE == "")//更新
        {
            HttpPostedFile _upfile = context.Request.Files["PLANARRIVALFILE_N"];
            if (_upfile.ContentLength > 0)
            {//有上传文件 先删除原有文件
                //++++++++++++++++++++++++++删除已存在的ftp文件++++++++++++++++++++++
                if (IN_PLANARRIVALFILE != "")
                {
                    try
                    {
                        FTP ftp1 = new FTP();
                        ftp1.Delete("archives", IN_PLANARRIVALFILE);
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

                fileWORDName2 = ftp2.FTPUploadFile("archives", s, l, suffix);
                //+++++++++++++++++++++++++更新ftp文件结束++++++++++++++++++++++
            }
            //////////ftp上传结束///////////////
        }
        

        string sql = "update T_PLANRUN_DTZ set DESICHIEF='" + DESICHIEF + "',MAJORPROOFREADER='" + MAJORPROOFREADER
            + "',MAJORDELEGATEDATE_P=to_date('" + MAJORDELEGATEDATE_P + "','yyyy-mm-dd'),MAJORDELEGATEDATE_R=to_date('" +
            MAJORDELEGATEDATE_R + "','yyyy-mm-dd'),PLANARRIVALFILENUMBER='" + T.preHandleSql(PLANARRIVALFILENUMBER) + "',PLANARRIVALDATE=to_date('" + PLANARRIVALDATE +
            "','yyyy-mm-dd'),DESIAPPROVALARRIVALFILENUMBER='" + T.preHandleSql(DESIAPPROVALARRIVALFILENUMBER) + "',DESIAPPROVALARRIVALDATE=to_date('" +
            DESIAPPROVALARRIVALDATE + "','yyyy-mm-dd'),WHITEGRAPHCHECKDATE_P=to_date('" + WHITEGRAPHCHECKDATE_P + "','yyyy-mm-dd'),WHITEGRAPHCHECKDATE_R=to_date('"
            + WHITEGRAPHCHECKDATE_R + "','yyyy-mm-dd'),BLUEGRAPHDOCUMENT_P=to_date('" + BLUEGRAPHDOCUMENT_P + "','yyyy-mm-dd'),BLUEGRAPHDOCUMENT_R=to_date('" +
            BLUEGRAPHDOCUMENT_R + "','yyyy-mm-dd'),DESIAPPRFILE='" + fileWORDName + "',PLANARRIVALFILE='" + fileWORDName2 + "',SECONDCOMMISSIONDATE=to_date('" +
            SECONDCOMMISSIONDATE + "','yyyy-mm-dd'),REMARK='" + T.preHandleSql(REMARK) + "' where PID='" + id + "'";
        bool flag = db.ExecuteSQL(sql);
        if (flag == true)
        {
            //////////存档/////////////

            if (FileSwitch == "1")
            {
                string FID = "p" + id;
                bool flag1 = true;
                if (DESIAPPRFILE_N == "" && DESIAPPRFILE != "")
                {
                    DataTable dt = new DataTable();
                    string sql_pleader = "select PNAME,PNUMBER,PLANINVESMENT from T_PLANRUN_DTZ where PID=" + id + "";
                    dt = db.GetDataTable(sql_pleader);
                    if (dt.Rows.Count > 0)
                    {
                        string sql_PLANREPLY_design = "insert into T_PLANREPLY (ID,PID,PNAME,RELEASERQ,FILENUMBER,PLANMONEY,FILETYPE,FILES) values('" + FID + "d" + "','" + dt.Rows[0]["PNUMBER"].ToString() + "','" + dt.Rows[0]["PNAME"].ToString()
                            + "',to_date('" + T.preHandleSql(DESIAPPROVALARRIVALDATE) + "','yyyy-mm-dd'),'" + T.preHandleSql(DESIAPPROVALARRIVALFILENUMBER) + "','" + dt.Rows[0]["PLANINVESMENT"].ToString() + "','设计批复','" + T.preHandleSql(fileWORDName) + "')";
                        flag1 = db.ExecuteSQL(sql_PLANREPLY_design);//设计批复
                    }
                }
                else
                {
                    string sql_PLANREPLY_design = "update T_PLANREPLY set FILENUMBER='" + T.preHandleSql(DESIAPPROVALARRIVALFILENUMBER) + "',RELEASERQ=to_date('" + T.preHandleSql(DESIAPPROVALARRIVALDATE) + "','yyyy-mm-dd')";
                    if (DESIAPPRFILE_N != "" && DESIAPPRFILE == "")
                    {
                        sql_PLANREPLY_design += ",FILES='" + T.preHandleSql(fileWORDName) + "'";
                    }
                    sql_PLANREPLY_design += " where ID='" + FID + "d" + "'";
                    flag1 = db.ExecuteSQL(sql_PLANREPLY_design);//设计批复
                }
                
                bool flag2 = true;
                if (PLANARRIVALFILE_N == "" && PLANARRIVALFILE != "")
                {
                    DataTable dt = new DataTable();
                    string sql_pleader = "select PNAME,PNUMBER,PLANINVESMENT from T_PLANRUN_DTZ where PID=" + id + "";
                    dt = db.GetDataTable(sql_pleader);
                    if (dt.Rows.Count > 0)
                    {
                        string sql_PLANREPLY_issued = "insert into T_PLANREPLY (ID,PID,PNAME,RELEASERQ,FILENUMBER,PLANMONEY,FILETYPE,FILES) values('" + FID + "i" + "','" + dt.Rows[0]["PNUMBER"].ToString() + "','" + dt.Rows[0]["PNAME"].ToString()
                            + "',to_date('" + T.preHandleSql(PLANARRIVALDATE) + "','yyyy-mm-dd'),'" + T.preHandleSql(PLANARRIVALFILENUMBER) + "','" + dt.Rows[0]["PLANINVESMENT"].ToString() + "','下达计划','" + T.preHandleSql(fileWORDName2) + "')";
                        flag2 = db.ExecuteSQL(sql_PLANREPLY_issued);//计划下达
                    }
                }
                else
                {
                    string sql_PLANREPLY_issued = "update T_PLANREPLY set FILENUMBER='" + T.preHandleSql(PLANARRIVALFILENUMBER) + "',RELEASERQ=to_date('" + T.preHandleSql(PLANARRIVALDATE) + "','yyyy-mm-dd')";
                    if (PLANARRIVALFILE_N != "" && PLANARRIVALFILE == "")
                    {
                        sql_PLANREPLY_issued += ",FILES='" + T.preHandleSql(fileWORDName2) + "'";
                    }
                    sql_PLANREPLY_issued += " where ID='" + FID + "i" + "'";
                    flag2 = db.ExecuteSQL(sql_PLANREPLY_issued);//计划下达
                }
                
                bool flag3 = true;
                if (WHITEGRAPHCHECKDATE_R != "" && WHITEGRAPHCHECKDATE_R != null)
                {
                    DataTable dt1 = new DataTable();
                    string sql_id = "select * from T_PROOFCHECK where ID='" + FID + "'";
                    dt1 = db.GetDataTable(sql_id);
                    if (dt1.Rows.Count == 0)
                    {
                        string sql_pname = "select PNAME,PNUMBER from T_PLANRUN_DTZ where PID=" + id + "";
                        dt1 = db.GetDataTable(sql_pname);
                        string sql_PROOFCHECK = "insert into T_PROOFCHECK(ID,PNAME,DESIGNRQ,PID)values ('" + FID + "','" + dt1.Rows[0]["PNAME"].ToString() + "',to_date('" + T.preHandleSql(WHITEGRAPHCHECKDATE_R) + "','yyyy-mm-dd'),'" + dt1.Rows[0]["PNUMBER"].ToString() + "')";
                        flag3 = db.ExecuteSQL(sql_PROOFCHECK);//白图校审
                    }
                    else
                    {
                        string sql_PROOFCHECK = "update T_PROOFCHECK set DESIGNRQ=to_date('" + T.preHandleSql(WHITEGRAPHCHECKDATE_R) + "','yyyy-mm-dd') where ID='" + FID + "'";
                        flag3 = db.ExecuteSQL(sql_PROOFCHECK);//校对审核记录文档
                    }
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