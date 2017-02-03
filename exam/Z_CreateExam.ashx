<%@ WebHandler Language="C#" Class="Z_CreateExam" %>

using System;
using System.Web;
using System.IO;
public class Z_CreateExam : IHttpHandler
{
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.Write("Hello World");
        //string E_TITLE = context.Request.Form["E_TITLE"];
        //string status = context.Request.InputStream["status"];
        string json = new StreamReader(context.Request.InputStream).ReadToEnd(); 
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}