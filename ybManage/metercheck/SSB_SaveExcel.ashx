<%@ WebHandler Language="C#" Class="SSB_SaveExcel" %>

using System;
using System.Web;
using Microsoft.Office.Interop;
using Microsoft.Office.Interop.Excel;
using System.Diagnostics;

public class SSB_SaveExcel : BaseHandler{

    override public void AjaxProcess(HttpContext context)
    {
        try {            
            string fromid = context.Request.Params["FROMID"].ToString();
            DB db = new DB();
            System.Data.DataTable dt_check = db.GetDataTable("select BM from T_METER_CHECK where ID='" + fromid + "'");
            string title="未找到标题";
            if(dt_check.Rows.Count>0) title=dt_check.Rows[0]["BM"].ToString();
            
            System.Data.DataTable dt = db.GetDataTable("select * from T_METER_CHECK_SBB where FROMID='" + fromid + "'");
            
            string fpath = context.Server.MapPath("./sbb.xls");//获取申报表目录的绝对路径
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
                worksheet.get_Range(worksheet.Cells[1, 1], worksheet.Cells[1, 12]).Value2 = title;
                //插入数据
                int i;
                for ( i= 0; i < dt.Rows.Count; i++)
                {
                    worksheet.get_Range(worksheet.Cells[4+i, 1], worksheet.Cells[4+i, 1]).Value2 = i + 1;                   
                    worksheet.get_Range(worksheet.Cells[4+i, 2], worksheet.Cells[4+i, 2]).Value2 =dt.Rows[i]["JLQJMC"];
                    worksheet.get_Range(worksheet.Cells[4+i, 3], worksheet.Cells[4+i, 3]).Value2 =dt.Rows[i]["GGXH"];
                    worksheet.get_Range(worksheet.Cells[4+i, 4], worksheet.Cells[4+i, 4]).Value2 =dt.Rows[i]["JLLB"];
                    worksheet.get_Range(worksheet.Cells[4+i, 5], worksheet.Cells[4+i, 5]).Value2 =dt.Rows[i]["JDZQ"];
                    worksheet.get_Range(worksheet.Cells[4+i, 6], worksheet.Cells[4+i, 6]).Value2 =dt.Rows[i]["JDDJ"];
                    worksheet.get_Range(worksheet.Cells[4+i, 7], worksheet.Cells[4+i, 7]).Value2 =dt.Rows[i]["SL"];
                    worksheet.get_Range(worksheet.Cells[4+i, 8], worksheet.Cells[4+i, 8]).Value2 =dt.Rows[i]["JDRQ"];
                    worksheet.get_Range(worksheet.Cells[4+i, 9], worksheet.Cells[4+i, 9]).Value2 =dt.Rows[i]["SYDW"];
                    worksheet.get_Range(worksheet.Cells[4+i, 10], worksheet.Cells[4+i, 10]).Value2 =dt.Rows[i]["JDDW"];
                    worksheet.get_Range(worksheet.Cells[4+i, 11], worksheet.Cells[4+i, 11]).Value2 =dt.Rows[i]["JDFS"];
                    worksheet.get_Range(worksheet.Cells[4 + i, 12], worksheet.Cells[4 + i, 12]).Value2 = dt.Rows[i]["E_JDDJ"];
                    worksheet.get_Range(worksheet.Cells[4 + i, 13], worksheet.Cells[4 + i, 13]).Value2 = dt.Rows[i]["E_JDFYHJ"];
                    worksheet.get_Range(worksheet.Cells[4+i, 14], worksheet.Cells[4+i, 14]).Value2 = dt.Rows[i]["SM"];                    
                }

                for (; i < 20; i++)
                {
                    worksheet.get_Range(worksheet.Cells[4 + i, 1], worksheet.Cells[4 + i, 1]).Value2 = "";
                    worksheet.get_Range(worksheet.Cells[4 + i, 2], worksheet.Cells[4 + i, 2]).Value2 = "";
                    worksheet.get_Range(worksheet.Cells[4 + i, 3], worksheet.Cells[4 + i, 3]).Value2 = "";
                    worksheet.get_Range(worksheet.Cells[4 + i, 4], worksheet.Cells[4 + i, 4]).Value2 = "";
                    worksheet.get_Range(worksheet.Cells[4 + i, 5], worksheet.Cells[4 + i, 5]).Value2 = "";
                    worksheet.get_Range(worksheet.Cells[4 + i, 6], worksheet.Cells[4 + i, 6]).Value2 = "";
                    worksheet.get_Range(worksheet.Cells[4 + i, 7], worksheet.Cells[4 + i, 7]).Value2 = "";
                    worksheet.get_Range(worksheet.Cells[4 + i, 8], worksheet.Cells[4 + i, 8]).Value2 = "";
                    worksheet.get_Range(worksheet.Cells[4 + i, 9], worksheet.Cells[4 + i, 9]).Value2 = "";
                    worksheet.get_Range(worksheet.Cells[4 + i, 10], worksheet.Cells[4 + i, 10]).Value2 = "";
                    worksheet.get_Range(worksheet.Cells[4 + i, 11], worksheet.Cells[4 + i, 11]).Value2 = "";
                    worksheet.get_Range(worksheet.Cells[4 + i, 12], worksheet.Cells[4 + i, 12]).Value2 = "";
                    worksheet.get_Range(worksheet.Cells[4 + i, 13], worksheet.Cells[4 + i, 13]).Value2 = "";
                    worksheet.get_Range(worksheet.Cells[4 + i, 14], worksheet.Cells[4 + i, 14]).Value2 = "";
                }
                   
                //添加底部内容。
                worksheet.get_Range(worksheet.Cells[4 + i, 1], worksheet.Cells[4 + i, 1]).Value2 = "填报日期:" + DateTime.Today.ToLongDateString().ToString();
                worksheet.get_Range(worksheet.Cells[4 + i, 7], worksheet.Cells[4 + i, 7]).Value2 = "审核人：";
                worksheet.get_Range(worksheet.Cells[4 + i, 10], worksheet.Cells[4 + i, 10]).Value2 = "批准人：";

                Range bord = worksheet.get_Range(worksheet.Cells[3, 1], worksheet.Cells[i + 3, 12]);
                bord.Borders.LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;//设置边框  

                
                workbook.SaveCopyAs(context.Server.MapPath("sbb_download.xls"));
                context.Response.Write("<script>window.location='sbb_download.xls'</script>");
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