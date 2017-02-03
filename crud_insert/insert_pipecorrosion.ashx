<%@ WebHandler Language="C#" Class="insert_pipecorrosion" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.SessionState;

public class insert_pipecorrosion : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {

        string json = "";

        string DM = Convert.ToString(context.Session["dm"]);
        string KM = Convert.ToString(context.Session["km"]);
        string CREATEDATE = DateTime.Now.ToString();
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
        string PICTURE_1 = context.Request.Params["PICTURE1"];
        string PICTURE_2 = context.Request.Params["PICTURE2"];
        string PICTURE_3 = context.Request.Params["PICTURE3"];
        //++++++++++++++++ begin 上传文件++++++++++++++++
        //高俊涛修改 2014-09-07 直接获取上传文件流 文件名称 和文件大小

        context.Response.ContentType = "text/plain";

        HttpPostedFile _upfile1= context.Request.Files["PIC1"];
        HttpPostedFile _upfile2 = context.Request.Files["PIC2"];
        HttpPostedFile _upfile3 = context.Request.Files["PIC3"];

        string fileName1 = "";//如果没有上传文件，则为空，不显示下载，高俊涛改于2014-11-11
        string fileName2 = "";
        string fileName3 = "";

        if (_upfile1.ContentLength> 0)
        {//有上传文件

            System.IO.Stream s = _upfile1.InputStream;

            int l = _upfile1.ContentLength;

            FTP ftp = new FTP();

            //获得文件后缀

            string suffix = System.IO.Path.GetExtension(_upfile1.FileName);

            fileName1 = ftp.FTPUploadFile("ftpupload", s, l, suffix);

            //++++++++++++++++ end 上传文件++++++++++++++++
        }
        if (_upfile2.ContentLength > 0)
        {//有上传文件

            System.IO.Stream s = _upfile2.InputStream;

            int l = _upfile2.ContentLength;

            FTP ftp = new FTP();

            //  获得文件后缀

            string suffix = System.IO.Path.GetExtension(_upfile2.FileName);

            fileName2 = ftp.FTPUploadFile("ftpupload", s, l, suffix);

            // ++++++++++++++++ end 上传文件++++++++++++++++
        }
        if (_upfile3.ContentLength > 0)
        {//有上传文件

            System.IO.Stream s = _upfile3.InputStream;

            int l = _upfile3.ContentLength;

            FTP ftp = new FTP();

            //获得文件后缀

            string suffix = System.IO.Path.GetExtension(_upfile3.FileName);

            fileName3 = ftp.FTPUploadFile("ftpupload", s, l, suffix);

            //++++++++++++++++ end 上传文件++++++++++++++++
        }


        string ID = "0";
        DB db = new DB();
        string sql_id = "select SEQ_PIPECORROSION.nextval from dual";
        System.Data.DataTable dt = db.GetDataTable(sql_id);
        if (dt.Rows.Count > 0) ID = dt.Rows[0][0].ToString();

        string sql = "insert into T_PIPECORROSION(ID,KM,DM,QDMC,ZDMC,GDLB,GDMC,GDJSSJ,SSJZ," +
                    "GDGG,GDCD,GDCZ,CKSJ,CKSCDL,CKYY,CKWZ,XLL,CLFS,SFHF,CLWCSJ,WCLYY,XDFZR,"+
                    "LXFS,SFYZP,CREATEDATE,PIC1,PIC2,PIC3) values (" + ID + ",'" +
                    KM + "','" + DM + "','" + T.preHandleSql(QDMC) + "','" + T.preHandleSql(ZDMC) + "','" +
                    GDLB + "', '" + GDMC + "',to_date('" + GDJSSJ + "','yyyy-mm-dd'),'" + SSJZ +
                    "','" + T.preHandleSql(GDGG) + "','" + GDCD + "','" + GDCZ + "',to_date('" + CKSJ + "','yyyy-mm-dd'),'" + CKSCDL + "','" +
                    CKYY + "','" + T.preHandleSql(CKWZ) + "','" + T.preHandleSql(XLL) + "','" + T.preHandleSql(CLFS) + "','" +
                    SFHF + "',to_date('" + CLWCSJ + "','yyyy-mm-dd'),'" + T.preHandleSql(WCLYY) + "','" +
                    T.preHandleSql(XDFZR) + "','" + T.preHandleSql(LXFS) + "','" + SFYZP + "',to_date('" + CREATEDATE + "','yyyy-mm-dd hh24:mi:ss'),'" +
            fileName1 + "','" +fileName2+ "','"+fileName3+"')";
        //'" + PIC1 + "','" + PIC2 + "','" + PIC3 + "',
        bool result=db.ExecuteSQL(sql);
        if (result)
        {

            PipeCorrosion pipe = new PipeCorrosion();
            pipe.ID = ID;
            pipe.KM = KM;
            pipe.DM = DM;
            pipe.CREATEDATE = CREATEDATE;
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

            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(pipe);
            context.Response.Write(json);
            context.Response.End();
        }
        else
        {
            context.Response.Write("<script>alert('  错误!\\n添加失败！');</script>");
        }
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}