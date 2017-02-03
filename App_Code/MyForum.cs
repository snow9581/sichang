using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
///MyForum 的摘要说明
/// </summary>
public class MyForum
{
    public MyForum()
    {
    }
    public string GetTableHtml()
    {
        string[] s1 = new string[] { "111", "222" };
        string[] s2 = new string[] { "111", "222" };
        string InnerHtml = "<table class=\"MyTable\">";
        for (int i = 0; i < s1.Length; i++)
        {
            InnerHtml += "<td><a href=\"#\" class=\"Mya\" onclick=\"TableClick(" + s2 + ")\">";
            InnerHtml += s1[i];
            InnerHtml += "</a></td>";
        }
        InnerHtml += "</table>";
        return InnerHtml;
    }
    public string GetAllAreaHtml()
    {
        string InnerHtml = "";
        return InnerHtml;
    }
}