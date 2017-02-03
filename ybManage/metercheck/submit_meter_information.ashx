<%@ WebHandler Language="C#" Class="submit" %>
//发起仪表检定时提交仪表信息时执行
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

public class submit : BaseHandler
{

    override public void AjaxProcess(HttpContext context)
    {
        //获得传来的信息
        try
        {
            string Item = System.Web.HttpUtility.UrlDecode(context.Request.Params["Item"].ToString(), System.Text.Encoding.UTF8);
            string[] str = Item.Split(new[] { ',' });
            List<string> JLQJMC = new List<string>();
            List<string> GGXH = new List<string>();
            List<string> JLLB = new List<string>();
            List<string> JDZQ = new List<string>();
            List<string> JDDJ = new List<string>();
            List<string> SL = new List<string>();
            List<string> JDRQ = new List<string>();                                                                                                                                                                    
            List<string> SYDW = new List<string>();
            List<string> JDDW = new List<string>();
            List<string> JDFS = new List<string>();
            List<string> E_JDDJ = new List<string>();
            List<string> E_JDFYHJ = new List<string>();
            List<string> SM = new List<string>();
            int x = 1;
            for (int i = 0; i < str.Length - 1; i++)
            {
                if (x == 1)
                {
                    JLQJMC.Add(str[i]);
                    x++;
                    continue;
                }
                if (x == 2)
                {
                    GGXH.Add(str[i]);
                    x++;
                    continue;
                }
                if (x == 3)
                {
                    JLLB.Add(str[i]);
                    x++;
                    continue;
                }
                if (x == 4)
                {
                    if (str[i] == "")
                        JDZQ.Add("");
                    else
                        JDZQ.Add(str[i]);
                    x++;
                    continue;
                }
                if (x == 5)
                {
                    JDDJ.Add(str[i]);
                    x++;
                    continue;
                }
                if (x == 6)
                {
                    SL.Add(str[i]);
                    x++;
                    continue;
                }
                if (x == 7)
                {
                    JDRQ.Add(str[i]);
                    x++;
                    continue;
                }
                if (x == 8)
                {
                    SYDW.Add(str[i]);
                    x++;
                    continue;
                }
                if (x == 9)
                {
                    JDDW.Add(str[i]);
                    x++;
                    continue;
                }
                if (x == 10)
                {
                    JDFS.Add(str[i]);
                    x++;
                    continue;
                }
                if (x == 11)
                {
                    E_JDDJ.Add(str[i]);
                    x++;
                    continue;
                }
                if (x == 12)
                {
                    E_JDFYHJ.Add(str[i]);
                    x++;
                    continue;
                }
                if (x == 13)
                {
                    SM.Add(str[i]);
                    x = 1;
                    continue;
                }
            }
            //////////////////////////////////////////////////////////////////////////
            DB db = new DB();
            string sql = null;
            string BM = "第四采油厂" + str[str.Length - 1] + "月份外送仪表检定申请表";
            string DEPARTMENT = context.Session["KM"].ToString();
            string STATE = "3";//原来是1，需要在系统中经过两级审核。但与宋主任商议后，认为在管理不允许采用电子申报表的性况下，还是不要在
            //在系统中进行两级审核，直接打印签字比较好。将来若可以实现电子申报表再将STATE改为1。
            string sql_id = "select SEQ_Table.nextval from dual";
            string id = db.GetDataTable(sql_id).Rows[0][0].ToString();
            string FROMID = id;

            string userName = context.Session["username"].ToString();//给外送仪表检定流程增加发起人信息 高俊涛 2016-08-03

            sql = "insert into T_METER_CHECK (STATE,BM,TIME,DEPARTMENT,ID,INITIATOR) values('" + STATE
                + "','" + BM + "',to_date('" + DateTime.Now.ToString("d") + "','yyyy-mm-dd'),'" +
                DEPARTMENT + "'," + id + ",'" + userName + "')";
            db.ExecuteSQL(sql);
            List<string> ids = new List<string>();
            bool result = true;
            for (int i = 0; i < JLQJMC.Count; i++)
            {
                sql_id = "select SEQ_HOUSE.nextval from dual";
                id = db.GetDataTable(sql_id).Rows[0][0].ToString();
                string name = "(";
                string values = "values(";
                if (JLQJMC[i] != "")
                {
                    name += "JLQJMC,";
                    values += "'" + JLQJMC[i] + "',";
                }
                if (GGXH[i] != "")
                {
                    name += "GGXH,";
                    values += "'" + GGXH[i] + "',";
                }
                if (JLLB[i] != "")
                {
                    name += "JLLB,";
                    values += "'" + JLLB[i] + "',";
                }
                if (JDZQ[i] != "")
                {
                    name += "JDZQ,";
                    values += JDZQ[i].ToString() + ",";
                }
                if (JDDJ[i] != "")
                {
                    name += "JDDJ,";
                    values += "'" + JDDJ[i] + "',";
                }
                if (SL[i] != "")
                {
                    name += "SL,";
                    values += SL[i].ToString() + ",";
                }
                if (JDRQ[i] != "")
                {
                    name += "JDRQ,";
                    values += "to_date('" + JDRQ[i] + "','yyyy-mm-dd hh24:mi:ss '),";
                }
                if (SYDW[i] != "")
                {
                    name += "SYDW,";
                    values += "'" + SYDW[i] + "',";
                }
                if (JDDW[i] != "")
                {
                    name += "JDDW,";
                    values += "'" + JDDW[i] + "',";
                }
                if (E_JDDJ[i] != "")
                {
                    name += "E_JDDJ,";
                    values += "'" + E_JDDJ[i] + "',";
                }
                if (E_JDFYHJ[i] != "")
                {
                    name += "E_JDFYHJ,";
                    values += "'" + E_JDFYHJ[i] + "',";
                }
                if (JDFS[i] != "")
                {
                    name += "JDFS,";
                    values += "'" + JDFS[i] + "',";
                }
                if (SM[i] != "")
                {
                    name += "SM,";
                    values += "'" + SM[i] + "',";
                }
                name += "FROMID,";
                values += FROMID + ",";
                name += "ID)";
                values += id + ")";
                sql = "insert into T_METER_CHECK_SBB " + name + " " + values;
                if (db.ExecuteSQL(sql))
                    ids.Add(id);
                else
                {
                    result = false;
                    break;
                }
            }
            if (result)
                context.Response.Write("1");
            else
            {
                for (int i = 0; i < ids.Count; i++)
                    db.ExecuteSQL("delete from T_METER_CHECK_SBB where id=" + ids[i]);
                db.ExecuteSQL("delete from T_METER_CHECK where id=" + FROMID);
                context.Response.Write("0");
            }
            context.Response.End();
        }
        catch (Exception ex) {
            Console.WriteLine(ex.ToString());
        }
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}