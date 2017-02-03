using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
///ProofCheck 的摘要说明  初设文档
/// </summary>
public class ProofCheck
{
    public ProofCheck()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}
    public string ID { get; set; }
    public string PID { get; set; }
    public string PNAME{ get; set; }
    public string DESIGNRQ { get; set; }
    public string FILENUMBER { get; set; }   //档案号
    public string DESIGNTYPE { get; set; }  //设计类型
    public string BZ { get; set; }
    public string FILES { get; set; }  //校对审核记录文档
}
