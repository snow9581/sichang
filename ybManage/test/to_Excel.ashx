<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;
using System.IO;

public class Handler : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/html";
        string filename = context.Request.Params["filename"];
        //context.Response.Write("<script type='javascript'>window.location='./ybManage/test/20160716091531.xls'</script>");
        string RealFile = context.Server.MapPath("~/ybManage/test/" + filename);//真实存在的文件
        if (!System.IO.File.Exists(RealFile))
        {
            context.Response.Write("服务器上该文件已被删除或不存在！"); return;
        }
        context.Response.Buffer = true;
        context.Response.Clear();
        context.Response.ContentType = "application/download";
        string downFile=System.IO.Path.GetFileName(filename);//这里也可以随便取名
        string EncodeFileName = HttpUtility.UrlEncode(downFile, System.Text.Encoding.UTF8);//防止中文出现乱码
        context.Response.AddHeader("Content-Disposition", "attachment;filename=" + EncodeFileName + ";");
        context.Response.BinaryWrite(System.IO.File.ReadAllBytes(RealFile));//返回文件数据给客户端下载
        context.Response.Flush();
        //File.Delete(RealFile);
        context.Response.End();
        

    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}