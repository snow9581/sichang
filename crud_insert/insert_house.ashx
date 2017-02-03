<%@ WebHandler Language="C#" Class="insert_house" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.SessionState;

public class insert_house : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        string json = "";
        string DM = Convert.ToString(context.Session["dm"]);
        string KM = Convert.ToString(context.Session["km"]);
        string CREATEDATE = DateTime.Now.ToString();
      
        string ZM = context.Request.Params["ZM"];
        string HNAME = context.Request.Params["HNAME"];
        string HFUNCTION = context.Request.Params["HFUNCTION"];
         
        string TCRQ = context.Request.Params["TCRQ"];

        string HAREA = context.Request.Params["HAREA"];
        
        string HSTRUCTURE = context.Request.Params["HSTRUCTURE"];

        string FSFS = context.Request.Params["FSFS"];
       
        string WXRQ = context.Request.Params["WXRQ"];

        string WXNR = context.Request.Params["WXNR"];
        
        string PICTURE = context.Request.Params["PICFILE"];
        
        string BZ = context.Request.Params["BZ"];

        //++++++++++++++++ begin 上传文件++++++++++++++++
        //高俊涛修改 2014-09-07 直接获取上传文件流 文件名称 和文件大小

        context.Response.ContentType = "text/plain";
        
        HttpPostedFile _upfile = context.Request.Files["PICFILE"];

        string fileName = "";//如果没有上传文件，则为空，不显示下载，高俊涛改于2014-11-11

        if (_upfile.ContentLength > 0)            
        {//有上传文件

            System.IO.Stream s = _upfile.InputStream;

            int l = _upfile.ContentLength;

            FTP ftp = new FTP();

            //获得文件后缀

            string suffix = System.IO.Path.GetExtension(_upfile.FileName);

            fileName = ftp.FTPUploadFile("ftpimage", s, l, suffix);

            //++++++++++++++++ end 上传文件++++++++++++++++
        }
        string ID = "0";
        DB db = new DB();
        string sql_id = "select SEQ_HOUSE.nextval from dual";
        System.Data.DataTable dt = db.GetDataTable(sql_id);
        if (dt.Rows.Count > 0) ID = dt.Rows[0][0].ToString();


        string sql = "insert into T_HOUSE(ID,KM,DM,ZM,HNAME,HFUNCTION,TCRQ,HAREA,HSTRUCTURE," +
                     "FSFS,WXRQ,WXNR,PICTURE,BZ,CREATEDATE) values (" + ID + ",'" +
                     KM + "','" + DM + "','" + T.preHandleSql(ZM) + "','" + T.preHandleSql(HNAME) + "','" + T.preHandleSql(HFUNCTION) + "', to_date('" + TCRQ + "','yyyy-mm-dd'),'" +
                     HAREA + "','" + HSTRUCTURE + "','" + FSFS + "',to_date('" + WXRQ + "','yyyy-mm-dd'),'" +
                     T.preHandleSql(WXNR) + "','" + fileName + "','" + T.preHandleSql(BZ) + "',to_date('" + CREATEDATE + "','yyyy-mm-dd hh24:mi:ss'))"; //高俊涛修改 2014-09-07 把文件名filename存入数据库
        
        bool result=db.ExecuteSQL(sql);

        if (result)
        {
            House house = new House();
            house.ID = ID;
            house.KM = KM; 
            house.DM = DM;
            house.ZM = ZM;
            house.HNAME = HNAME;
            house.HFUNCTION = HFUNCTION;
            house.TCRQ = T.ChangeDate(TCRQ);
            house.HAREA = HAREA.ToString();
            house.HSTRUCTURE = HSTRUCTURE;
            house.FSFS = FSFS;
            house.WXRQ = T.ChangeDate(WXRQ); ;
            house.WXNR = WXNR;
            house.PICTURE = fileName;//高俊涛修改 2014-09-07 所文件名传回主界面处理。
            house.BZ = BZ;
            house.CREATEDATE = CREATEDATE;
            JavaScriptSerializer jss = new JavaScriptSerializer();
            json = jss.Serialize(house);
            context.Response.Write(json);
            context.Response.End();
        }
        else {
            context.Response.ContentType = "text/html";
            context.Response.Write("<script>alert('  错误!\\n添加失败！');</script>");
        }
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}