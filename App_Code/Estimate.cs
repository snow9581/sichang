using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
///Estimate 的摘要说明  概算文档
/// </summary>
public class Estimate
{
	public Estimate()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}
    public string ID { get; set; }
    public string PID { get; set; }
    public string PNAME{ get; set; }
    public string PLEADER { get; set; }
    public string PMONEY { get; set; }
    public string ESTIMATESPECIAL { get; set; }  //概算专业
    public string ESTIMATETYPE { get; set; }   //概算类型
    public string REVIEWER { get; set; }
    public string BZ { get; set; }
    public string FILES { get; set; }  //概算文档
}
