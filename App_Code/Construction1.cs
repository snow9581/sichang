using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
///construction1 的摘要说明  初设文档
/// </summary>
public class Construction1
{
    public Construction1()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}
    public string ID { get; set; }
    public string ARCHIVENO { get; set; }     //存档号
    public string DESIGNSPECIAL { get; set; } 
    public string FILENUMBER { get; set; }
    public string PID { get; set; }
    public string PNAME{ get; set; }
    public string DESIGNRQ { get; set; }
    public string ARCHIVERQ { get; set; }
    public string PLEADER { get; set; }       //项目负责人
    public string REVIEWER { get; set; }
    public string PAGENO { get; set; }     //文字页数
    public string ONEFIGURE { get; set; }  //折合一号图
    public string ARCHIVESTATE { get; set; }   //存档情况
    public string BORROWRQ { get; set; }   //借阅日期
    public string BORROWER { get; set; }   //借阅人
    public string RETURNRQ { get; set; }   //归还日期
    public string RETURNER { get; set; }   //归还人
    public string BZ { get; set; }
    //public string FILES { get; set; }  //施工图文档
}
