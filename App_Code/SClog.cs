using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Text.RegularExpressions;
using System.IO;
//高俊涛创建 2014.10
//高俊涛修正 2015.8.29 发现采用static类型dtlog变量控制日志的创建或追加是有问题的。如果IIS不重新启动没问题。如果发生重启操作，就会引起当月日志丢失的问题。

/// <summary>
///将系统事件写如日志文件
/// </summary>
public class SClog
{
	public SClog()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}   
    public static void insert(string type, string message)
    { 
       //获取当前时间
        DateTime Now = DateTime.Now;
        
       //生成日志文件路径
        string logPath = System.AppDomain.CurrentDomain.BaseDirectory + @"logs\log" + Now.ToString("yyyyMM") + ".txt";

        try
        {
            if (!System.IO.File.Exists(logPath))//如果文件不存在，则创建文件，并执行写入操作
            {
                using (System.IO.StreamWriter sw = System.IO.File.CreateText(logPath))
                {
                    sw.WriteLine(type + ":\t" + message + "\t" + Now.ToString("yyyy-MM-dd HH：mm：ss：ffff")); //将第一条消息写入日志文件
                    sw.Close();
                }
            }
            else {//否则打开文件，直接写入
                FileStream fs = new FileStream(logPath, FileMode.Append);
                System.IO.StreamWriter sw = new System.IO.StreamWriter(fs);
                sw.WriteLine(type + ":\t" + message + "\t" + Now.ToString("yyyy-MM-dd HH：mm：ss：ffff"));
                sw.Close();
                fs.Close();            
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.ToString());
        }
       
    }
       
}
