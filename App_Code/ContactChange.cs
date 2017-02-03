using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
///ContactChange 的摘要说明  初设文档
/// </summary>
public class ContactChange
{
	public ContactChange()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}
    public string ID { get; set; }
    public string PID { get; set; }
    public string PNAME{ get; set; }    
    public string PLEADER { get; set; }
    public string SPECIALLEADER { get; set; }  //联络变更文档
    public string CHANGERQ { get; set; }       //联络变更时间
    public string CHANGEDETAIL { get; set; }   //联络变更内容
    public string CHANGEREASON { get; set; }   //联络变更原因
    public string INVESTCHANGE { get; set; }   //投资增减情况
    public string FILETYPE { get; set; }
    public string BZ { get; set; }
    public string FILES { get; set; }  //联络变更文档
}
