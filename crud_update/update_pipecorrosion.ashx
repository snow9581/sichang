<%@ WebHandler Language="C#" Class="update_ipecorrosion" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.SessionState;

public class update_ipecorrosion : BaseHandler
{
    public override void AjaxProcess (HttpContext context) {
        if (context.Session["userlevel"] == "" || context.Session["userlevel"] == null)
        {
            context.Response.Write("<script>alert('用户已过期,请重新登录！');window.parent.location.href ='../login.aspx'</script>");
        }
        string json = "";
        string ID = context.Request.Params["ID"];
        string DM = context.Request.Params["DM"];
        string KM = context.Request.Params["KM"];
        string QDMC = context.Request.Params["QDMC"];
        string ZDMC = context.Request.Params["ZDMC"];
        string GDLB = context.Request.Params["GDLB"];
        string GDMC = context.Request.Params["GDMC"];
        string GDJSSJ = context.Request.Params["GDJSSJ"];
        string SSJZ = context.Request.Params["SSJZ"];
        
        string GDGG1 = context.Request.Params["GDGG1"];
        string GDGG2 = context.Request.Params["GDGG2"];
        string GDGG = "";
        if (GDGG1 != "" || GDGG2 != "")
            GDGG = "Ф" + GDGG1 + "×" + GDGG2;
        
        string GDCD = context.Request.Params["GDCD"];
        string GDCZ = context.Request.Params["GDCZ"];
        string CKSJ = context.Request.Params["CKSJ"];

        string CKSCDL = context.Request.Params["CKSCDL"];
        string CKYY = context.Request.Params["CKYY"];
        string CKWZ = context.Request.Params["CKWZ"];
        string XLL = context.Request.Params["XLL"];

        string CLFS = context.Request.Params["CLFS"];
        string SFHF = context.Request.Params["SFHF"];
        string CLWCSJ = context.Request.Params["CLWCSJ"];
        string WCLYY = context.Request.Params["WCLYY"];

        string XDFZR = context.Request.Params["XDFZR"];
        string LXFS = context.Request.Params["LXFS"];
        string SFYZP = context.Request.Params["SFYZP"];
        string PIC1 = context.Request.Params["PICTURE1"];
        string PIC2 = context.Request.Params["PICTURE2"];
        string PIC3 = context.Request.Params["PICTURE3"];
        string CREATEDATE = context.Request.Params["CREATEDATE"];
     
        //string TCRQ = Convert.ToDateTime(context.Request.Params["TCRQ"]).ToShortDateString();
        //string WXRQ = Convert.ToDateTime(context.Request.Params["WXRQ"]).ToShortDateString();
        //////////ftp开始上传///////////////
        HttpPostedFile _upfile1 = context.Request.Files["PIC1"];
        HttpPostedFile _upfile2 = context.Request.Files["PIC2"];
        HttpPostedFile _upfile3= context.Request.Files["PIC3"];
        context.Response.ContentType = "text/plain";
        string fileName1 = "#";//如果没有上传文件，则为#号，不显示下载  
        string fileName2 = "#";
        string fileName3 = "#";
        DB db = new DB();
        string filename1 = "";
        string filename2 = "";
        string filename3 = "";
        string idsql1 = "select PIC1 from T_PIPECORROSION where ID='" + ID + "'";
        string idsql2 = "select PIC2 from T_PIPECORROSION where ID='" + ID + "'";
        string idsql3= "select PIC3 from T_PIPECORROSION where ID='" + ID + "'";
        System.Data.DataTable dt1 = db.GetDataTable(idsql1);
        System.Data.DataTable dt2 = db.GetDataTable(idsql2);
        System.Data.DataTable dt3 = db.GetDataTable(idsql3);
        if (dt1.Rows.Count > 0)
        {
            filename1 = dt1.Rows[0]["PIC1"].ToString();
            fileName1 = filename1;
        }
        if (dt2.Rows.Count > 0)
        {
            filename2 = dt2.Rows[0]["PIC2"].ToString();
            fileName2 = filename2;
        }
        if (dt3.Rows.Count > 0)
        {
            filename3 = dt3.Rows[0]["PIC3"].ToString();
            fileName3 = filename3;
        }
        if (_upfile1 != null)
        {
            if (_upfile1.ContentLength > 0)
            {//有上传文件 先删除原有文件
                //++++++++++++++++++++++++++删除已存在的ftp文件++++++++++++++++++++++
                if ((filename1 != "") && filename1 != "#")
                {
                    try
                    {
                        FTP ftp1 = new FTP();
                        ftp1.Delete("ftpupload", filename1);
                    }
                    catch (Exception ex)
                    {
                        SClog.insert("error", "ftp delete in update failure" + ex.ToString());
                    }
                }
                //++++++++++++++++++++++++++删除ftp文件结束++++++++++++++++++++++
                //++++++++++++++++++++++++++更新ftp文件++++++++++++++++++++++
                System.IO.Stream s = _upfile1.InputStream;

                int l = _upfile1.ContentLength;

                FTP ftp2 = new FTP();

                //获得文件后缀

                string suffix = System.IO.Path.GetExtension(_upfile1.FileName);

                fileName1 = ftp2.FTPUploadFile("ftpupload", s, l, suffix);
                //+++++++++++++++++++++++++更新ftp文件结束++++++++++++++++++++++
            }
        }
        if (_upfile2 != null)
        {
            if (_upfile2.ContentLength > 0)
            {//有上传文件 先删除原有文件
                //++++++++++++++++++++++++++删除已存在的ftp文件++++++++++++++++++++++
                if ((filename2 != "") && filename2 != "#")
                {
                    try
                    {
                        FTP ftp1 = new FTP();
                        ftp1.Delete("ftpupload", filename2);
                    }
                    catch (Exception ex)
                    {
                        SClog.insert("error", "ftp delete in update failure" + ex.ToString());
                    }
                }
                //++++++++++++++++++++++++++删除ftp文件结束++++++++++++++++++++++
                //++++++++++++++++++++++++++更新ftp文件++++++++++++++++++++++
                System.IO.Stream s = _upfile2.InputStream;

                int l = _upfile2.ContentLength;

                FTP ftp2 = new FTP();

                //获得文件后缀

                string suffix = System.IO.Path.GetExtension(_upfile2.FileName);

                fileName2 = ftp2.FTPUploadFile("ftpupload", s, l, suffix);
                //+++++++++++++++++++++++++更新ftp文件结束++++++++++++++++++++++
            }
        }
        if (_upfile3 != null)
        {
            if (_upfile3.ContentLength > 0)
            {//有上传文件 先删除原有文件
                //++++++++++++++++++++++++++删除已存在的ftp文件++++++++++++++++++++++
                if ((filename3 != "") && filename3 != "#")
                {
                    try
                    {
                        FTP ftp1 = new FTP();
                        ftp1.Delete("ftpupload", filename3);
                    }
                    catch (Exception ex)
                    {
                        SClog.insert("error", "ftp delete in update failure" + ex.ToString());
                    }
                }
                //++++++++++++++++++++++++++删除ftp文件结束++++++++++++++++++++++
                //++++++++++++++++++++++++++更新ftp文件++++++++++++++++++++++
                System.IO.Stream s = _upfile3.InputStream;

                int l = _upfile3.ContentLength;

                FTP ftp2 = new FTP();

                //获得文件后缀

                string suffix = System.IO.Path.GetExtension(_upfile3.FileName);

                fileName3 = ftp2.FTPUploadFile("ftpupload", s, l, suffix);
                //+++++++++++++++++++++++++更新ftp文件结束++++++++++++++++++++++
            }
        }
        //////////ftp上传结束///////////////
   
        
       // DB db = new DB();
        string sql = "update T_PIPECORROSION set QDMC='" + T.preHandleSql(QDMC) + "',ZDMC='" +
                      T.preHandleSql(ZDMC) + "',GDLB='" + GDLB + "', GDJSSJ= to_date('" + GDJSSJ + "','yyyy-mm-dd'),GDGG='" +
                      T.preHandleSql(GDGG) + "',GDCD='" + GDCD + "',GDCZ='" + GDCZ + "',CKSJ=to_date('" + CKSJ + "','yyyy-mm-dd'),CKSCDL='" +
                      CKSCDL + "',CKYY='" + CKYY + "',CKWZ='" + T.preHandleSql(CKWZ) + "',XLL='" + T.preHandleSql(XLL) + "',CLFS='" + T.preHandleSql(CLFS) + "', SFHF='" +
                      SFHF + "',CLWCSJ=to_date('" + CLWCSJ + "','yyyy-mm-dd'),WCLYY='" + T.preHandleSql(WCLYY) + "',XDFZR='" + T.preHandleSql(XDFZR) + "',LXFS='" +
                      T.preHandleSql(LXFS) + "',SFYZP='" + SFYZP + "',PIC1='" + fileName1 + "',PIC2='" + fileName2 + "',PIC3='" + fileName3 + "' where id='" + ID + "'";
        
        bool result=db.ExecuteSQL(sql);
       if (result)
       {
            PipeCorrosion pipe = new PipeCorrosion();
            pipe.ID = ID;
            pipe.KM = KM;
            pipe.DM = DM;
            pipe.QDMC = QDMC;
            pipe.ZDMC = ZDMC;
            pipe.GDLB = GDLB;
            pipe.GDMC = GDMC;
            pipe.GDJSSJ = T.ChangeDate(GDJSSJ);
            pipe.SSJZ = SSJZ;
            pipe.GDGG = GDGG;
            pipe.GDCD = GDCD;
            pipe.GDCZ = GDCZ;
            pipe.CKSJ = T.ChangeDate(CKSJ);

            pipe.CKSCDL = CKSCDL;
            pipe.CKYY = CKYY;
            pipe.CKWZ = CKWZ;
            pipe.XLL = XLL;
            pipe.CLFS = CLFS;
            pipe.SFHF = SFHF;
            pipe.CLWCSJ = T.ChangeDate(CLWCSJ);
            pipe.WCLYY = WCLYY;

            pipe.XDFZR = XDFZR;
            pipe.LXFS = LXFS;
            pipe.SFYZP = SFYZP;
            pipe.PIC1 = fileName1;
            pipe.PIC2 = fileName2;
            pipe.PIC3 = fileName3;
            pipe.CREATEDATE = CREATEDATE;
            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(pipe);
            context.Response.Write(json);
            context.Response.End();
       }
       else
       {
           context.Response.Write("<script>alert('  错误!\\n更新失败！');</script>");
       }
        
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}