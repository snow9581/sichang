<%@ WebHandler Language="C#" Class="getKM" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;

public class getKM : BaseHandler
{

    public override void AjaxProcess(HttpContext context)
    {
        DB db = new DB();
        string sqlstr = "select km from T_DEPT t where KM like '第%油矿' or KM like '%队' group by km order by AVG(ID)";

        System.Data.DataTable dt = db.GetDataTable(sqlstr); //数据源             
          
        String jsonData = ToJsonCombo(dt);
        context.Response.Write(jsonData);
        context.Response.End();
    }

    #region dataTable转换成Json格式
    /// <summary>      
    /// dataTable转换成Json格式      
    /// </summary>      
    /// <param name="dt"></param>      
    /// <returns></returns>      
    public static string ToJsonCombo(DataTable dt)
    {
        StringBuilder jsonBuilder = new StringBuilder();

        jsonBuilder.Append("[");
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            jsonBuilder.Append("{");
            for (int j = 0; j < dt.Columns.Count; j++)
            {

                jsonBuilder.Append("\"");
                jsonBuilder.Append("text");
                jsonBuilder.Append("\":\"");
                string text = dt.Rows[i][j].ToString();
                jsonBuilder.Append(text);
                jsonBuilder.Append("\"");


            }
            //jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
            jsonBuilder.Append("},");
        }

        jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
        jsonBuilder.Append("]");

        string Json_data = "";
        Json_data = jsonBuilder.ToString();
        return Json_data;

    }

    #endregion dataTable转换成Json格式    

    
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}