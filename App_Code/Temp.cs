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

/// <summary>
///Temp 的摘要说明
/// </summary>
public class Temp
{
	public Temp()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}
    public int ID { get; set; }
    public string TEMPNAME{get;set;}
    public int WIRTESOLUCYCLE{get;set;}
    public int INSTCHECKSOLUCYCLE{get;set;}
    public int FACTCHECKSOLUCYCLE{get;set;}
    public int MAJORDELEGATECYCLE{get;set;}
    public int WORKLOADSUBMITCYCLE{get;set;}
    public int BUDGETCYCLE{get;set;}
    public int INITDESICYCLE{get;set;}
    public int BUDGETADJUSTCYCLE{get;set;}
    public int WHITEGRAPHPROOFCYCLE{get;set;}
    public int BLUEGRAPHSUBMITCYCLE { get; set; }
}
