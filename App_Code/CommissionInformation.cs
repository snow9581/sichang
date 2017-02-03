using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
///CommissionInformation 的摘要说明
/// </summary>
public class CommissionInformation
{
	public CommissionInformation()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}
    public string ID { get; set; }
    public string PID { get; set; }
    public string PNUMBER { get; set; }
    public string PNAME { get; set; }
    public string CONSIGNER { get; set; }
    public string CONSIGNERMAJOR { get; set; }
    public string SENDEE { get; set; }
    public string SENDEEMAJOR { get; set; }
    public string RELEASERQ { get; set; }
    public string FILETYPE { get; set; }  //文件类型
    public string BZ { get; set; }
    public string FILES { get; set; }  //委托资料
}