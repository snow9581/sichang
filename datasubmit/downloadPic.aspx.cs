using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Net;
using System.Collections;
//
public partial class crud_tables_downloadPic : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //高俊涛修改 增加从webconfig中读取ftp服务器地址，用户名和密码功能。 2014-09-07

        //高俊涛修改 增加参数package允许下载多个文件夹的文件 2014-09-08

        string picName = Convert.ToString(Request.QueryString["picName"]);

        //下载文件夹
        string package = Convert.ToString(Request.QueryString["package"]);

        //FTP服务器IP地址
        string ftpServerIP = System.Configuration.ConfigurationSettings.AppSettings["ftpIP"].ToString();

        //FTP登录用户名
        string ftpUserID = System.Configuration.ConfigurationSettings.AppSettings["ftpuser"].ToString();

        //FTP登录密码
        string ftpPassword = System.Configuration.ConfigurationSettings.AppSettings["ftppasswd"].ToString();


        //  FTPDownloadFile(ftpServerIP+"/"+package, ftpUserID, ftpPassword, picName, picName);

        FTPDirectDownloadFile(ftpServerIP + "/" + package, ftpUserID, ftpPassword, picName);

    }
    #region FTP下载文件

    /// <summary>
    /// FTP直接下载
    /// </summary>
    /// <param name="ftpServerIP">FTP服务器IP及目录</param>
    /// <param name="ftpUserID">FTP登录帐号</param>
    /// <param name="ftpPassword">FTP登录密码</param>
    /// <param name="downloadFileName">下载文件名</param>
    public void FTPDirectDownloadFile(string ftpServerIP, string ftpUserID, string ftpPassword, string downloadFileName)
    {
        //定义FTP请求对象
        FtpWebRequest ftpRequest = null;
        //定义FTP响应对象
        FtpWebResponse ftpResponse = null;
        //FTP数据流
        Stream ftpStream = null;

        try
        {
            //生成FTP请求对象
            ftpRequest = (FtpWebRequest)FtpWebRequest.Create(new Uri("ftp://" + ftpServerIP + "/" + downloadFileName));

            //设置下载文件方法
            ftpRequest.Method = WebRequestMethods.Ftp.DownloadFile;

            //设置文件传输类型
            ftpRequest.UseBinary = true;

            //设置登录FTP帐号和密码
            ftpRequest.Credentials = new NetworkCredential(ftpUserID, ftpPassword);

            //生成FTP响应对象
            ftpResponse = (FtpWebResponse)ftpRequest.GetResponse();

            //获取FTP响应流对象
            ftpStream = ftpResponse.GetResponseStream();


            System.Collections.ArrayList temp = new System.Collections.ArrayList();//临时存放文件数据

            int bufferSize = 2048;
            int readCount;
            byte[] buffer = new byte[bufferSize];
            //高俊涛改进于2014-11-11，不需要开辟文件大小的缓冲区，支持大文件的直接下载。
            Response.ContentType = "application/octet-stream"; //通知浏览器下载文件而不是打开            

            Response.AddHeader("Content-Disposition", "attachment;  filename=" + HttpUtility.UrlEncode(downloadFileName, System.Text.Encoding.UTF8));
            //接收FTP文件流
            readCount = ftpStream.Read(buffer, 0, bufferSize);

            while (readCount > 0)
            {
                if (readCount < bufferSize)//到了文件的尾部，需要临时开辟一块适合大小的缓冲区输出到浏览器端。
                {
                    byte[] buffer_tail = new byte[readCount];
                    for (int i = 0; i < readCount; i++)
                    {
                        buffer_tail[i] = buffer[i];
                    }
                    Response.BinaryWrite(buffer_tail);
                }
                else
                {
                    Response.BinaryWrite(buffer);
                }

                readCount = ftpStream.Read(buffer, 0, bufferSize);
            }

            Response.Flush();

            Response.End();
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.Message);
        }
        finally
        {
            if (ftpStream != null)
            {
                ftpStream.Close();
            }

            if (ftpResponse != null)
            {
                ftpResponse.Close();
            }
        }
    }

    #endregion


    #region FTP下载文件

    /// <summary>
    /// FTP下载文件
    /// </summary>
    /// <param name="ftpServerIP">FTP服务器IP</param>
    /// <param name="ftpUserID">FTP登录帐号</param>
    /// <param name="ftpPassword">FTP登录密码</param>
    /// <param name="saveFilePath">保存文件路径</param>
    /// <param name="saveFileName">保存文件名</param>
    /// <param name="downloadFileName">下载文件名</param>
    public void FTPDownloadFile(string ftpServerIP, string ftpUserID, string ftpPassword,
        string saveFileName, string downloadFileName)
    {
        //定义FTP请求对象
        FtpWebRequest ftpRequest = null;
        //定义FTP响应对象
        FtpWebResponse ftpResponse = null;

        //存储流
        FileStream saveStream = null;
        //FTP数据流
        Stream ftpStream = null;

        string filePath_t = "";//临时文件的全路径

        filePath_t = Server.MapPath(saveFileName);

        try
        {
            //生成下载文件
            saveStream = new FileStream(filePath_t, FileMode.Create);
            //生成FTP请求对象
            ftpRequest = (FtpWebRequest)FtpWebRequest.Create(new Uri("ftp://" + ftpServerIP + "/" + downloadFileName));

            //设置下载文件方法
            ftpRequest.Method = WebRequestMethods.Ftp.DownloadFile;

            //设置文件传输类型
            ftpRequest.UseBinary = true;

            //设置登录FTP帐号和密码
            ftpRequest.Credentials = new NetworkCredential(ftpUserID, ftpPassword);

            //生成FTP响应对象
            ftpResponse = (FtpWebResponse)ftpRequest.GetResponse();

            //获取FTP响应流对象
            ftpStream = ftpResponse.GetResponseStream();
            int bufferSize = 2048;
            int readCount;
            byte[] buffer = new byte[bufferSize];
            //接收FTP文件流
            readCount = ftpStream.Read(buffer, 0, bufferSize);
            while (readCount > 0)
            {
                saveStream.Write(buffer, 0, readCount);

                readCount = ftpStream.Read(buffer, 0, bufferSize);
            }
            saveStream.Close();

            /* 怎么直接将ftpStream写入字节流……
            byte[] bytes = new byte[2048];
            ftpStream.Read(bytezdc, 0, bytezdc.Length);
            */

            //现在是两步转换，先将FTP服务器上的文件下载到本地，再将本地文件另存为……

            // string fPath = "c:/" + saveFileName;//改为虚拟目录根目录
            //     string fPath = filePath_t;
            //      string fPath = Server.MapPath(saveFileName);

            FileStream fs = new FileStream(filePath_t, FileMode.Open);
            byte[] bytes = new byte[(int)fs.Length];
            fs.Read(bytes, 0, bytes.Length);
            fs.Close();
            File.Delete(filePath_t);//将中间临时文件删除！（）
            Response.ContentType = "application/octet-stream"; //通知浏览器下载文件而不是打开            
            Response.AddHeader("Content-Disposition", "attachment;  filename=" + HttpUtility.UrlEncode(saveFileName, System.Text.Encoding.UTF8));
            Response.BinaryWrite(bytes);
            Response.Flush();
            Response.End();
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.Message);
        }
        finally
        {
            if (ftpStream != null)
            {
                ftpStream.Close();
            }

            if (saveStream != null)
            {
                saveStream.Close();
            }

            if (ftpResponse != null)
            {
                ftpResponse.Close();
            }
        }
    }

    #endregion

    #region 下载 保存路径
    private void DownLoad(string strName, string strPath)
    {
        string fileName = strName;//客户端保存的文件名            
        string filePath = Server.MapPath(strPath);//路径             //以字符流的形式下载文件            
        FileStream fs = new FileStream(filePath, FileMode.Open);
        byte[] bytes = new byte[(int)fs.Length];
        fs.Read(bytes, 0, bytes.Length);
        fs.Close();
        Response.ContentType = "application/octet-stream";            //通知浏览器下载文件而不是打开            
        Response.AddHeader("Content-Disposition", "attachment;  filename=" + HttpUtility.UrlEncode(fileName, System.Text.Encoding.UTF8));
        Response.BinaryWrite(bytes);
        Response.Flush();
        Response.End();
    }
    #endregion
}
