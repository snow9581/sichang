<%@ WebHandler Language="C#" Class="get_banzu" %>

using System;
using System.Web;
using System.Text;

public class get_banzu : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        String jsonData = "[{\"text\":\"干式水表\"},{\"text\":\"水流量仪表\"},{\"text\":\"自动化仪表\"},{\"text\":\"测控维护\"},{\"text\":\"气表\"}]";
                
        context.Response.Write(jsonData);
        context.Response.End();
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}