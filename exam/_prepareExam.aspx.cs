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

public partial class exam_prepareExam : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string name = Convert.ToString(Session["username"]);
        string dm = Convert.ToString(Session["dm"]); 
        username.Text = name;
        major.Text = dm;
        string sqlStandard = "select * from T_EXAMSTANDARD where E_MAJOR='" + dm + "'";
        DB db = new DB();
        DataTable dd = db.GetDataTable(sqlStandard);
        if (dd.Rows.Count > 0)
        {
            time.Text = dd.Rows[0]["E_TIME"].ToString();
            string str_STARTDATE = dd.Rows[0]["E_STARTDATE"].ToString();
            if (str_STARTDATE != "")
                startTime.Text = str_STARTDATE.Substring(0, str_STARTDATE.IndexOf(' '));
            string str_ENDDATE = dd.Rows[0]["E_ENDDATE"].ToString();
            if (str_ENDDATE != "")
                endTime.Text = str_ENDDATE.Substring(0, str_ENDDATE.IndexOf(' '));
            DateTime nowdate = DateTime.Now;
            if (nowdate <= DateTime.Parse(startTime.Text))
            {
                HDvisible.Value = "考试未开始!";
            }
            else if (nowdate >= DateTime.Parse(endTime.Text))
            {
                HDvisible.Value = "考试已结束!";
            }
            else
            {
                string sqlstrX = "select  * FROM (select  * FROM T_EXAM where E_MAJOR='" + dm + "' and E_TYPE='选择' and E_LEVEL='难' order by dbms_random.random)where rownum <=" + dd.Rows[0]["E_DIFFICULT"].ToString() + " union  all " +
                        "select  * FROM (select  * FROM T_EXAM where E_MAJOR='" + dm + "' and E_TYPE='选择' and E_LEVEL='中等' order by dbms_random.random)where rownum <=" + dd.Rows[0]["E_MEDIUM"].ToString() + " union  all " +
                        "select  * FROM (select  * FROM T_EXAM where E_MAJOR='" + dm + "' and E_TYPE='选择' and E_LEVEL='简单' order by dbms_random.random)where rownum <=" + dd.Rows[0]["E_EASY"].ToString();
                int countX = int.Parse(dd.Rows[0]["E_DIFFICULT"].ToString()) + int.Parse(dd.Rows[0]["E_MEDIUM"].ToString()) + int.Parse(dd.Rows[0]["E_EASY"].ToString());

                string sqlstrP = "select  * FROM (select  * FROM T_EXAM where E_MAJOR='" + dm + "' and E_TYPE='判断' and E_LEVEL='难' order by dbms_random.random)where rownum <=" + dd.Rows[0]["E_P_DIFFICULT"].ToString() + " union  all " +
                            "select  * FROM (select  * FROM T_EXAM where E_MAJOR='" + dm + "' and E_TYPE='判断' and E_LEVEL='中等' order by dbms_random.random)where rownum <=" + dd.Rows[0]["E_P_MEDIUM"].ToString() + " union  all " +
                            "select  * FROM (select  * FROM T_EXAM where E_MAJOR='" + dm + "' and E_TYPE='判断' and E_LEVEL='简单' order by dbms_random.random)where rownum <=" + dd.Rows[0]["E_P_EASY"].ToString();
                int countP = int.Parse(dd.Rows[0]["E_P_DIFFICULT"].ToString()) + int.Parse(dd.Rows[0]["E_P_MEDIUM"].ToString()) + int.Parse(dd.Rows[0]["E_P_EASY"].ToString());
            
                DataTable dtX = db.GetDataTable(sqlstrX); 
                DataTable dtP = db.GetDataTable(sqlstrP); 
                if ((dtX.Rows.Count == countX && countX != 0)&&(dtP.Rows.Count == countP && countP != 0))
                {
                    CountX.Text = countX.ToString();
                    ScoreX.Text = dd.Rows[0]["E_SCORE"].ToString();
                    CountP.Text = countP.ToString();
                    ScoreP.Text = dd.Rows[0]["E_P_SCORE"].ToString();
                    totalScore.Text = (countX * int.Parse(dd.Rows[0]["E_SCORE"].ToString())) + (countP * int.Parse(dd.Rows[0]["E_P_SCORE"].ToString())).ToString();
                    HDvisible.Value = "1";
                }
                else
                    HDvisible.Value = "题库未完成！";
            }
        }
        else
            HDvisible.Value = "当前没有考试计划!";

        
    }
}











