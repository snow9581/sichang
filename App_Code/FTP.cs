using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.IO;
using System.Text;
using System.Security.Cryptography;

/// <summary>
///FTP 的摘要说明
/// </summary>
public class FTP
{
	public FTP()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}
   
    #region FTP上传文件

    /// <summary>
    /// FTP上传文件
    /// </summary>
    /// <param name="ftpServerIP">FTP服务器IP</param>
    /// <param name="ftpUserID">FTP登录帐号</param>
    /// <param name="ftpPassword">FTP登录密码</param>
    /// <param name="filename">上文件文件名（绝对路径）</param>
    public  void FTPUploadFile(string ftpServerIP, string ftpUserID, string ftpPassword, string filename)
    {
        //上传文件
        FileInfo uploadFile = null;

        //上传文件流
        FileStream uploadFileStream = null;

        //FTP请求对象
        FtpWebRequest ftpRequest = null;

        //FTP流
        Stream ftpStream = null;

        try
        {
            //获取上传文件
            uploadFile = new FileInfo(filename);

            //创建FtpWebRequest对象 
            //ftpRequest = (FtpWebRequest)FtpWebRequest.Create(new Uri("ftp://" + ftpServerIP + "/1234.txt" ));
            ftpRequest = (FtpWebRequest)FtpWebRequest.Create(new Uri("ftp://" + ftpServerIP + "/" + uploadFile.Name));


            //ftpRequest = (FtpWebRequest)FtpWebRequest.Create(new Uri("ftp://" + ftpServerIP + "/" + downloadFileName));

            //FTP登录
            ftpRequest.Credentials = new NetworkCredential(ftpUserID, ftpPassword);

            // 默认为true，连接不会被关闭 
            // 在一个命令之后被执行 
            ftpRequest.KeepAlive = false;

            //FTP请求执行方法
            ftpRequest.Method = WebRequestMethods.Ftp.UploadFile;

            // 指定数据传输类型 
            ftpRequest.UseBinary = true;

            // 上传文件时通知服务器文件的大小 
            ftpRequest.ContentLength = uploadFile.Length;

            // 缓冲大小设置为2kb 
            int buffLength = 2048;

            byte[] buff = new byte[buffLength];
            int contentLen;

            // 打开一个文件流读上传的文件 
            uploadFileStream = uploadFile.OpenRead();

            // 把上传的文件写入流 
            ftpStream = ftpRequest.GetRequestStream();

            // 每次读文件流的2kb 
            contentLen = uploadFileStream.Read(buff, 0, buffLength);

            // 流内容没有结束 
            while (contentLen != 0)
            {
                // 把内容从file stream 写入 upload stream 
                ftpStream.Write(buff, 0, contentLen);

                contentLen = uploadFileStream.Read(buff, 0, buffLength);
            }

            Console.WriteLine("上传成功！");
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.Message);
            SClog.insert("Error", "FtpWEB UpLoad Error --> " + ex.Message + "  文件名:" + filename);
        }
        finally
        {
            if (uploadFileStream != null)
            {
                uploadFileStream.Close();
            }

            if (ftpStream != null)
            {
                ftpStream.Close();
            }
        }
    }

    #endregion

    #region 流式FTP上传文件

    /// <summary>
    /// 将输入流作为源头实现FTP上传
    /// </summary>
    /// <param name="package">FTP文件夹</param>
    /// <param name="fs">文件输入流</param>
    /// <param name="length">流长度（字节）</param>
    /// <param name="suffix">上传文件后缀</param>
    /// <returns>返回上传到ftp服务器的文件名</returns>
 

    public string FTPUploadFile(string package, Stream fs,int length,string suffix)
    {

        //FTP服务器IP地址
        string ftpServerIP = System.Configuration.ConfigurationSettings.AppSettings["ftpIP"].ToString(); 

        //FTP登录用户名
        string ftpUserID = System.Configuration.ConfigurationSettings.AppSettings["ftpuser"].ToString(); 

        //FTP登录密码
        string ftpPassword = System.Configuration.ConfigurationSettings.AppSettings["ftppasswd"].ToString(); 
                

        //FTP请求对象
        FtpWebRequest ftpRequest = null;

        //FTP流
        Stream ftpStream = null;

        string fileName = "";

        try
        {

            fileName = GenerateFileName() + suffix;

            //创建FtpWebRequest对象 
            ftpRequest = (FtpWebRequest)FtpWebRequest.Create(new Uri("ftp://" + ftpServerIP +"/"+package+ "/" + fileName));


            //FTP登录
            ftpRequest.Credentials = new NetworkCredential(ftpUserID, ftpPassword);

            // 默认为true，连接不会被关闭 
            // 在一个命令之后被执行 
            ftpRequest.KeepAlive = false;

            //FTP请求执行方法
            ftpRequest.Method = WebRequestMethods.Ftp.UploadFile;

            // 指定数据传输类型 
            ftpRequest.UseBinary = true;

            // 上传文件时通知服务器文件的大小 
            ftpRequest.ContentLength = length;

            // 缓冲大小设置为2kb 
            int buffLength = 2048*10;

            byte[] buff = new byte[buffLength];
            int contentLen;

       
            // 把上传的文件写入流 
            ftpStream = ftpRequest.GetRequestStream();

            // 每次读文件流的2kb 
            contentLen = fs.Read(buff, 0, buffLength);

            // 流内容没有结束 
            while (contentLen != 0)
            {
                // 把内容从file stream 写入 upload stream 
                ftpStream.Write(buff, 0, contentLen);
                
                contentLen = fs.Read(buff, 0, buffLength);
            }            

            Console.WriteLine("上传成功！");

            return fileName;

           
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.Message);
            SClog.insert("Error", "FtpWEB UpLoad Error --> " + ex.Message + "  文件名:" + fileName);

            return "";
           
        }
        finally
        {
            if (fs != null)
            {
                fs.Close();
            }

            if (ftpStream != null)
            {
                ftpStream.Close();
            }

            
        }
    }
    #endregion

    #region GenerateFileName
    /// <summary>
    /// 用时间和8位随机字符串生成文件名
    /// </summary>
    /// <returns></returns>
    string GenerateFileName()
    {
      //  string strFileName = DateTime.Now.ToLongTimeString() + "-" + GetRandomStringOnly();
        string strFileName = DateTime.Now.Ticks+GetRandomStringOnly();
        return strFileName;
    
    }
    #endregion

    /// <summary>
    /// 生成标准8位小写随机字符串，不包含特殊字符
    /// </summary>
    /// <returns>标准随机字符串</returns>
    public static string GetRandomStringOnly()
    {
     //   return BuildRndCodeOnly(sCharLow + sNumber, 8);
        return BuildRndCodeOnly("abcdefghigklmnopqrstuvwxyz1234567890", 8);
    }


    private static string BuildRndCodeOnly(string StrOf, int strLen)
    {

        System.Random RandomObj = new System.Random(GetNewSeed());

        string buildRndCodeReturn = null;

        for (int i = 0; i < strLen; i++)
        {

            buildRndCodeReturn += StrOf.Substring(RandomObj.Next(0, StrOf.Length - 1), 1);

        }

        return buildRndCodeReturn;

    }

    private static int GetNewSeed()
    {

        byte[] rndBytes = new byte[4];

        RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();

        rng.GetBytes(rndBytes);

        return BitConverter.ToInt32(rndBytes, 0);

    }


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
        string saveFilePath, string saveFileName, string downloadFileName)
    {
        //定义FTP请求对象
        FtpWebRequest ftpRequest = null;
        //定义FTP响应对象
        FtpWebResponse ftpResponse = null;

        //存储流
        FileStream saveStream = null;
        //FTP数据流
        Stream ftpStream = null;

        try
        {
            //生成下载文件
            saveStream = new FileStream(saveFilePath + "\\" + saveFileName, FileMode.Create);

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

            //响应数据长度
            long cl = ftpResponse.ContentLength;

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
            Console.WriteLine("下载成功！");
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.Message);
            SClog.insert("Error", "FtpWEB DownLoad Error --> " + ex.Message +"  下载路径："+saveFilePath+ "  保存文件名:" +saveFileName+"  下载文件名："+downloadFileName);
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
    
    #region FTP获取文件列表

    /// <summary>
    /// FTP获取文件列表
    /// </summary>
    /// <param name="ftpServerIP"></param>
    /// <param name="ftpUserID"></param>
    /// <param name="ftpPassword"></param>
    /// <returns></returns>
    public string[] FTPGetFileList(string ftpServerIP, string ftpUserID, string ftpPassword)
    {
        //响应结果
        System.Text.StringBuilder result = new StringBuilder();

        //FTP请求
        System.Net.FtpWebRequest ftpRequest = null;

        //FTP响应
        WebResponse ftpResponse = null;

        //FTP响应流
        StreamReader ftpResponsStream = null;

        try
        {
            //生成FTP请求
            ftpRequest = (FtpWebRequest)FtpWebRequest.Create(new Uri("ftp://" + ftpServerIP + "/"));

            //设置文件传输类型
            ftpRequest.UseBinary = true;

            //FTP登录
            ftpRequest.Credentials = new NetworkCredential(ftpUserID, ftpPassword);

            //设置FTP方法
            ftpRequest.Method = WebRequestMethods.Ftp.ListDirectory;

            //生成FTP响应
            ftpResponse = ftpRequest.GetResponse();

            //FTP响应流
            ftpResponsStream = new StreamReader(ftpResponse.GetResponseStream());

            string line = ftpResponsStream.ReadLine();

            while (line != null)
            {
                result.Append(line);
                result.Append("\n");
                line = ftpResponsStream.ReadLine();
            }

            //去掉结果列表中最后一个换行
            result.Remove(result.ToString().LastIndexOf('\n'), 1);

            //返回结果
            return result.ToString().Split('\n');
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.Message);
            SClog.insert("Error", "FtpWEB GetFileList Error --> " + ex.Message );
            return (null);
        }
        finally
        {
            if (ftpResponsStream != null)
            {
                ftpResponsStream.Close();
            }

            if (ftpResponse != null)
            {
                ftpResponse.Close();
            }
        }
    }

    #endregion
    
    #region 删除文件
    /// <summary>
    /// 删除文件 高俊涛添加2014-10-26
    /// </summary>
    /// <param name="fileName"></param>
    public void Delete(string package, string fileName)
    {
         //FTP服务器IP地址
        string ftpServerIP = System.Configuration.ConfigurationSettings.AppSettings["ftpIP"].ToString(); 

        //FTP登录用户名
        string ftpUserID = System.Configuration.ConfigurationSettings.AppSettings["ftpuser"].ToString(); 

        //FTP登录密码
        string ftpPassword = System.Configuration.ConfigurationSettings.AppSettings["ftppasswd"].ToString();        
        try
        {
        
            FtpWebRequest reqFTP;
        
            reqFTP =  (FtpWebRequest)FtpWebRequest.Create(new Uri("ftp://" + ftpServerIP +"/"+package+ "/" + fileName));

            reqFTP.Credentials = new NetworkCredential(ftpUserID, ftpPassword);

            reqFTP.KeepAlive = false;

            reqFTP.Method = WebRequestMethods.Ftp.DeleteFile;

            string result = String.Empty;

            FtpWebResponse response = (FtpWebResponse)reqFTP.GetResponse();

            long size = response.ContentLength;

            Stream datastream = response.GetResponseStream();

            StreamReader sr = new StreamReader(datastream);

            result = sr.ReadToEnd();

            sr.Close();

            datastream.Close();

            response.Close();

        }
        catch (Exception ex)
        {
            SClog.insert("Error", "FtpWEB Delete Error --> " + ex.Message + "  文件名:" + fileName);
        }
    }
    #endregion
}
