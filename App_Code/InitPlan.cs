using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
///InitPlan 的摘要说明  初设文档
/// </summary>
public class InitPlan
{
	public InitPlan()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}
    public string ID { get; set; }
    public string PID { get; set; }
    public string PNAME{ get; set; }
    public string INITRQ { get; set; }
    public string PLEADER { get; set; }
    public string KWORDS { get; set; }
    public string DESIGNSPECIAL { get; set; }  //设计专业
    public string FILENUMBER { get; set; }   //档案号
    public string REVIEWER { get; set; }
    public string BZ { get; set; }
    public string FILES { get; set; }  //初设文档
}
