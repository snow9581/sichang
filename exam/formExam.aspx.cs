using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class exam_formExam : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string flag = Request.Params["Flag"];
        HDflag.Value = flag;
        if(flag=="1")//修改，绑定数据
        {
            string id = Request.Params["E_ID"];
            string sql = "select * from T_EXAM where E_ID="+id;
            DB db = new DB();
            DataTable dt = db.GetDataTable(sql);
            if (dt.Rows.Count > 0)
            {
                E_TITLE.Value = dt.Rows[0]["E_TITLE"].ToString();
                E_TYPE.Value = dt.Rows[0]["E_TYPE"].ToString();
                if (dt.Rows[0]["E_TYPE"].ToString()=="选择")
                    E_X_ANSWER.Value = dt.Rows[0]["E_ANSWER"].ToString();
                else
                    E_P_ANSWER.Value = dt.Rows[0]["E_ANSWER"].ToString();
                E_LEVEL.Value = dt.Rows[0]["E_LEVEL"].ToString();
            }
            else
                Response.Write("<script type='text/javascript'>alter(未获取到数据！);</script>");
        } 
    }
}