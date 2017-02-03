<%@ WebHandler Language="C#" Class="update_house" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.SessionState;
public class update_house : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string json = "";
        string ID = context.Request.Params["ID"];
        string KM = context.Request.Params["KM"];
        string DM = context.Request.Params["DM"];
        string CREATEDATE = DateTime.Now.ToString();
        string ZM = context.Request.Params["ZM"];
        string HNAME = context.Request.Params["HNAME"];
        string HFUNCTION = context.Request.Params["HFUNCTION"];
        string TCRQ = context.Request.Params["TCRQ"];
        //string TCRQ = Convert.ToDateTime(context.Request.Params["TCRQ"]).ToShortDateString();
        
        string HAREA = context.Request.Params["HAREA"];
        string HSTRUCTURE = context.Request.Params["HSTRUCTURE"];

        string FSFS = context.Request.Params["FSFS"];
        string WXRQ = context.Request.Params["WXRQ"];
       // string WXRQ = Convert.ToDateTime(context.Request.Params["WXRQ"]).ToShortDateString();
        string WXNR = context.Request.Params["WXNR"];
        string BZ = context.Request.Params["BZ"];
        string PICTURE = context.Request.Params["PICTURE"];
        //string PICFILE = context.Request.Params["PICFILE"];

        //////////ftp开始上传///////////////
        HttpPostedFile _upfile = context.Request.Files["PICFILE"];
        context.Response.ContentType = "text/plain";
        string fileName = "#";//如果没有上传文件，则为#号，不显示下载  
        DB db = new DB();
        string filename = "";
        string idsql = "select PICTURE from T_HOUSE where ID='" + T.preHandleSql(ID) + "'";
        System.Data.DataTable dt = db.GetDataTable(idsql);
        if (dt.Rows.Count > 0)
            filename = dt.Rows[0]["PICTURE"].ToString();

        if (_upfile.ContentLength > 0)
        {//有上传文件 先删除原有文件
            //++++++++++++++++++++++++++删除已存在的ftp文件++++++++++++++++++++++
            if (filename != "")
            {
                try
                {
                    FTP ftp1 = new FTP();
                    ftp1.Delete("ftpimage", filename);
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

            fileName = ftp2.FTPUploadFile("ftpimage", s, l, suffix);
            //+++++++++++++++++++++++++更新ftp文件结束++++++++++++++++++++++
        }
        //////////ftp上传结束///////////////
        
        string sql = "update T_HOUSE set ZM='" + T.preHandleSql(ZM) + "',HNAME='" + T.preHandleSql(HNAME) + "',HFUNCTION='" +
                      T.preHandleSql(HFUNCTION) + "',TCRQ= to_date('" + TCRQ + "','yyyy-mm-dd'),HAREA='" + HAREA + "',HSTRUCTURE='" + HSTRUCTURE +
                      "',FSFS='" + FSFS + "', WXRQ=to_date('" + WXRQ + "','yyyy-mm-dd'),WXNR='" + T.preHandleSql(WXNR) +
                      "',BZ='" + T.preHandleSql(BZ) + "',CREATEDATE =to_date('" + CREATEDATE + "','yyyy-mm-dd hh24:mi:ss')";//高俊涛修改 2014-09-07 把文件名filename存入数据库
        if (fileName != "#")
        {
            sql += ",PICTURE='" + fileName + "'";
        }
        sql += " where ID='" + T.preHandleSql(ID) + "'";
        
        bool result=db.ExecuteSQL(sql);
        if (result)
        {
            context.Response.ContentType = "text/plain";
            House house = new House();
            house.ID = ID;
            house.KM = KM;
            house.DM = DM;
            house.ZM = ZM;
            house.HNAME = HNAME;
            house.HFUNCTION = HFUNCTION;
            house.TCRQ = T.ChangeDate(TCRQ);
            house.HAREA = HAREA;
            house.HSTRUCTURE = HSTRUCTURE;
            house.FSFS = FSFS;
            house.WXRQ = T.ChangeDate(WXRQ); ;
            house.WXNR = WXNR;
            if (fileName != "#")
            {
                house.PICTURE = fileName;
            }
            else
            {
                house.PICTURE = filename;
            }
            house.BZ = BZ;
            house.CREATEDATE = CREATEDATE;
            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(house);
            context.Response.Write(json);
            context.Response.End();
        }
        else
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write("<script>alert('  错误!\\n更新失败！');</script>");
        }
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}