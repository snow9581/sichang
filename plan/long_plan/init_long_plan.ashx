<%@ WebHandler Language="C#" Class="init_long_plan" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Web.Script.Serialization;
using System.Web.SessionState;

public class init_long_plan : BaseHandler{

    public override void AjaxProcess(HttpContext context)
    {
        string DM = context.Request.Params["dm"];
        string PName = context.Request.Params["PName"];
        string SoluChief = context.Request.Params["SoluChief"].Trim(',') ;
        string SOLUCOMPDATE_P = context.Request.Params["SOLUCOMPDATE_P"];
        string INSTCHECKDATE_P = context.Request.Params["INSTCHECKDATE_P"];
        string FACTCHECKDATE_P = context.Request.Params["FACTCHECKDATE_P"];
        string EstiInvestment = context.Request.Params["EstiInvestment"];
        //if (DM == "规划室")
        //    SoluChief = context.Request.Params["in1"];
        //else
        //    SoluChief = context.Request.Params["in2"];
        DB db = new DB();
        //problem 2
        string sql = "insert into T_PLANRUN_ZCQ(PID,PNAME,SOLUCHIEF,SOLUCOMPDATE_P,INSTCHECKDATE_P,FACTCHECKDATE_P,EstiInvestment,FLAGS,BUFFER)" +
            " values (SEQ_PLANRUN_ZCQ.nextval,'" + T.preHandleSql(PName) + "','" + T.preHandleSql(SoluChief) + "',to_date('" + SOLUCOMPDATE_P + "','yyyy-mm-dd')," +
            "to_date('" + INSTCHECKDATE_P + "','yyyy-mm-dd')," + "to_date('" + FACTCHECKDATE_P + "','yyyy-mm-dd'),'" + T.preHandleSql(EstiInvestment) + "',";
        if (DM == "矿区室")
            sql += "2,";
        else
            sql += "1,";
        //problem 2
        sql += "0)";
        bool flag=db.ExecuteSQL(sql);

        if (flag == true)
        {
            context.Response.Write("1");
        }
        else
        {
            context.Response.Write("0");
        }
    }
//  //型日期转化为--型日期
    public string change_time(string str)
    {
        string year = "";
        string month = "";
        string day = "";
        int type = 1;
        for (int i = 0; i < str.Length; i++)
        {
            if (type == 1 && str[i] != '/')
                year += str[i];
            if (type == 2 && str[i] != '/')
                month += str[i];
            if (type == 3 && str[i] != '/')
                day += str[i];
            if (str[i] == '/')
                type++;
            if (str[i] == ' ')
                break;
        }
        if (month.Length == 1)
            month = "0" + month;
        if (day.Length == 1)
            day = "0" + day;
        return year + "-" + month + "-" + day;
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}