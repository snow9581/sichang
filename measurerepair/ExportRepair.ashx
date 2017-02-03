<%@ WebHandler Language="C#" Class="ExportRepair" %>

using System;
using System.Web;
using Microsoft.Office.Interop;
using Microsoft.Office.Interop.Excel;
using System.Diagnostics;
using System.Data;

public class ExportRepair : BaseHandler{

    override public void AjaxProcess(HttpContext context)
    {
        try
        {
            DB db = new DB();
            string DM = context.Session["DM"].ToString();
            string userlevel = context.Session["userlevel"].ToString();
            string KM = context.Session["KM"].ToString();
            string username = context.Session["username"].ToString();
            
            //获取查询参数
            string dwKM = context.Request.Params["KM"];//发起维修请求的小队所属的矿名
            string KSRQ = context.Request.Params["KSRQ"];
            string JSRQ = context.Request.Params["JSRQ"];
            
            //构造查询SQL语句
            string QSentence = "";  //定义一个查询子句，当有一个或多个条件不为空时，使用该子句，此查询条件只有仪表室主任可用。

            if (dwKM != null && dwKM != "")
            {
                QSentence = QSentence + " and  d.km like '%" + T.preHandleSql(dwKM) + "%')";
            }
            if (KSRQ != null && KSRQ != "")
            {
                QSentence = QSentence + " and r.rq >= to_date('" + KSRQ + "','yyyy-mm-dd')";
            }
            if (JSRQ != null && JSRQ != "")
            {
                QSentence = QSentence + " and r.rq <= to_date('" + JSRQ + "','yyyy-mm-dd')";
            }

            string sql="";

            if (userlevel == "2" && DM == "仪表室")
            {
                sql = "select d.km, r.dw,r.gw,r.cpuxh,r.xtlx,r.gzxx,r.wxnr,r.wxjg,TO_CHAR(r.rq,'YYYY-MM-DD') from t_measure_repair r, t_dept d where d.dm=r.dw";
                if (QSentence != "") sql = sql + QSentence;
            }
            //执行SQL查询。
            System.Data.DataTable dt = db.GetDataTable(sql); //数据源

            if (!(dt.Rows.Count > 0))
            {
                context.Response.Write("<script>alert('当前没有工作量需要导出！')</script>");
                return;
            }
            
            string fpath = context.Server.MapPath("REPAIR.xls");//获取维修工作量导出表目录的绝对路径
            Microsoft.Office.Interop.Excel.ApplicationClass excel = new Microsoft.Office.Interop.Excel.ApplicationClass();
            if (excel == null)
            {
                context.Response.Write("<script>alert('Can't access excel')</script>");
            }
            else
            {
                Microsoft.Office.Interop.Excel.Workbooks workbooks = excel.Workbooks;
                object missing = System.Reflection.Missing.Value;//获取缺少的object类型值
                Microsoft.Office.Interop.Excel.Workbook workbook = workbooks.Open(fpath, missing, true, missing, missing, missing,
             missing, missing, missing, true, missing, missing, missing, missing, missing);
                //定义Worksheet 对象,此对象表示Excel中的一张工作表
                Microsoft.Office.Interop.Excel.Worksheet worksheet = (Microsoft.Office.Interop.Excel.Worksheet)workbook.Worksheets[1];
                worksheet.PageSetup.Orientation = Microsoft.Office.Interop.Excel.XlPageOrientation.xlLandscape;//纸张方向为横幅
                //添加顶部标题
                //worksheet.get_Range(worksheet.Cells[1, 1], worksheet.Cells[1, 12]).Value2 = title;
                //插入数据
                int i;
                for (i = 0; i < dt.Rows.Count; i++)
                {
                    worksheet.get_Range(worksheet.Cells[4 + i, 1], worksheet.Cells[4 + i, 1]).Value2 = i + 1;
                    worksheet.get_Range(worksheet.Cells[4 + i, 2], worksheet.Cells[4 + i, 2]).Value2 = dt.Rows[i][0];
                    worksheet.get_Range(worksheet.Cells[4 + i, 3], worksheet.Cells[4 + i, 3]).Value2 = dt.Rows[i][1];
                    worksheet.get_Range(worksheet.Cells[4 + i, 4], worksheet.Cells[4 + i, 4]).Value2 = dt.Rows[i][2];
                    worksheet.get_Range(worksheet.Cells[4 + i, 5], worksheet.Cells[4 + i, 5]).Value2 = dt.Rows[i][3];
                    worksheet.get_Range(worksheet.Cells[4 + i, 6], worksheet.Cells[4 + i, 6]).Value2 = dt.Rows[i][4];
                    worksheet.get_Range(worksheet.Cells[4 + i, 7], worksheet.Cells[4 + i, 7]).Value2 = dt.Rows[i][5];
                    worksheet.get_Range(worksheet.Cells[4 + i, 8], worksheet.Cells[4 + i, 8]).Value2 = dt.Rows[i][6];
                    worksheet.get_Range(worksheet.Cells[4 + i, 9], worksheet.Cells[4 + i, 9]).Value2 = dt.Rows[i][7];
                    worksheet.get_Range(worksheet.Cells[4 + i, 10], worksheet.Cells[4 + i, 10]).Value2 = dt.Rows[i][8];                 
                }                       
                Range bord = worksheet.get_Range(worksheet.Cells[3, 1], worksheet.Cells[i + 3, 10]);
                bord.Borders.LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;//设置边框  


                workbook.SaveCopyAs(context.Server.MapPath("REPAIR_EXPORT.xls"));
                context.Response.Write("<script>window.location='REPAIR_EXPORT.xls'</script>");
            }

            excel.Quit(); excel = null;
            Process[] procs = Process.GetProcessesByName("excel");

            foreach (Process pro in procs)
            {
                pro.Kill();//没有更好的方法,只有杀掉进程
            }
            GC.Collect();

        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.ToString());
        }
    }

}