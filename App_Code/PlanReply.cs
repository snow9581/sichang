using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
///PlanReply 的摘要说明  初设文档
/// </summary>
public class PlanReply
{
	public PlanReply()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}
    public string ID { get; set; }
    public string PID { get; set; }
    public string PNAME{ get; set; }
    public string RELEASERQ { get; set; }
    public string FILENUMBER { get; set; }   //文件号
    public string PLANMONEY { get; set; }    //计划批复投资
    public string FILETYPE { get; set; }  //文件类型
    public string BZ { get; set; }
    public string FILES { get; set; }  //计划批复文档
}
