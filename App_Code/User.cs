using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
///Event 的摘要说明
/// </summary>
public class User
{
    public User()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}
    public string ID { get; set; }
    public string USERNAME { get; set; }
    public string PASSWORD { get; set; }
    public string POSITION { get; set; }
    public string MAJOR { get; set; }
    public string USERLEVEL { get; set; }
    public string DM { get; set; }
    public string PICTURE { get; set; }
   
    public static string Position(string userlevel)
    {
         string position = "";
         switch (int.Parse(userlevel))
        {
            case 0: position = "系统管理员"; break;
            case 1: position = "小队"; break;
            case 2: position = "室主任"; break;
            case 3: position = "矿工艺队"; break;
            case 4: position = "所长"; break;
            case 5: position = "地面矿长"; break;
            case 6: position = "室员工"; break;
            case 7: position = "副主任"; break;
            case 8: position = "图纸管理员"; break;
            case 9: position = "矿计量员"; break; 
            default: break;
        }
        return position;
    }
}
