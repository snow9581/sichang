using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
///House 的摘要说明
/// </summary>
public class House
{
	public House()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}
    public string ID { get; set; }
    public string KM { get; set; }
    public string DM { get; set; }
    public string ZM { get; set; }
    public string HNAME { get; set; }
    public string HFUNCTION { get; set; }
    public string  TCRQ { get; set; }
    public string HAREA { get; set; }
    public string HSTRUCTURE { get; set; }

    public string FSFS { get; set; }
    public string WXRQ { get; set; }
    public string WXNR { get; set; }
    public string PICTURE { get; set; }
    public string BZ { get; set; }
    public string CREATEDATE { get; set; }
}
