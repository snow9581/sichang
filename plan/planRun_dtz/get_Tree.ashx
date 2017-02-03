<%@ WebHandler Language="C#" Class="get_WorkloadTree" %>

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
using System.Collections;

public class get_WorkloadTree : BaseHandler
{
    public override void AjaxProcess(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string pid = context.Request.Params["pid"];
        string pname = context.Request.Params["pname"];
        string pnumber = context.Request.Params["pnumber"];
        string type = context.Request.Params["type"];
        DataTable dt =new DataTable();
        if(type=="wl")
            dt= createWORKLOADSUBMITDT(pid,pname,pnumber);
        else if(type=="fircom")
            dt = createCOMMISSIONFILEDT(pid, pname, pnumber);
        else if (type == "seccom")
            dt = createSECONDCOMMISSIONDATEDT(pid, pname, pnumber);
        else if (type == "blue")
            dt = createBLUEGRAPHDOCUMENT_RDT(pid, pname, pnumber);
        else if (type == "arrivalBlue")
            dt = createBLUEARRIVALDATE(pid, pname, pnumber);
        string jsonData = GetTreeJsonByTable(dt, "module_id", "module_name", "module_url", "module_fatherid", "0"); 
        context.Response.Write(jsonData);
        context.Response.End();
    }
 
    #region 根据DataTable生成EasyUI Tree Json树结构  
    StringBuilder result = new StringBuilder();  
    StringBuilder sb = new StringBuilder();      
    /// <summary>  
    /// 根据DataTable生成EasyUI Tree Json树结构  
    /// </summary>  
    /// <param name="tabel">数据源</param>  
    /// <param name="idCol">ID列</param>  
    /// <param name="txtCol">Text列</param>  
    /// <param name="url">节点Url</param>  
    /// <param name="rela">关系字段</param>  
    /// <param name="pId">父ID</param>  
    private string GetTreeJsonByTable(DataTable tabel, string idCol, string txtCol, string url, string rela, object pId)  
    {  
        result.Append(sb.ToString());  
        sb.Remove(0,sb.Length);  
        if (tabel.Rows.Count > 0)  
        {  
            sb.Append("[");  
            string filer = string.Format("{0}='{1}'", rela, pId);  
            DataRow[] rows = tabel.Select(filer);  
            if (rows.Length > 0)  
            {  
                foreach (DataRow row in rows)  
                {  
                    sb.Append("{\"id\":\"" + row[idCol] + "\",\"text\":\"" + row[txtCol] + "\",\"attributes\":\"" + row[url] + "\",\"state\":\"open\"");  
                    if (tabel.Select(string.Format("{0}='{1}'", rela, row[idCol])).Length > 0)  
                    {  
                        sb.Append(",\"children\":");  
                        GetTreeJsonByTable(tabel, idCol, txtCol,url, rela, row[idCol]);  
                        result.Append(sb.ToString());
                        sb.Remove(0, sb.Length);  
                    }  
                    result.Append(sb.ToString());
                    sb.Remove(0, sb.Length);  
                    sb.Append("},");  
                }  
                sb = sb.Remove(sb.Length - 1, 1);  
            }  
            sb.Append("]");  
            result.Append(sb.ToString());
            sb.Remove(0, sb.Length);  
        }  
        return result.ToString();  
    }  
    #endregion   
 
 
    #region 获取工程量数据
    protected static DataTable createWORKLOADSUBMITDT(string pid,string pname,string pnumber)
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("module_id");
        dt.Columns.Add("module_name");
        dt.Columns.Add("module_fatherid");
        dt.Columns.Add("module_url");
        HashSet<string> hs = new HashSet<string>();
        DB db = new DB();
        string sqlw = "select * from T_WORKLOADSUBMIT where w_pid=" + pid + " order by w_major";
        string QSentence = "";
        if (pnumber != ""&&pnumber!=null)
        {
            QSentence = " and pnumber='" + pnumber + "' ";
        }
        string sqlc = "(select distinct(SENDEE) as name,SENDEEMAJOR as major from T_COMMISSIONINFORMATION  where pname='" + pname + "' " + QSentence + " AND FILETYPE='一次委托资料') "
            + " UNION (select distinct(CONSIGNER) as name,CONSIGNERMAJOR as major from T_COMMISSIONINFORMATION where pname='" + pname + "' " + QSentence + "AND FILETYPE='一次委托资料') order by major";
        DataTable ddw = db.GetDataTable(sqlw);
        DataTable ddc = db.GetDataTable(sqlc);
        ddw.PrimaryKey = new DataColumn[] { ddw.Columns["W_NAME"] };
        dt.Rows.Add("A1", "工程量", "0", "");

        for (int i = 0; i < ddc.Rows.Count; i++)
        {
            string major = ddc.Rows[i]["MAJOR"].ToString();
            string name = ddc.Rows[i]["NAME"].ToString();
            string file="";
            string date = "";
            DataRow dr = ddc.NewRow();
            dr = ddw.Rows.Find(name);
            if (dr != null)
            {
                file = dr["W_FILE"].ToString();
                date = dr["W_DATE"].ToString();
            }
            if (hs.Add(major))
            {
                dt.Rows.Add("B" + hs.Count, major, "A1", "");
                dt.Rows.Add("C" + i, name + "    <a href='../../datasubmit/downloadPic.aspx?picName=" + file + "&package=ftp_planfile'>"+date+"</a>", "B" + hs.Count, "");
            }
            else
            {
                dt.Rows.Add("C" + i, name + "    <a href='../../datasubmit/downloadPic.aspx?picName=" + file + "&package=ftp_planfile'>"+date+"</a>", "B" + hs.Count, "");
            }
        }
        return dt;
    }
    #endregion 获取工程量数据

    #region 获取一次委托数据
    protected static DataTable createCOMMISSIONFILEDT(string pid, string pname, string pnumber)
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("module_id");
        dt.Columns.Add("module_name");
        dt.Columns.Add("module_fatherid");
        dt.Columns.Add("module_url");
        HashSet<string> hs = new HashSet<string>();
        string QSentence = "";
        if (pnumber != "" && pnumber != null)
        {
            QSentence = " and pnumber='" + pnumber + "' ";
        }
        string sql = "select * from T_COMMISSIONINFORMATION where pname='" + pname + "' " + QSentence + " AND FILETYPE='一次委托资料' order by CONSIGNERMAJOR";
        DB db = new DB();
        DataTable dd = db.GetDataTable(sql); //获取当前页的数据
        dt.Rows.Add("A1", "一次委托资料", "0", "");
        for (int i = 0; i < dd.Rows.Count; i++)
        {
            string CONSIGNERMAJOR = dd.Rows[i]["CONSIGNERMAJOR"].ToString();
            string CONSIGNER = dd.Rows[i]["CONSIGNER"].ToString();
            string SENDEEMAJOR = dd.Rows[i]["SENDEEMAJOR"].ToString();
            string SENDEE = dd.Rows[i]["SENDEE"].ToString();
            string file = dd.Rows[i]["FILES"].ToString();
            string date = dd.Rows[i]["RELEASERQ"].ToString();
            if (hs.Add(CONSIGNERMAJOR))
            {
                dt.Rows.Add("B" + hs.Count, CONSIGNERMAJOR, "A1", "");
                dt.Rows.Add("C" + i, CONSIGNER + "-->" + SENDEEMAJOR + "    " + SENDEE + "     <a href='../../datasubmit/downloadPic.aspx?picName=" + file + "&package=archives'>" + date + "</a>", "B" + hs.Count, "");
            }
            else
            {
                dt.Rows.Add("C" + i, CONSIGNER + "-->" + SENDEEMAJOR + "    " + SENDEE + "     <a href='../../datasubmit/downloadPic.aspx?picName=" + file + "&package=archives'>" + date + "</a>", "B" + hs.Count, "");
            }
        }
        return dt;
    }
    #endregion 获取一次委托数据

    #region 获取二次委托数据
    protected static DataTable createSECONDCOMMISSIONDATEDT(string pid, string pname, string pnumber)
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("module_id");
        dt.Columns.Add("module_name");
        dt.Columns.Add("module_fatherid");
        dt.Columns.Add("module_url");
        HashSet<string> hs = new HashSet<string>();
        string QSentence = "";
        if (pnumber != "" && pnumber != null)
        {
            QSentence = " and PNUMBER='" + pnumber + "' ";
        }
        string sqlw = "select * from T_COMMISSIONINFORMATION where PNAME='" + pname + "' "+QSentence+" AND FILETYPE='二次委托资料' order by CONSIGNERMAJOR";
        string sqlc = "select * from T_WORKLOADSUBMIT where w_pid=" + pid + " order by w_major";
        DB db = new DB();
        DataTable ddw = db.GetDataTable(sqlw);
        DataTable ddc = db.GetDataTable(sqlc);
        dt.Rows.Add("A1", "二次委托资料", "0", "");
        for (int i = 0; i < ddc.Rows.Count; i++)
        {
            string CONSIGNERMAJOR = ddc.Rows[i]["W_MAJOR"].ToString();
            string CONSIGNER = ddc.Rows[i]["W_NAME"].ToString();
            string SENDEEMAJOR = "";
            string SENDEE = "";
            string file = "";
            string date = "";
            DataRow[] dr = ddw.Select("CONSIGNER='" + CONSIGNER + "'");
            for (int j = 0; j < dr.Length; j++)
            {
                if (dr[j] != null)
                {
                    file = dr[j]["FILES"].ToString();
                    date = dr[j]["RELEASERQ"].ToString();
                    SENDEEMAJOR = "-->" + dr[j]["SENDEEMAJOR"].ToString();
                    SENDEE = dr[j]["SENDEE"].ToString();
                }
                if (hs.Add(CONSIGNERMAJOR))
                {
                    dt.Rows.Add("B" + hs.Count, CONSIGNERMAJOR, "A1", "");
                    dt.Rows.Add("C" + i, CONSIGNER + SENDEEMAJOR + "    " + SENDEE + "     <a href='../../datasubmit/downloadPic.aspx?picName=" + file + "&package=archives'>" + date + "</a>", "B" + hs.Count, "");
                }
                else
                {
                    dt.Rows.Add("C" + i, CONSIGNER + SENDEEMAJOR + "    " + SENDEE + "     <a href='../../datasubmit/downloadPic.aspx?picName=" + file + "&package=archives'>" + date + "</a>", "B" + hs.Count, "");
                }
            }
            if (dr.Length == 0)
            {
                if (hs.Add(CONSIGNERMAJOR))
                {
                    dt.Rows.Add("B" + hs.Count, CONSIGNERMAJOR, "A1", "");
                    dt.Rows.Add("C" + i, CONSIGNER + SENDEEMAJOR + "    " + SENDEE + "     <a href='../../datasubmit/downloadPic.aspx?picName=" + file + "&package=archives'>" + date + "</a>", "B" + hs.Count, "");
                }
                else
                {
                    dt.Rows.Add("C" + i, CONSIGNER + SENDEEMAJOR + "    " + SENDEE + "     <a href='../../datasubmit/downloadPic.aspx?picName=" + file + "&package=archives'>" + date + "</a>", "B" + hs.Count, "");
                }
            }
        }
        return dt;
    }
    #endregion 获取二次委托数据

    #region 蓝图
    protected static DataTable createBLUEGRAPHDOCUMENT_RDT(string pid, string pname, string pnumber)
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("module_id");
        dt.Columns.Add("module_name");
        dt.Columns.Add("module_fatherid");
        dt.Columns.Add("module_url");
        HashSet<string> hs = new HashSet<string>();
        string sqlc = "select * from T_WORKLOADSUBMIT where w_pid=" + pid + " order by w_major";
        string sqlw = "select * from T_CONSTRUCTION where PNAME='" + pname + "' order by DESIGNSPECIAL";
        DB db = new DB();
        DataTable ddc = db.GetDataTable(sqlc);
        DataTable ddw = db.GetDataTable(sqlw);
        ddw.PrimaryKey = new DataColumn[] { ddw.Columns["SPECIALPERSON"] };
        dt.Rows.Add("A1", "蓝图", "0", "");
        for (int i = 0; i < ddc.Rows.Count; i++)
        {
            string MAJOR = ddc.Rows[i]["W_MAJOR"].ToString();
            string NAME = ddc.Rows[i]["W_NAME"].ToString();
            string file = "";
            string date = "";
            DataRow dr = ddw.NewRow();
            dr = ddw.Rows.Find(NAME);
            if (dr != null)
            {
                file = dr["FILES"].ToString();
                date = dr["DESIGNRQ"].ToString();
            }
            if (hs.Add(MAJOR))
            {
                dt.Rows.Add("B" + hs.Count, MAJOR, "A1", "");
                dt.Rows.Add("C" + i, NAME + "     <a href='../../datasubmit/downloadPic.aspx?picName=" + file + "&package=archives'>" + date + "</a>", "B" + hs.Count, "");
            }
            else
            {
                dt.Rows.Add("C" + i, NAME + "     <a href='../../datasubmit/downloadPic.aspx?picName=" + file + "&package=archives'>" + date + "</a>", "B" + hs.Count, "");
            }
        }
        return dt;
    }
    #endregion 蓝图

    #region 下发蓝图
    protected static DataTable createBLUEARRIVALDATE(string pid, string pname, string pnumber)
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("module_id");
        dt.Columns.Add("module_name");
        dt.Columns.Add("module_fatherid");
        dt.Columns.Add("module_url");
        HashSet<string> hs = new HashSet<string>();
        string sqlw = "select * from T_CONSTRUCTION where PNAME='" + pname + "' order by DESIGNSPECIAL";
        DB db = new DB();

        DataTable ddw = db.GetDataTable(sqlw);

        dt.Rows.Add("A1", "下发蓝图", "0", "");
        for (int i = 0; i < ddw.Rows.Count; i++)
        {
            string major = ddw.Rows[i]["DESIGNSPECIAL"].ToString();
            string name = ddw.Rows[i]["SPECIALPERSON"].ToString();
            string file = ddw.Rows[i]["FILES"].ToString();
            string date = ddw.Rows[i]["ARRIVALDATE"].ToString();
            date = date == "" ? date : Convert.ToDateTime(date).ToShortDateString();
            if (hs.Add(major))
            {
                dt.Rows.Add("B" + hs.Count, major, "A1", "");
                dt.Rows.Add("C" + i, name + "     <a href='../../datasubmit/downloadPic.aspx?picName=" + file + "&package=archives'>" + date + "</a>", "B" + hs.Count, "");
            }
            else
            {
                dt.Rows.Add("C" + i, name + "     <a href='../../datasubmit/downloadPic.aspx?picName=" + file + "&package=archives'>" + date + "</a>", "B" + hs.Count, "");
            }
        }
        return dt;
    }
    #endregion 下发蓝图

    public bool IsReusable {
        get {
            return false;
        }
    }

}