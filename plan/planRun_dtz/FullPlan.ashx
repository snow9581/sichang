<%@ WebHandler Language="C#" Class="FullPlan" %>

using System;
using System.Web;
using System.Data;
public class FullPlan : BaseHandler
{

    public override void AjaxProcess(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string id = context.Request.Params["hd_index"];
        string PNAME = context.Request.Params["PNAME"];
        string PSOURCE = context.Request.Params["PSOURCE"];
        string SOLUCHIEF = context.Request.Params["SOLUCHIEF"];
        string ESTIINVESTMENT = context.Request.Params["ESTIINVESTMENT"];
        string SOLUCOMPDATE_P = context.Request.Params["SOLUCOMPDATE_P"];
        string SOLUCOMPDATE_R = context.Request.Params["SOLUCOMPDATE_R"];
        string INSTCHECKDATE_P = context.Request.Params["INSTCHECKDATE_P"];
        string INSTCHECKDATE_R = context.Request.Params["INSTCHECKDATE_R"];
        string FACTCHECKDATE_P = context.Request.Params["FACTCHECKDATE_P"];
        string FACTCHECKDATE_R = context.Request.Params["FACTCHECKDATE_R"];
        string SOLUSUBMITDATE = context.Request.Params["SOLUSUBMITDATE"];
        string SOLUCHECKDATE = context.Request.Params["SOLUCHECKDATE"];
        string SOLUADVICEREPLYDATE = context.Request.Params["SOLUADVICEREPLYDATE"];
        string SOLUAPPROVEDATE = context.Request.Params["SOLUAPPROVEDATE"];
        string PNUMBER = context.Request.Params["PNUMBER"];
        string PLANINVESMENT = context.Request.Params["PLANINVESMENT"];
        string REMARK = context.Request.Params["Remark"];
        
//最终方案
        string IN_FINALSOLUTIONFILE = context.Request.Params["IN_FINALSOLUTIONFILE"];
        string FinalSolutionFile = context.Request.Files["FinalSolutionFile"].FileName;
        string renewFINALSOLUTIONFILE = context.Request.Files["renewFINALSOLUTIONFILE"].FileName;
        
        string FileSwitch;
        FileSwitch = System.Configuration.ConfigurationSettings.AppSettings["FileSwitch"].ToString();
        context.Response.ContentType = "text/plain";
        string fileWORDName = IN_FINALSOLUTIONFILE;
        DB db = new DB();
        if (renewFINALSOLUTIONFILE == "" && FinalSolutionFile != "")//第一次上传
        {
            HttpPostedFile _upfileWORD = context.Request.Files["FinalSolutionFile"];
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
        else if (renewFINALSOLUTIONFILE != "" && FinalSolutionFile == "")//更新
        {
            HttpPostedFile _upfile = context.Request.Files["renewFINALSOLUTIONFILE"];
            if (_upfile.ContentLength > 0)
            {//有上传文件 先删除原有文件
                //++++++++++++++++++++++++++删除已存在的ftp文件++++++++++++++++++++++
                if (IN_FINALSOLUTIONFILE != "")
                {
                    try
                    {
                        FTP ftp1 = new FTP();
                        ftp1.Delete("archives", IN_FINALSOLUTIONFILE);
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
//方案批复
        string IN_SOLUAPPROVEFILE = context.Request.Params["IN_SOLUAPPROVEFILE"];
        string SoluApproveFile = context.Request.Files["SoluApproveFile"].FileName;
        string renewSOLUAPPROVEFILE = context.Request.Files["renewSOLUAPPROVEFILE"].FileName;

        string fileWORDName2 = IN_SOLUAPPROVEFILE;
        if (renewSOLUAPPROVEFILE == "" && SoluApproveFile != "")//第一次上传
        {
            HttpPostedFile _upfileWORD = context.Request.Files["SoluApproveFile"];
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
        else if (renewSOLUAPPROVEFILE != "" && SoluApproveFile == "")//更新
        {
            HttpPostedFile _upfile = context.Request.Files["renewSOLUAPPROVEFILE"];
            if (_upfile.ContentLength > 0)
            {//有上传文件 先删除原有文件
                //++++++++++++++++++++++++++删除已存在的ftp文件++++++++++++++++++++++
                if (IN_SOLUAPPROVEFILE != "")
                {
                    try
                    {
                        FTP ftp1 = new FTP();
                        ftp1.Delete("archives", IN_SOLUAPPROVEFILE);
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
//设计条件表（第一次）
        string IN_DESICONDITIONTABLE = context.Request.Params["IN_DESICONDITIONTABLE"];
        string DESICONDITIONTABLE = context.Request.Files["DESICONDITIONTABLE"].FileName;
        
        string fileWORDName4 = IN_DESICONDITIONTABLE;
        if (IN_DESICONDITIONTABLE == "" && DESICONDITIONTABLE!="")//第一次上传
        {
            HttpPostedFile _upfileWORD = context.Request.Files["DESICONDITIONTABLE"];
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

                    fileWORDName4 = ftp.FTPUploadFile("archives", s, l, suffix);
                    //++++++++++++++++ end 上传文件++++++++++++++++
                }

            }
            catch { }

        }
//设计条件表（最后一次）
        string IN_DESICONDITIONTABLE_N = context.Request.Params["IN_DESICONDITIONTABLE_N"];
        string DESICONDITIONTABLE_N = context.Request.Files["DESICONDITIONTABLE_N"].FileName;
        string renewDESICONDITIONTABLE_N = context.Request.Files["renewDESICONDITIONTABLE_N"].FileName;
        string fileWORDName3 = IN_DESICONDITIONTABLE_N;//上传工程量
        if (renewDESICONDITIONTABLE_N == "" && DESICONDITIONTABLE_N != "")//第一次上传
        {
            HttpPostedFile _upfileWORD = context.Request.Files["DESICONDITIONTABLE_N"];
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

                    fileWORDName3 = ftp.FTPUploadFile("archives", s, l, suffix);
                    //++++++++++++++++ end 上传文件++++++++++++++++
                }

            }
            catch { }

        }
        else if (renewDESICONDITIONTABLE_N != "" && DESICONDITIONTABLE_N == "")//更新
        {
            HttpPostedFile _upfile = context.Request.Files["renewDESICONDITIONTABLE_N"];
            if (_upfile.ContentLength > 0)
            {//有上传文件 先删除原有文件
                //++++++++++++++++++++++++++删除已存在的ftp文件++++++++++++++++++++++
                if (IN_DESICONDITIONTABLE_N != "")
                {
                    try
                    {
                        FTP ftp1 = new FTP();
                        ftp1.Delete("archives", IN_DESICONDITIONTABLE_N);
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

                fileWORDName3 = ftp2.FTPUploadFile("archives", s, l, suffix);
                //+++++++++++++++++++++++++更新ftp文件结束++++++++++++++++++++++
            }
            //////////ftp上传结束///////////////
        }

        string sql = "update T_PLANRUN_DTZ set PNAME='" + T.preHandleSql(PNAME) + "',PSOURCE='" + T.preHandleSql(PSOURCE) + "',SOLUCHIEF='" + SOLUCHIEF + "',ESTIINVESTMENT='" + ESTIINVESTMENT + "'," +
            "SOLUCOMPDATE_P=to_date('" + SOLUCOMPDATE_P + "','yyyy-mm-dd'),SOLUCOMPDATE_R=to_date('" + SOLUCOMPDATE_R + "','yyyy-mm-dd'),INSTCHECKDATE_P=to_date('" + INSTCHECKDATE_P + "','yyyy-mm-dd'),INSTCHECKDATE_R=to_date('" + INSTCHECKDATE_R + "','yyyy-mm-dd'),FACTCHECKDATE_P=to_date('" + FACTCHECKDATE_P + "','yyyy-mm-dd'),FACTCHECKDATE_R=to_date('" + FACTCHECKDATE_R + "','yyyy-mm-dd')," +
            "SOLUSUBMITDATE=to_date('" + SOLUSUBMITDATE + "','yyyy-mm-dd'),SOLUCHECKDATE=to_date('" + SOLUCHECKDATE + "','yyyy-mm-dd'),SOLUADVICEREPLYDATE=to_date('" + SOLUADVICEREPLYDATE + "','yyyy-mm-dd'),SOLUAPPROVEDATE=to_date('" + SOLUAPPROVEDATE + "','yyyy-mm-dd'),PNUMBER='" + T.preHandleSql(PNUMBER) + "',PLANINVESMENT='" + PLANINVESMENT + "'," +
            "DESICONDITIONTABLE='" + fileWORDName4 + "',SOLUAPPROVEFILE='" + fileWORDName2 + "',FINALSOLUTIONFILE='" + fileWORDName + "',DESICONDITIONTABLE_N='" + fileWORDName3 + "',REMARK='"+T.preHandleSql(REMARK)+"' where PID='" + id + "'";
        bool flag = db.ExecuteSQL(sql);
        if (flag == true)
        {
            /////////存档///////////
            if (FileSwitch == "1")
            {
                string FID = "p" + id;
                bool flag1 = true;
                if (renewFINALSOLUTIONFILE == "" && FinalSolutionFile != "")
                {
                    string sql_plan = "insert into T_PLAN(ID,PNAME,PLEADER,PID,FILES,BXRQ,PMONEY)values('" + FID + "','" + T.preHandleSql(PNAME) + "','" + T.preHandleSql(SOLUCHIEF) + "','" + T.preHandleSql(PNUMBER) + "','" + fileWORDName + "',to_date('" + DateTime.Now.ToShortDateString() + "','yyyy-mm-dd'),'" + T.preHandleSql(PLANINVESMENT) + "')";
                    flag1 = db.ExecuteSQL(sql_plan);//最终方案
                }
                else
                {
                    string sql_plan = "update T_PLAN set PNAME='" + T.preHandleSql(PNAME) + "',PLEADER='" + T.preHandleSql(SOLUCHIEF) + "',PID='" + T.preHandleSql(PNUMBER) + "'";
                    if (renewFINALSOLUTIONFILE != "" && FinalSolutionFile == "")
                    {
                        sql_plan += ",BXRQ=to_date('" + DateTime.Now.ToShortDateString() + "','yyyy-mm-dd'),FILES='" + T.preHandleSql(fileWORDName) + "'";
                    }
                    sql_plan += " where id='" + FID + "'";
                    flag1 = db.ExecuteSQL(sql_plan);//最终方案
                }

                bool flag2 = true;
                if (IN_DESICONDITIONTABLE == "" && DESICONDITIONTABLE != "")
                {
                    string sql_DESICONDITIONTABLE = "insert into T_DESICONDITIONTABLE(ID,PNAME,PLEADER,PID,FILES,BXRQ,PMONEY)values('" + FID + "','" + T.preHandleSql(PNAME) + "','" + T.preHandleSql(SOLUCHIEF) + "','" + T.preHandleSql(PNUMBER) + "','" + fileWORDName4 + "',to_date('" + DateTime.Now.ToShortDateString() + "','yyyy-mm-dd'),'" + T.preHandleSql(PLANINVESMENT) + "')";
                    flag2 = db.ExecuteSQL(sql_DESICONDITIONTABLE);//设计条件表
                }
                else
                {
                    string sql_DESICONDITIONTABLE = "update T_DESICONDITIONTABLE set PNAME='" + T.preHandleSql(PNAME) + "',PLEADER='" + T.preHandleSql(SOLUCHIEF) + "',PID='" + T.preHandleSql(PNUMBER) + "',PMONEY='" + T.preHandleSql(PLANINVESMENT)+"' where id='" + FID + "'";
                    flag2 = db.ExecuteSQL(sql_DESICONDITIONTABLE);//设计条件表
                }

                bool flag3 = true;
                if (renewSOLUAPPROVEFILE == "" && SoluApproveFile != "")
                {
                    string sql_planreply = "insert into T_PLANREPLY(ID,PNAME,PID,FILES,RELEASERQ,PLANMONEY,FILETYPE)values('" + FID + "p','" + T.preHandleSql(PNAME) + "','" + T.preHandleSql(PNUMBER) + "','" + fileWORDName2 + "',to_date('" + SOLUSUBMITDATE + "','yyyy-mm-dd'),'" + T.preHandleSql(PLANINVESMENT) + "','方案批复')";
                    flag3 = db.ExecuteSQL(sql_planreply);//方案批复
                }
                else
                {
                    string sql_PLANREPLY_plan = "update T_PLANREPLY set PNAME='" + T.preHandleSql(PNAME) + "',PID='" + T.preHandleSql(PNUMBER) + "',RELEASERQ=to_date('" + SOLUSUBMITDATE + "','yyyy-mm-dd')";
                    if (renewSOLUAPPROVEFILE != "" && SoluApproveFile == "")
                    {
                        sql_PLANREPLY_plan += ",FILES='" + T.preHandleSql(fileWORDName2) + "'";
                    }
                    if (PLANINVESMENT != "" && PLANINVESMENT != null)
                        sql_PLANREPLY_plan += ",PLANMONEY='" + T.preHandleSql(PLANINVESMENT)+"'";
                    sql_PLANREPLY_plan += ",FILETYPE='方案批复' where id='" + FID + "p" + "'";
                    flag3 = db.ExecuteSQL(sql_PLANREPLY_plan);//方案批复
                }
                
                bool flag4 = true;
                if (IN_DESICONDITIONTABLE_N == "" && DESICONDITIONTABLE_N!="")
                {
                    string sql_DESICONDITIONTABLE_N = "insert into T_DESICONDITIONTABLE(ID,PNAME,PLEADER,PMONEY,BXRQ,FILES,BZ,PID)values ('" + FID + "l','" + T.preHandleSql(PNAME) + "','" + T.preHandleSql(SOLUCHIEF) + "','"
                        + T.preHandleSql(PLANINVESMENT) + "',to_date('" + DateTime.Now.ToShortDateString() + "','yyyy-mm-dd'),'" + T.preHandleSql(fileWORDName3) + "','最后一次','" + T.preHandleSql(PNUMBER) + "')";
                    flag4 = db.ExecuteSQL(sql_DESICONDITIONTABLE_N);//设计条件表(最后一次)插入
                }
                else
                {
                    string sql_DESICONDITIONTABLE_N = "update T_DESICONDITIONTABLE set PNAME='" + T.preHandleSql(PNAME) + "',PLEADER='" + T.preHandleSql(SOLUCHIEF) + "',PID='" + T.preHandleSql(PNUMBER) + "'";
                    if (renewDESICONDITIONTABLE_N != "")
                    {
                        sql_DESICONDITIONTABLE_N += ",BXRQ=to_date('" + DateTime.Now.ToShortDateString() + "','yyyy-mm-dd'),FILES='" + T.preHandleSql(fileWORDName3) + "'";
                    }
                    if (PLANINVESMENT != "" && PLANINVESMENT != null)
                        sql_DESICONDITIONTABLE_N += ",PMONEY='" + T.preHandleSql(PLANINVESMENT)+"'";
                    sql_DESICONDITIONTABLE_N += " where id='" + FID + "l'";
                    flag4 = db.ExecuteSQL(sql_DESICONDITIONTABLE_N);//设计条件表(最后一次)更新
                }
                
                string sql_PLANREPLY_design = "update T_PLANREPLY set PNAME='" + T.preHandleSql(PNAME) + "'";
                if (PNUMBER != "" && PNUMBER != null)
                    sql_PLANREPLY_design += ",PID='" + T.preHandleSql(PNUMBER) + "'";
                if (PLANINVESMENT != "" && PLANINVESMENT != null)
                    sql_PLANREPLY_design += ",PLANMONEY=" + T.preHandleSql(PLANINVESMENT);
                sql_PLANREPLY_design += ",FILETYPE='设计批复' where id='" + FID + "d" + "'";
                bool flag5 = db.ExecuteSQL(sql_PLANREPLY_design);//设计批复下达

                string sql_PLANREPLY_issued = "update T_PLANREPLY set PNAME='" + T.preHandleSql(PNAME) + "'";
                if (PNUMBER != "" && PNUMBER != null)
                    sql_PLANREPLY_issued += ",PID='" + T.preHandleSql(PNUMBER) + "'";
                if (PLANINVESMENT != "" && PLANINVESMENT != null)
                    sql_PLANREPLY_issued += ",PLANMONEY=" + T.preHandleSql(PLANINVESMENT);
                sql_PLANREPLY_issued += ",FILETYPE='下达计划' where id='" + FID + "i" + "'";
                bool flag6 = db.ExecuteSQL(sql_PLANREPLY_issued);//计划下达

                string sql_INITPLAN = "update T_INITPLAN set PNAME='" + T.preHandleSql(PNAME) + "'";
                if (PNUMBER != "" && PNUMBER != null)
                    sql_INITPLAN += ",PID='" + T.preHandleSql(PNUMBER) + "'";
                sql_INITPLAN += " where id='" + FID + "'";
                bool flag7 = db.ExecuteSQL(sql_INITPLAN);//初设上报文档

                string sql_CONSTRUCTION = "update T_CONSTRUCTION set PNAME='" + T.preHandleSql(PNAME) + "'";
                if (PNUMBER != "" && PNUMBER != null)
                    sql_CONSTRUCTION += ",PID='" + T.preHandleSql(PNUMBER) + "'";
                sql_CONSTRUCTION += " where PNAME = (select PNAME from T_PLANRUN_DTZ where PID='" + id + "')";
                bool flag8 = db.ExecuteSQL(sql_CONSTRUCTION);//蓝图

                string sql_ESTIMATE = "update T_ESTIMATE set PNAME='" + T.preHandleSql(PNAME) + "'";
                if (PNUMBER != "" && PNUMBER != null)
                    sql_ESTIMATE += ",PID='" + T.preHandleSql(PNUMBER) + "'";
                if (PLANINVESMENT != "" && PLANINVESMENT != null)
                    sql_ESTIMATE += ",PMONEY=" + T.preHandleSql(PLANINVESMENT);
                sql_ESTIMATE += " where id='" + FID + "'";
                bool flag9 = db.ExecuteSQL(sql_ESTIMATE);//最终（调整后）概算文档

                string sql_PROOFCHECK = "update T_PROOFCHECK set PNAME='" + T.preHandleSql(PNAME) + "'";
                if (PNUMBER != "" && PNUMBER != null)
                    sql_PROOFCHECK += ",PID='" + T.preHandleSql(PNUMBER) + "'";
                sql_PROOFCHECK += " where id='" + FID + "'";
                bool flag12 = db.ExecuteSQL(sql_PROOFCHECK);//白图校审
                bool flag10 = true;

                if (PNUMBER != "" && PNUMBER != null)
                {
                    string sql_COMMISSIONINFORMATION1 = "update T_COMMISSIONINFORMATION set PNUMBER='" + T.preHandleSql(PNUMBER) + "' where PNAME = '"+T.preHandleSql(PNAME)+"'";
                    flag10 = db.ExecuteSQL(sql_COMMISSIONINFORMATION1);//一次委托资料&二次委托资料
                }
                if (flag1 && flag2 && flag3 && flag4 && flag5 && flag6 && flag7 && flag8 && flag9 && flag10 && flag12)
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