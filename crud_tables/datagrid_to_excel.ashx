<%@ WebHandler Language="C#" Class="datagrid_to_excel" %>

using System;
using System.Web;
using System.IO;
using System.Text;

public class datagrid_to_excel : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        /**
         * 下载方式不太好，需要定时删除临时文件。。。
         * **/

        string fn = DateTime.Now.ToString("yyyyMMddHHmmssfff") + ".xls";
        string data = context.Request.Form["data"];


        System.IO.File.WriteAllText(context.Server.MapPath(fn), data, System.Text.Encoding.GetEncoding("GB2312"));//如果是gb2312的xml申明，第三个编码参数修改为Encoding.GetEncoding(936)
        //与处理页面存在同一文件夹下        

        context.Response.ContentType = "application / ms - excel";
        context.Response.Write(fn);//返回文件名提供下载
    }
        //DB db = new DB();
        //SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationSettings.AppSettings["conn"]);
        //SqlDataAdapter da = new SqlDataAdapter("select * from tb1", conn);
        //DataSet ds = new DataSet();
        //da.Fill(db, "table1");
        //DataTable dt = db.Tables["table1"];
        //DataTable dt = db.GetDataTable(sqlstr);
        //StringWriter fn = new StringWriter();
        //fn.WriteLine("自动编号,姓名,年龄");
        //foreach (DataRow dr in dt.Rows)
        //{
        //    fn.WriteLine(dr["ID"] + "," + dr["vName"] + "," + dr["iAge"]);
        //}
        //fn.Close();
        //Response.AddHeader("Content-Disposition", "attachment; filename=test.xls");
        //Response.ContentType = "application/vnd.ms-excel";
        //Response.ContentEncoding = System.Text.Encoding.GetEncoding("GB2312");
        //Response.Write(fn);
        //Response.End();

        //}

    //    context.Response.Clear();
    //    context.Response.ContentEncoding = System.Text.Encoding.GetEncoding("gb2312");
    //    context.Response.Buffer = true;
    //    context.Response.ContentType = "application/vnd.ms-excel";
    //    context.Response.Charset = "";
    //    //this.EnableViewState = false;
    //    string fn = DateTime.Now.ToString("yyyyMMddHHmmssfff") + ".xls";
    //   

    //    System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
    //    System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
    //    for (int i = 0; i < datagrid.PageCount; i++)
    //    {
    //        datagrid.CurrentPageIndex = i;
    //        datagrid.RenderControl(oHtmlTextWriter);
    //    }
    //    context.Response.AppendHeader("Content-Disposition", "attachment;filename= fn");
    //    context.Response.Write(oStringWriter.ToString());
    //    context.Response.End();
    //}
 
    public bool IsReusable {
        get {
                return false;
            }
    }

}