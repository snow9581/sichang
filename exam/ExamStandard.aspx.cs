using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class exam_ExamStandard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string sql = "select * from T_EXAMSTANDARD where E_MAJOR='" + Convert.ToString(Session["dm"]) + "'";
        DB db = new DB();
        DataTable dt = db.GetDataTable(sql);
        if (dt.Rows.Count > 0)
        {
            X_dif.Value = dt.Rows[0]["E_DIFFICULT"].ToString();
            X_med.Value = dt.Rows[0]["E_MEDIUM"].ToString();
            X_easy.Value = dt.Rows[0]["E_EASY"].ToString();
            P_dif.Value = dt.Rows[0]["E_P_DIFFICULT"].ToString();
            P_med.Value = dt.Rows[0]["E_P_MEDIUM"].ToString();
            P_easy.Value = dt.Rows[0]["E_P_EASY"].ToString();
            X_score.Value = dt.Rows[0]["E_SCORE"].ToString();
            P_score.Value = dt.Rows[0]["E_P_SCORE"].ToString();
            TIME.Value = dt.Rows[0]["E_TIME"].ToString();
            string str_STARTDATE = dt.Rows[0]["E_STARTDATE"].ToString();
            if (str_STARTDATE != "")
                STARTDATE.Value = str_STARTDATE.Substring(0, str_STARTDATE.IndexOf(' '));
            string str_ENDDATE = dt.Rows[0]["E_ENDDATE"].ToString();
            if (str_ENDDATE != "")
                ENDDATE.Value = str_ENDDATE.Substring(0, str_ENDDATE.IndexOf(' '));
            totalScore.Text = ((int.Parse(X_dif.Value) + int.Parse(X_med.Value) + int.Parse(X_easy.Value)) * int.Parse(X_score.Value)+ (int.Parse(P_dif.Value) + int.Parse(P_med.Value) + int.Parse(P_easy.Value))* int.Parse(P_score.Value)).ToString();
        }
        else
            Standard.Value = "1";
    }
}