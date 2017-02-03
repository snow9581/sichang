<%@ WebHandler Language="C#" Class="SubmitCommission" %>

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

public class SubmitCommission : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string username = Convert.ToString(context.Session["username"]);
        string major = Convert.ToString(context.Session["major"]);
        string type = context.Request.Params["hd_type"];
        if (type == "1")
            type = "一次委托资料";
        else if (type == "2")
            type = "二次委托资料";
        string Pid = context.Request.Params["hd_id"];
        int length = int.Parse(context.Request.Params["ckLength"]);
        bool flag=false;
        string [] fileWORDName =new string[length];
        string [] majorPersonnel = new string[length];
        string [] selectMajor = new string[length];
        
        for (int i = 0; i < length; i++)
        {
            majorPersonnel[i] = context.Request.Params["combobox" + i];
            selectMajor[i] = context.Request.Params["selectMajor" + i];
            HttpPostedFile _upfileWORD = context.Request.Files["commission"+i];
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

                    fileWORDName[i] = ftp.FTPUploadFile("archives", s, l, suffix);
                    //++++++++++++++++ end 上传文件++++++++++++++++
                }

            }
            catch { }
       
        DB db = new DB();
        //委托资料存档到电子档案
        string sql_select = "select pname,pnumber from T_PLANRUN_DTZ where pid='"+Pid+"'";
        DataTable dt = db.GetDataTable(sql_select);
        if (dt.Rows.Count > 0)
        {
            string sql = "insert into T_COMMISSIONINFORMATION(ID,PNAME,PNUMBER,CONSIGNER,CONSIGNERMAJOR,SENDEE,SENDEEMAJOR,FILES,FILETYPE,RELEASERQ) values(SEQ_COMINF.nextval,'" + dt.Rows[0]["pname"] + "','" + dt.Rows[0]["pnumber"] + "','" + username + "','" + major + "','" + majorPersonnel[i] + "','" + selectMajor[i] + "','" + fileWORDName[i] + "','"+type+"',to_date('" + DateTime.Now.ToString() + "','yyyy-mm-dd hh24:mi:ss'))";
            flag = db.ExecuteSQL(sql);
        }
        if (flag == false)
            break;
        }
        if (flag)
        {  
            context.Response.Write("1");
        }
        else
            context.Response.Write("0");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}