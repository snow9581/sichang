<%@ WebHandler Language="C#" Class="save_excel" %>

using System;
using System.Web;
using Microsoft.Office.Interop;
using System.Data;
using System.IO;

public class save_excel : BaseHandler
{

    public override void AjaxProcess(HttpContext context)
    {
        int num = Convert.ToInt32(context.Request.Params["length"]);
        string username = context.Request.Params["labelname"];
        string ids = context.Request.Params["Id"];
        string filename = "";
        string[] ide = ids.Split(new char[] { '/' });
        int[] id = new int[ide.Length];
        for (int i = 0; i < ide.Length; i++)
        {
            id[i] = Convert.ToInt32(ide[i]);
        }
        //string P_str_path = "C:\\sichang_haoran\\ybManage\\test\\";
        Microsoft.Office.Interop.Excel.ApplicationClass excel = new Microsoft.Office.Interop.Excel.ApplicationClass();
        Microsoft.Office.Interop.Excel.Workbooks workbooks = excel.Workbooks;
        object missing = System.Reflection.Missing.Value;//获取缺少的object类型值
        Microsoft.Office.Interop.Excel.Workbook workbook = workbooks.Add(missing);

        //定义Worksheet 对象,此对象表示Execel 中的一张工作表
        Microsoft.Office.Interop.Excel.Worksheet worksheet = (Microsoft.Office.Interop.Excel.Worksheet)workbook.Worksheets[1];
        worksheet.PageSetup.Orientation = Microsoft.Office.Interop.Excel.XlPageOrientation.xlLandscape;//纸张方向为横幅
        excel.Application.DisplayAlerts = false;//合并表格无提示
        for (int i = 1; i <= 20 * num; i = i + 20)
        {
            int n = (i - 1) / 20;

            DB db = new DB();            
            string sql_text = "select * from T_METERTEXT,T_METER where T_METERTEXT.T_ID=T_METER.ID and T_METERTEXT.T_ID='" + id[n] + "'";
            DataTable dt_text = new DataTable();
            dt_text = db.GetDataTable(sql_text);
            //string sql_meter = "select * from T_METER where ID='" + id[n] + "'";
            //DataTable dt_meter = new DataTable();
            //dt_meter = db.GetDataTable(sql_meter);
            if (dt_text.Rows[0]["YBMC"].ToString() != "闪光信号报警器")
            {
                #region excel格式设置
                #region 合并单元格
                worksheet.get_Range(worksheet.Cells[i, 1], worksheet.Cells[i, 14]).MergeCells = true;//第一行        
                worksheet.get_Range(worksheet.Cells[i + 1, 1], worksheet.Cells[i + 1, 14]).MergeCells = true;//第二行 左
                worksheet.get_Range(worksheet.Cells[i + 1, 16], worksheet.Cells[i + 1, 27]).MergeCells = true; //第二行 右            
                worksheet.get_Range(worksheet.Cells[i + 2, 2], worksheet.Cells[i + 2, 13]).MergeCells = true;//第三行 左
                worksheet.get_Range(worksheet.Cells[i + 3, 2], worksheet.Cells[i + 3, 13]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 2, 2], worksheet.Cells[i + 3, 2]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 4, 3], worksheet.Cells[i + 4, 12]).MergeCells = true;//5
                worksheet.get_Range(worksheet.Cells[i + 5, 3], worksheet.Cells[i + 5, 12]).MergeCells = true;//6
                worksheet.get_Range(worksheet.Cells[i + 6, 3], worksheet.Cells[i + 6, 12]).MergeCells = true;//7
                worksheet.get_Range(worksheet.Cells[i + 7, 3], worksheet.Cells[i + 7, 12]).MergeCells = true;//8
                worksheet.get_Range(worksheet.Cells[i + 8, 3], worksheet.Cells[i + 8, 12]).MergeCells = true;//9
                worksheet.get_Range(worksheet.Cells[i + 9, 3], worksheet.Cells[i + 9, 12]).MergeCells = true;//10
                worksheet.get_Range(worksheet.Cells[i + 10, 3], worksheet.Cells[i + 10, 12]).MergeCells = true;//11
                worksheet.get_Range(worksheet.Cells[i + 11, 3], worksheet.Cells[i + 11, 7]).MergeCells = true;//12
                worksheet.get_Range(worksheet.Cells[i + 11, 8], worksheet.Cells[i + 11, 12]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 12, 3], worksheet.Cells[i + 12, 7]).MergeCells = true;//13
                worksheet.get_Range(worksheet.Cells[i + 12, 8], worksheet.Cells[i + 12, 12]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 13, 3], worksheet.Cells[i + 13, 7]).MergeCells = true;//14
                worksheet.get_Range(worksheet.Cells[i + 13, 8], worksheet.Cells[i + 13, 12]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 14, 1], worksheet.Cells[i + 14, 2]).MergeCells = true;//15
                worksheet.get_Range(worksheet.Cells[i + 14, 3], worksheet.Cells[i + 14, 4]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 14, 6], worksheet.Cells[i + 14, 7]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 14, 9], worksheet.Cells[i + 14, 10]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 15, 1], worksheet.Cells[i + 15, 2]).MergeCells = true;//16
                worksheet.get_Range(worksheet.Cells[i + 15, 3], worksheet.Cells[i + 15, 4]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 15, 6], worksheet.Cells[i + 15, 7]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 15, 9], worksheet.Cells[i + 15, 10]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 16, 1], worksheet.Cells[i + 16, 2]).MergeCells = true;//17
                worksheet.get_Range(worksheet.Cells[i + 16, 3], worksheet.Cells[i + 16, 4]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 16, 6], worksheet.Cells[i + 16, 7]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 16, 9], worksheet.Cells[i + 16, 10]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 12, 20], worksheet.Cells[i + 12, 25]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 13, 20], worksheet.Cells[i + 13, 25]).MergeCells = true;
                for (int j = i + 5; j < i + 11; j++)
                {
                    worksheet.get_Range(worksheet.Cells[j, 19], worksheet.Cells[j, 20]).MergeCells = true;
                    worksheet.get_Range(worksheet.Cells[j, 23], worksheet.Cells[j, 24]).MergeCells = true;
                }
                worksheet.get_Range(worksheet.Cells[i + 4, 18], worksheet.Cells[i + 5, 18]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 4, 21], worksheet.Cells[i + 4, 22]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 4, 19], worksheet.Cells[i + 4, 20]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 5, 19], worksheet.Cells[i + 5, 20]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 4, 19], worksheet.Cells[i + 5, 19]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 4, 23], worksheet.Cells[i + 4, 25]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 12, 18], worksheet.Cells[i + 12, 19]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 13, 18], worksheet.Cells[i + 13, 19]).MergeCells = true;
                #endregion
                #region 设置行宽高
                worksheet.get_Range(worksheet.Cells[1, 1], worksheet.Cells[1, 1]).ColumnWidth = 2;//a1宽为20px，单位是真实距离，屏幕上用100%
                worksheet.get_Range(worksheet.Cells[1, 2], worksheet.Cells[1, 2]).ColumnWidth = 12;//b1为110px，看表格时测量的像素 左
                worksheet.get_Range(worksheet.Cells[1, 3], worksheet.Cells[1, 11]).ColumnWidth = 2;//c1到k1的宽为20
                worksheet.get_Range(worksheet.Cells[1, 12], worksheet.Cells[1, 12]).ColumnWidth = 7;//l1的宽为70
                worksheet.get_Range(worksheet.Cells[1, 13], worksheet.Cells[1, 14]).ColumnWidth = 2;//m1,n1的宽为20
                worksheet.get_Range(worksheet.Cells[1, 15], worksheet.Cells[1, 15]).ColumnWidth = 14;
                worksheet.get_Range(worksheet.Cells[1, 16], worksheet.Cells[1, 17]).ColumnWidth = 1.5;//右侧的格式
                worksheet.get_Range(worksheet.Cells[1, 18], worksheet.Cells[1, 18]).ColumnWidth = 7.13;
                worksheet.get_Range(worksheet.Cells[1, 19], worksheet.Cells[1, 20]).ColumnWidth = 3;
                worksheet.get_Range(worksheet.Cells[1, 21], worksheet.Cells[1, 22]).ColumnWidth = 7.13;
                worksheet.get_Range(worksheet.Cells[1, 23], worksheet.Cells[1, 24]).ColumnWidth = 3;
                worksheet.get_Range(worksheet.Cells[1, 25], worksheet.Cells[1, 25]).ColumnWidth = 6;
                worksheet.get_Range(worksheet.Cells[1, 26], worksheet.Cells[1, 26]).ColumnWidth = 0;
                worksheet.get_Range(worksheet.Cells[1, 27], worksheet.Cells[1, 28]).ColumnWidth = 1.75;
                worksheet.get_Range(worksheet.Cells[1, 29], worksheet.Cells[1, 29]).ColumnWidth = 0.46;
                worksheet.get_Range(worksheet.Cells[i, 1], worksheet.Cells[i + 1, 1]).RowHeight = 39;//a1，a2的高为50
                worksheet.get_Range(worksheet.Cells[i + 2, 1], worksheet.Cells[i + 3, 1]).RowHeight = 25;//a3到a4的高为30
                worksheet.get_Range(worksheet.Cells[i + 3, 1], worksheet.Cells[i + 13, 1]).RowHeight = 22.5;
                worksheet.get_Range(worksheet.Cells[i + 14, 1], worksheet.Cells[i + 14, 1]).RowHeight = 12.75;//a15的高为20
                worksheet.get_Range(worksheet.Cells[i + 15, 1], worksheet.Cells[i + 16, 1]).RowHeight = 21.75;//a16，a17的高为30
                #endregion
                #region 设置边框
                Microsoft.Office.Interop.Excel.Range bord;
                bord = worksheet.get_Range(worksheet.Cells[i, 1], worksheet.Cells[i + 16, 1]);
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeLeft).LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeLeft).Weight = 3;//Microsoft.Office.Interop.Excel.XlBorderWeight.xlThin;
                bord = worksheet.get_Range(worksheet.Cells[i, 15], worksheet.Cells[i + 16, 15]);
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeLeft).LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlLineStyleNone;
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeLeft).Weight = 3;
                bord = worksheet.get_Range(worksheet.Cells[i, 16], worksheet.Cells[i + 16, 16]);
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeLeft).LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeLeft).Weight = 3;
                bord = worksheet.get_Range(worksheet.Cells[i, 29], worksheet.Cells[i + 16, 29]);
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeLeft).LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeLeft).Weight = 3;
                bord = worksheet.get_Range(worksheet.Cells[i, 1], worksheet.Cells[i, 14]);
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeTop).LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeTop).Weight = 3;
                bord = worksheet.get_Range(worksheet.Cells[i, 16], worksheet.Cells[i, 28]);
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeTop).LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeTop).Weight = 3;
                bord = worksheet.get_Range(worksheet.Cells[i + 17, 1], worksheet.Cells[i + 17, 14]);
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeTop).LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeTop).Weight = 3;
                bord = worksheet.get_Range(worksheet.Cells[i + 17, 16], worksheet.Cells[i + 17, 28]);
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeTop).LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeTop).Weight = 3;
                bord = worksheet.get_Range(worksheet.Cells[i + 4, 18], worksheet.Cells[i + 10, 25]);
                bord.Borders.LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;//设置边框  
                for (int j = i + 4; j < i + 11; j++)
                {
                    bord = worksheet.get_Range(worksheet.Cells[j, 3], worksheet.Cells[j, 12]);
                    bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeBottom).LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;
                    bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeBottom).Weight = 2;
                }
                bord = worksheet.get_Range(worksheet.Cells[i + 11, 8], worksheet.Cells[i + 1, 12]);
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeBottom).LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeBottom).Weight = 2;
                for (int j = i + 12; j < i + 14; j++)
                {
                    bord = worksheet.get_Range(worksheet.Cells[j, 8], worksheet.Cells[j, 12]);
                    bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeBottom).LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;
                    bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeBottom).Weight = 2;
                    bord = worksheet.get_Range(worksheet.Cells[j, 20], worksheet.Cells[j, 25]);
                    bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeBottom).LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;
                    bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeBottom).Weight = 2;
                }
                #endregion
                #region 居中
                for (int k = i; k < 17 + i; k++)
                    for (int j = 1; j < 29; j++)
                    {
                        worksheet.get_Range(worksheet.Cells[k, j], worksheet.Cells[k, j]).Font.Size = "16";
                        worksheet.get_Range(worksheet.Cells[k, j], worksheet.Cells[k, j]).HorizontalAlignment = Microsoft.Office.Interop.Excel.XlHAlign.xlHAlignCenter;//水平居中
                    }
                #endregion
                #endregion
                #region 单元格赋值

                #region 左侧固定数据
                worksheet.get_Range(worksheet.Cells[i + 4, 1], worksheet.Cells[i + 16, 12]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 2, 2], worksheet.Cells[i + 3, 13]).Font.Size = "10";
                worksheet.get_Range(worksheet.Cells[i, 1], worksheet.Cells[i, 14]).Value2 = "第四采油厂规划设计研究所";
                worksheet.get_Range(worksheet.Cells[i, 1], worksheet.Cells[i, 14]).Font.Size = "16";
                worksheet.get_Range(worksheet.Cells[i + 1, 1], worksheet.Cells[i + 1, 14]).Value2 = "检  定  证  书";
                worksheet.get_Range(worksheet.Cells[i + 1, 1], worksheet.Cells[i + 1, 14]).Font.Size = "22";
                worksheet.get_Range(worksheet.Cells[i + 4, 2], worksheet.Cells[i + 4, 2]).Value2 = "送检单位：";
                worksheet.get_Range(worksheet.Cells[i + 4, 2], worksheet.Cells[i + 4, 2]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 5, 2], worksheet.Cells[i + 5, 2]).Value2 = "仪表名称：";
                worksheet.get_Range(worksheet.Cells[i + 5, 2], worksheet.Cells[i + 5, 2]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 6, 2], worksheet.Cells[i + 6, 2]).Value2 = "型号/规格：";
                worksheet.get_Range(worksheet.Cells[i + 6, 2], worksheet.Cells[i + 6, 2]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 7, 2], worksheet.Cells[i + 7, 2]).Value2 = "送检出厂编号：";
                worksheet.get_Range(worksheet.Cells[i + 7, 2], worksheet.Cells[i + 7, 2]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 8, 2], worksheet.Cells[i + 8, 2]).Value2 = "准确度等级：";
                worksheet.get_Range(worksheet.Cells[i + 8, 2], worksheet.Cells[i + 8, 2]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 9, 2], worksheet.Cells[i + 9, 2]).Value2 = "生产厂家：";
                worksheet.get_Range(worksheet.Cells[i + 9, 2], worksheet.Cells[i + 9, 2]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 10, 2], worksheet.Cells[i + 10, 2]).Value2 = "检定结果：";
                worksheet.get_Range(worksheet.Cells[i + 10, 2], worksheet.Cells[i + 10, 2]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 11, 3], worksheet.Cells[i + 11, 7]).Value2 = "主 管：";
                worksheet.get_Range(worksheet.Cells[i + 11, 3], worksheet.Cells[i + 11, 7]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 12, 3], worksheet.Cells[i + 12, 7]).Value2 = "核验员：";
                worksheet.get_Range(worksheet.Cells[i + 12, 3], worksheet.Cells[i + 12, 7]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 13, 3], worksheet.Cells[i + 13, 7]).Value2 = "检定员：";
                worksheet.get_Range(worksheet.Cells[i + 13, 3], worksheet.Cells[i + 13, 7]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 15, 2], worksheet.Cells[i + 15, 2]).Value2 = "准确度等级：";
                worksheet.get_Range(worksheet.Cells[i + 15, 2], worksheet.Cells[i + 15, 2]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 16, 2], worksheet.Cells[i + 16, 2]).Value2 = "准确度等级：";
                worksheet.get_Range(worksheet.Cells[i + 16, 2], worksheet.Cells[i + 16, 2]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 15, 1], worksheet.Cells[i + 15, 2]).Value2 = "检定日期：";
                worksheet.get_Range(worksheet.Cells[i + 15, 1], worksheet.Cells[i + 15, 2]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 16, 1], worksheet.Cells[i + 16, 2]).Value2 = "有效期至：";
                worksheet.get_Range(worksheet.Cells[i + 16, 2], worksheet.Cells[i + 16, 2]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 15, 5], worksheet.Cells[i + 16, 5]).Value2 = "年";
                worksheet.get_Range(worksheet.Cells[i + 15, 6], worksheet.Cells[i + 15, 5]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 15, 8], worksheet.Cells[i + 16, 8]).Value2 = "月";
                worksheet.get_Range(worksheet.Cells[i + 15, 8], worksheet.Cells[i + 16, 8]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 15, 11], worksheet.Cells[i + 16, 11]).Value2 = "日";
                worksheet.get_Range(worksheet.Cells[i + 15, 11], worksheet.Cells[i + 16, 11]).Font.Size = "12";
                #endregion

                #region 数据
                string[] s = new string[4];
                if (dt_text.Rows[0]["TEXTDATE"].ToString() != null && dt_text.Rows[0]["TEXTDATE"].ToString() != "")
                {
                    string textdate = Convert.ToDateTime(dt_text.Rows[0]["TEXTDATE"].ToString()).ToShortDateString();
                    s = textdate.Split(new char[] { '/' });
                }
                string[] v = new string[4];
                if (dt_text.Rows[0]["VALIDDATE"].ToString() != null && dt_text.Rows[0]["VALIDDATE"].ToString() != "")
                {
                    string VALIDDATE = Convert.ToDateTime(dt_text.Rows[0]["VALIDDATE"].ToString()).ToShortDateString();
                    v = VALIDDATE.Split(new char[] { '/' });
                }

                worksheet.get_Range(worksheet.Cells[i + 4, 18], worksheet.Cells[i + 5, 25]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 6, 18], worksheet.Cells[i + 10, 25]).Font.Size = "11";
                worksheet.get_Range(worksheet.Cells[i + 12, 18], worksheet.Cells[i + 13, 18]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 13, 20], worksheet.Cells[i + 13, 25]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 12, 18], worksheet.Cells[i + 13, 25]).Font.Size = "11";
                worksheet.get_Range(worksheet.Cells[i + 2, 2], worksheet.Cells[i + 3, 13]).Value2 = "证书编号:1503030100502001";
                worksheet.get_Range(worksheet.Cells[i + 4, 3], worksheet.Cells[i + 4, 12]).Value2 = dt_text.Rows[0]["COMPANY"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 5, 3], worksheet.Cells[i + 5, 12]).Value2 = dt_text.Rows[0]["YBMC"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 6, 3], worksheet.Cells[i + 6, 12]).Value2 = dt_text.Rows[0]["GGXH"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 7, 3], worksheet.Cells[i + 7, 12]).Value2 = dt_text.Rows[0]["CCBH"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 8, 3], worksheet.Cells[i + 8, 12]).Value2 = dt_text.Rows[0]["ZQDDJ"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 9, 3], worksheet.Cells[i + 9, 12]).Value2 = dt_text.Rows[0]["SCCJ"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 10, 3], worksheet.Cells[i + 10, 12]).Value2 = "合格";//不用读取
                worksheet.get_Range(worksheet.Cells[i + 11, 8], worksheet.Cells[i + 11, 12]).Value2 = dt_text.Rows[0]["COMPETENT"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 12, 8], worksheet.Cells[i + 12, 12]).Value2 = dt_text.Rows[0]["CHECKER"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 13, 8], worksheet.Cells[i + 13, 12]).Value2 = dt_text.Rows[0]["TEXTER"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 15, 3], worksheet.Cells[i + 15, 4]).Value2 = s[0];
                worksheet.get_Range(worksheet.Cells[i + 15, 6], worksheet.Cells[i + 15, 7]).Value2 = s[1];
                worksheet.get_Range(worksheet.Cells[i + 15, 9], worksheet.Cells[i + 15, 10]).Value2 = s[2];
                worksheet.get_Range(worksheet.Cells[i + 16, 3], worksheet.Cells[i + 16, 4]).Value2 = v[0];
                worksheet.get_Range(worksheet.Cells[i + 16, 6], worksheet.Cells[i + 16, 7]).Value2 = v[1];
                worksheet.get_Range(worksheet.Cells[i + 16, 9], worksheet.Cells[i + 16, 10]).Value2 = v[2];

                worksheet.get_Range(worksheet.Cells[i + 4, 18], worksheet.Cells[i + 5, 18]).Value2 = "量程" + "(" + dt_text.Rows[0]["DATA1"].ToString() + ")";
                worksheet.get_Range(worksheet.Cells[i + 4, 18], worksheet.Cells[i + 5, 18]).WrapText = true;
                worksheet.get_Range(worksheet.Cells[i + 4, 19], worksheet.Cells[i + 5, 20]).Value2 = "标准值" + "(" + dt_text.Rows[0]["DATA2"].ToString() + ")";
                worksheet.get_Range(worksheet.Cells[i + 4, 19], worksheet.Cells[i + 5, 20]).WrapText = true;
                worksheet.get_Range(worksheet.Cells[i + 4, 20], worksheet.Cells[i + 4, 21]).Value2 = "指示值" + "(" + dt_text.Rows[0]["DATA3"].ToString() + ")";
                worksheet.get_Range(worksheet.Cells[i + 4, 20], worksheet.Cells[i + 4, 21]).WrapText = true;
                worksheet.get_Range(worksheet.Cells[i + 13, 20], worksheet.Cells[i + 13, 25]).Value2 = "合格";
                worksheet.get_Range(worksheet.Cells[i + 12, 20], worksheet.Cells[i + 12, 25]).Value2 = "'0.00";
                worksheet.get_Range(worksheet.Cells[i + 6, 18], worksheet.Cells[i + 6, 18]).Value2 = dt_text.Rows[0]["DATA9"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 6, 19], worksheet.Cells[i + 6, 20]).Value2 = dt_text.Rows[0]["DATA10"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 6, 21], worksheet.Cells[i + 6, 21]).Value2 = dt_text.Rows[0]["DATA11"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 6, 22], worksheet.Cells[i + 6, 22]).Value2 = dt_text.Rows[0]["DATA12"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 6, 23], worksheet.Cells[i + 6, 24]).Value2 = dt_text.Rows[0]["DATA13"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 6, 25], worksheet.Cells[i + 6, 25]).Value2 = dt_text.Rows[0]["DATA14"].ToString();

                worksheet.get_Range(worksheet.Cells[i + 7, 18], worksheet.Cells[i + 7, 18]).Value2 = dt_text.Rows[0]["DATA15"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 7, 19], worksheet.Cells[i + 7, 20]).Value2 = dt_text.Rows[0]["DATA16"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 7, 21], worksheet.Cells[i + 7, 21]).Value2 = dt_text.Rows[0]["DATA17"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 7, 22], worksheet.Cells[i + 7, 22]).Value2 = dt_text.Rows[0]["DATA18"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 7, 23], worksheet.Cells[i + 7, 24]).Value2 = dt_text.Rows[0]["DATA19"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 7, 25], worksheet.Cells[i + 7, 25]).Value2 = dt_text.Rows[0]["DATA20"].ToString();

                worksheet.get_Range(worksheet.Cells[i + 8, 18], worksheet.Cells[i + 8, 18]).Value2 = dt_text.Rows[0]["DATA21"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 8, 19], worksheet.Cells[i + 8, 20]).Value2 = dt_text.Rows[0]["DATA22"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 8, 21], worksheet.Cells[i + 8, 21]).Value2 = dt_text.Rows[0]["DATA23"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 8, 22], worksheet.Cells[i + 8, 22]).Value2 = dt_text.Rows[0]["DATA24"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 8, 23], worksheet.Cells[i + 8, 24]).Value2 = dt_text.Rows[0]["DATA25"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 8, 25], worksheet.Cells[i + 8, 25]).Value2 = dt_text.Rows[0]["DATA26"].ToString();

                worksheet.get_Range(worksheet.Cells[i + 9, 18], worksheet.Cells[i + 9, 18]).Value2 = dt_text.Rows[0]["DATA27"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 9, 19], worksheet.Cells[i + 9, 20]).Value2 = dt_text.Rows[0]["DATA28"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 9, 21], worksheet.Cells[i + 9, 21]).Value2 = dt_text.Rows[0]["DATA29"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 9, 22], worksheet.Cells[i + 9, 22]).Value2 = dt_text.Rows[0]["DATA30"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 9, 23], worksheet.Cells[i + 9, 24]).Value2 = dt_text.Rows[0]["DATA31"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 9, 25], worksheet.Cells[i + 9, 25]).Value2 = dt_text.Rows[0]["DATA32"].ToString();

                worksheet.get_Range(worksheet.Cells[i + 10, 18], worksheet.Cells[i + 10, 18]).Value2 = dt_text.Rows[0]["DATA33"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 10, 19], worksheet.Cells[i + 10, 20]).Value2 = dt_text.Rows[0]["DATA34"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 10, 21], worksheet.Cells[i + 10, 21]).Value2 = dt_text.Rows[0]["DATA35"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 10, 22], worksheet.Cells[i + 10, 22]).Value2 = dt_text.Rows[0]["DATA36"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 10, 23], worksheet.Cells[i + 10, 24]).Value2 = dt_text.Rows[0]["DATA37"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 10, 25], worksheet.Cells[i + 10, 25]).Value2 = dt_text.Rows[0]["DATA38"].ToString();
                #region 左侧固定数据
                worksheet.get_Range(worksheet.Cells[i + 1, 16], worksheet.Cells[i + 1, 27]).Value2 = "检  定  结  果";
                worksheet.get_Range(worksheet.Cells[i + 1, 16], worksheet.Cells[i + 1, 27]).Font.Size = "22";
                worksheet.get_Range(worksheet.Cells[i + 4, 23], worksheet.Cells[i + 4, 25]).Value2 = "误差";
                worksheet.get_Range(worksheet.Cells[i + 4, 23], worksheet.Cells[i + 4, 25]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 5, 21], worksheet.Cells[i + 5, 21]).Value2 = "上升";
                worksheet.get_Range(worksheet.Cells[i + 5, 21], worksheet.Cells[i + 5, 21]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 5, 22], worksheet.Cells[i + 5, 22]).Value2 = "下降";
                worksheet.get_Range(worksheet.Cells[i + 5, 22], worksheet.Cells[i + 5, 22]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 5, 23], worksheet.Cells[i + 5, 24]).Value2 = "上升";
                worksheet.get_Range(worksheet.Cells[i + 5, 23], worksheet.Cells[i + 5, 24]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 5, 25], worksheet.Cells[i + 5, 25]).Value2 = "下降";
                worksheet.get_Range(worksheet.Cells[i + 5, 25], worksheet.Cells[i + 5, 25]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 12, 18], worksheet.Cells[i + 12, 19]).Value2 = "最大误差：";
                worksheet.get_Range(worksheet.Cells[i + 12, 18], worksheet.Cells[i + 12, 19]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 13, 18], worksheet.Cells[i + 13, 19]).Value2 = "检定结果：";
                worksheet.get_Range(worksheet.Cells[i + 13, 18], worksheet.Cells[i + 13, 19]).Font.Size = "12";
                #endregion
                #endregion
                #endregion
            }
            else
            {
                worksheet.get_Range(worksheet.Cells[i, 1], worksheet.Cells[i, 14]).MergeCells = true;//第一行        
                worksheet.get_Range(worksheet.Cells[i + 1, 1], worksheet.Cells[i + 1, 14]).MergeCells = true;//第二行 左
                worksheet.get_Range(worksheet.Cells[i + 1, 16], worksheet.Cells[i + 1, 27]).MergeCells = true; //第二行 右            
                worksheet.get_Range(worksheet.Cells[i + 2, 2], worksheet.Cells[i + 2, 13]).MergeCells = true;//第三行 左
                worksheet.get_Range(worksheet.Cells[i + 3, 2], worksheet.Cells[i + 3, 13]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 2, 2], worksheet.Cells[i + 3, 2]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 4, 3], worksheet.Cells[i + 4, 12]).MergeCells = true;//5
                worksheet.get_Range(worksheet.Cells[i + 5, 3], worksheet.Cells[i + 5, 12]).MergeCells = true;//6
                worksheet.get_Range(worksheet.Cells[i + 6, 3], worksheet.Cells[i + 6, 12]).MergeCells = true;//7
                worksheet.get_Range(worksheet.Cells[i + 7, 3], worksheet.Cells[i + 7, 12]).MergeCells = true;//8
                worksheet.get_Range(worksheet.Cells[i + 8, 3], worksheet.Cells[i + 8, 12]).MergeCells = true;//9
                worksheet.get_Range(worksheet.Cells[i + 9, 3], worksheet.Cells[i + 9, 12]).MergeCells = true;//10
                worksheet.get_Range(worksheet.Cells[i + 10, 3], worksheet.Cells[i + 10, 12]).MergeCells = true;//11
                worksheet.get_Range(worksheet.Cells[i + 11, 3], worksheet.Cells[i + 11, 7]).MergeCells = true;//12
                worksheet.get_Range(worksheet.Cells[i + 11, 8], worksheet.Cells[i + 11, 12]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 12, 3], worksheet.Cells[i + 12, 7]).MergeCells = true;//13
                worksheet.get_Range(worksheet.Cells[i + 12, 8], worksheet.Cells[i + 12, 12]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 13, 3], worksheet.Cells[i + 13, 7]).MergeCells = true;//14
                worksheet.get_Range(worksheet.Cells[i + 13, 8], worksheet.Cells[i + 13, 12]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 14, 1], worksheet.Cells[i + 14, 2]).MergeCells = true;//15
                worksheet.get_Range(worksheet.Cells[i + 14, 3], worksheet.Cells[i + 14, 4]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 14, 6], worksheet.Cells[i + 14, 7]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 14, 9], worksheet.Cells[i + 14, 10]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 15, 1], worksheet.Cells[i + 15, 2]).MergeCells = true;//16
                worksheet.get_Range(worksheet.Cells[i + 15, 3], worksheet.Cells[i + 15, 4]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 15, 6], worksheet.Cells[i + 15, 7]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 15, 9], worksheet.Cells[i + 15, 10]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 16, 1], worksheet.Cells[i + 16, 2]).MergeCells = true;//17
                worksheet.get_Range(worksheet.Cells[i + 16, 3], worksheet.Cells[i + 16, 4]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 16, 6], worksheet.Cells[i + 16, 7]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 16, 9], worksheet.Cells[i + 16, 10]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 4, 18], worksheet.Cells[i + 4, 25]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 5, 18], worksheet.Cells[i + 5, 25]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 6, 18], worksheet.Cells[i + 6, 25]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 7, 18], worksheet.Cells[i + 7, 25]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 4, 18], worksheet.Cells[i + 7, 18]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 10, 20], worksheet.Cells[i + 10, 23]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 11, 20], worksheet.Cells[i + 11, 23]).MergeCells = true;
                worksheet.get_Range(worksheet.Cells[i + 10, 20], worksheet.Cells[i + 11, 20]).MergeCells = true;

                worksheet.get_Range(worksheet.Cells[1, 1], worksheet.Cells[1, 1]).ColumnWidth = 2;//a1宽为20px，单位是真实距离，屏幕上用100%
                worksheet.get_Range(worksheet.Cells[1, 2], worksheet.Cells[1, 2]).ColumnWidth = 12;//b1为110px，看表格时测量的像素 左
                worksheet.get_Range(worksheet.Cells[1, 3], worksheet.Cells[1, 11]).ColumnWidth = 2;//c1到k1的宽为20
                worksheet.get_Range(worksheet.Cells[1, 12], worksheet.Cells[1, 12]).ColumnWidth = 7;//l1的宽为70
                worksheet.get_Range(worksheet.Cells[1, 13], worksheet.Cells[1, 14]).ColumnWidth = 2;//m1,n1的宽为20
                worksheet.get_Range(worksheet.Cells[1, 15], worksheet.Cells[1, 15]).ColumnWidth = 14;
                worksheet.get_Range(worksheet.Cells[1, 16], worksheet.Cells[1, 17]).ColumnWidth = 1.5;//右侧的格式
                worksheet.get_Range(worksheet.Cells[1, 18], worksheet.Cells[1, 18]).ColumnWidth = 7.13;
                worksheet.get_Range(worksheet.Cells[1, 19], worksheet.Cells[1, 20]).ColumnWidth = 3;
                worksheet.get_Range(worksheet.Cells[1, 21], worksheet.Cells[1, 22]).ColumnWidth = 7.13;
                worksheet.get_Range(worksheet.Cells[1, 23], worksheet.Cells[1, 24]).ColumnWidth = 3;
                worksheet.get_Range(worksheet.Cells[1, 25], worksheet.Cells[1, 25]).ColumnWidth = 6;
                worksheet.get_Range(worksheet.Cells[1, 26], worksheet.Cells[1, 26]).ColumnWidth = 0;
                worksheet.get_Range(worksheet.Cells[1, 27], worksheet.Cells[1, 28]).ColumnWidth = 1.75;
                worksheet.get_Range(worksheet.Cells[1, 29], worksheet.Cells[1, 29]).ColumnWidth = 0.46;
                worksheet.get_Range(worksheet.Cells[i, 1], worksheet.Cells[i + 1, 1]).RowHeight = 39;//a1，a2的高为50
                worksheet.get_Range(worksheet.Cells[i + 2, 1], worksheet.Cells[i + 3, 1]).RowHeight = 25;//a3到a4的高为30
                worksheet.get_Range(worksheet.Cells[i + 3, 1], worksheet.Cells[i + 13, 1]).RowHeight = 22.5;
                worksheet.get_Range(worksheet.Cells[i + 14, 1], worksheet.Cells[i + 14, 1]).RowHeight = 12.75;//a15的高为20
                worksheet.get_Range(worksheet.Cells[i + 15, 1], worksheet.Cells[i + 16, 1]).RowHeight = 21.75;//a16，a17的高为30

                Microsoft.Office.Interop.Excel.Range bord;
                bord = worksheet.get_Range(worksheet.Cells[i, 1], worksheet.Cells[i + 16, 1]);
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeLeft).LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeLeft).Weight = 3;//Microsoft.Office.Interop.Excel.XlBorderWeight.xlThin;
                bord = worksheet.get_Range(worksheet.Cells[i, 15], worksheet.Cells[i + 16, 15]);
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeLeft).LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlLineStyleNone;
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeLeft).Weight = 3;
                bord = worksheet.get_Range(worksheet.Cells[i, 16], worksheet.Cells[i + 16, 16]);
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeLeft).LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeLeft).Weight = 3;
                bord = worksheet.get_Range(worksheet.Cells[i, 29], worksheet.Cells[i + 16, 29]);
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeLeft).LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeLeft).Weight = 3;
                bord = worksheet.get_Range(worksheet.Cells[i, 1], worksheet.Cells[i, 14]);
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeTop).LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeTop).Weight = 3;
                bord = worksheet.get_Range(worksheet.Cells[i, 16], worksheet.Cells[i, 28]);
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeTop).LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeTop).Weight = 3;
                bord = worksheet.get_Range(worksheet.Cells[i + 17, 1], worksheet.Cells[i + 17, 14]);
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeTop).LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeTop).Weight = 3;
                bord = worksheet.get_Range(worksheet.Cells[i + 17, 16], worksheet.Cells[i + 17, 28]);
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeTop).LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeTop).Weight = 3;

                for (int j = i + 4; j < i + 11; j++)
                {
                    bord = worksheet.get_Range(worksheet.Cells[j, 3], worksheet.Cells[j, 12]);
                    bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeBottom).LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;
                    bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeBottom).Weight = 2;
                }
                bord = worksheet.get_Range(worksheet.Cells[i + 11, 8], worksheet.Cells[i + 1, 12]);
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeBottom).LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;
                bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeBottom).Weight = 2;
                for (int j = i + 12; j < i + 14; j++)
                {
                    bord = worksheet.get_Range(worksheet.Cells[j, 8], worksheet.Cells[j, 12]);
                    bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeBottom).LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;
                    bord.Borders.get_Item(Microsoft.Office.Interop.Excel.XlBordersIndex.xlEdgeBottom).Weight = 2;
                }
                for (int k = i; k < 17 + i; k++)
                    for (int j = 1; j < 29; j++)
                    {
                        worksheet.get_Range(worksheet.Cells[k, j], worksheet.Cells[k, j]).Font.Size = "16";
                        worksheet.get_Range(worksheet.Cells[k, j], worksheet.Cells[k, j]).HorizontalAlignment = Microsoft.Office.Interop.Excel.XlHAlign.xlHAlignCenter;//水平居中
                    }
                worksheet.get_Range(worksheet.Cells[i + 4, 1], worksheet.Cells[i + 16, 12]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 2, 2], worksheet.Cells[i + 3, 13]).Font.Size = "10";
                worksheet.get_Range(worksheet.Cells[i, 1], worksheet.Cells[i, 14]).Value2 = "第四采油厂规划设计研究所";
                worksheet.get_Range(worksheet.Cells[i, 1], worksheet.Cells[i, 14]).Font.Size = "16";
                worksheet.get_Range(worksheet.Cells[i + 1, 1], worksheet.Cells[i + 1, 14]).Value2 = "检  定  证  书";
                worksheet.get_Range(worksheet.Cells[i + 1, 1], worksheet.Cells[i + 1, 14]).Font.Size = "22";
                worksheet.get_Range(worksheet.Cells[i + 4, 2], worksheet.Cells[i + 4, 2]).Value2 = "送检单位：";
                worksheet.get_Range(worksheet.Cells[i + 4, 2], worksheet.Cells[i + 4, 2]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 5, 2], worksheet.Cells[i + 5, 2]).Value2 = "仪表名称：";
                worksheet.get_Range(worksheet.Cells[i + 5, 2], worksheet.Cells[i + 5, 2]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 6, 2], worksheet.Cells[i + 6, 2]).Value2 = "型号/规格：";
                worksheet.get_Range(worksheet.Cells[i + 6, 2], worksheet.Cells[i + 6, 2]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 7, 2], worksheet.Cells[i + 7, 2]).Value2 = "送检出厂编号：";
                worksheet.get_Range(worksheet.Cells[i + 7, 2], worksheet.Cells[i + 7, 2]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 8, 2], worksheet.Cells[i + 8, 2]).Value2 = "准确度等级：";
                worksheet.get_Range(worksheet.Cells[i + 8, 2], worksheet.Cells[i + 8, 2]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 9, 2], worksheet.Cells[i + 9, 2]).Value2 = "生产厂家：";
                worksheet.get_Range(worksheet.Cells[i + 9, 2], worksheet.Cells[i + 9, 2]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 10, 2], worksheet.Cells[i + 10, 2]).Value2 = "检定结果：";
                worksheet.get_Range(worksheet.Cells[i + 10, 2], worksheet.Cells[i + 10, 2]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 11, 3], worksheet.Cells[i + 11, 7]).Value2 = "主 管：";
                worksheet.get_Range(worksheet.Cells[i + 11, 3], worksheet.Cells[i + 11, 7]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 12, 3], worksheet.Cells[i + 12, 7]).Value2 = "核验员：";
                worksheet.get_Range(worksheet.Cells[i + 12, 3], worksheet.Cells[i + 12, 7]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 13, 3], worksheet.Cells[i + 13, 7]).Value2 = "检定员：";
                worksheet.get_Range(worksheet.Cells[i + 13, 3], worksheet.Cells[i + 13, 7]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 15, 2], worksheet.Cells[i + 15, 2]).Value2 = "准确度等级：";
                worksheet.get_Range(worksheet.Cells[i + 15, 2], worksheet.Cells[i + 15, 2]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 16, 2], worksheet.Cells[i + 16, 2]).Value2 = "准确度等级：";
                worksheet.get_Range(worksheet.Cells[i + 16, 2], worksheet.Cells[i + 16, 2]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 15, 1], worksheet.Cells[i + 15, 2]).Value2 = "检定日期：";
                worksheet.get_Range(worksheet.Cells[i + 15, 1], worksheet.Cells[i + 15, 2]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 16, 1], worksheet.Cells[i + 16, 2]).Value2 = "有效期至：";
                worksheet.get_Range(worksheet.Cells[i + 16, 2], worksheet.Cells[i + 16, 2]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 15, 5], worksheet.Cells[i + 16, 5]).Value2 = "年";
                worksheet.get_Range(worksheet.Cells[i + 15, 6], worksheet.Cells[i + 15, 5]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 15, 8], worksheet.Cells[i + 16, 8]).Value2 = "月";
                worksheet.get_Range(worksheet.Cells[i + 15, 8], worksheet.Cells[i + 16, 8]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 15, 11], worksheet.Cells[i + 16, 11]).Value2 = "日";
                worksheet.get_Range(worksheet.Cells[i + 15, 11], worksheet.Cells[i + 16, 11]).Font.Size = "12";

                string[] s = new string[4];
                if (dt_text.Rows[0]["TEXTDATE"].ToString() != null && dt_text.Rows[0]["TEXTDATE"].ToString() != "")
                {
                    string textdate = Convert.ToDateTime(dt_text.Rows[0]["TEXTDATE"].ToString()).ToShortDateString();
                    s = textdate.Split(new char[] { '/' });
                }
                string[] v = new string[4];
                if (dt_text.Rows[0]["VALIDDATE"].ToString() != null && dt_text.Rows[0]["VALIDDATE"].ToString() != "")
                {
                    string VALIDDATE = Convert.ToDateTime(dt_text.Rows[0]["VALIDDATE"].ToString()).ToShortDateString();
                    v = VALIDDATE.Split(new char[] { '/' });
                }

                worksheet.get_Range(worksheet.Cells[i + 4, 18], worksheet.Cells[i + 5, 25]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 6, 18], worksheet.Cells[i + 10, 25]).Font.Size = "11";
                worksheet.get_Range(worksheet.Cells[i + 12, 18], worksheet.Cells[i + 13, 18]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 13, 20], worksheet.Cells[i + 13, 25]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 12, 18], worksheet.Cells[i + 13, 25]).Font.Size = "11";
                worksheet.get_Range(worksheet.Cells[i + 2, 2], worksheet.Cells[i + 3, 13]).Value2 = "证书编号:1503030100502001";
                worksheet.get_Range(worksheet.Cells[i + 4, 3], worksheet.Cells[i + 4, 12]).Value2 = dt_text.Rows[0]["COMPANY"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 5, 3], worksheet.Cells[i + 5, 12]).Value2 = dt_text.Rows[0]["YBMC"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 6, 3], worksheet.Cells[i + 6, 12]).Value2 = dt_text.Rows[0]["GGXH"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 7, 3], worksheet.Cells[i + 7, 12]).Value2 = dt_text.Rows[0]["CCBH"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 8, 3], worksheet.Cells[i + 8, 12]).Value2 = dt_text.Rows[0]["ZQDDJ"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 9, 3], worksheet.Cells[i + 9, 12]).Value2 = dt_text.Rows[0]["SCCJ"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 10, 3], worksheet.Cells[i + 10, 12]).Value2 = "合格";//不用读取
                worksheet.get_Range(worksheet.Cells[i + 11, 8], worksheet.Cells[i + 11, 12]).Value2 = dt_text.Rows[0]["COMPETENT"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 12, 8], worksheet.Cells[i + 12, 12]).Value2 = dt_text.Rows[0]["CHECKER"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 13, 8], worksheet.Cells[i + 13, 12]).Value2 = dt_text.Rows[0]["TEXTER"].ToString();
                worksheet.get_Range(worksheet.Cells[i + 15, 3], worksheet.Cells[i + 15, 4]).Value2 = s[0];
                worksheet.get_Range(worksheet.Cells[i + 15, 6], worksheet.Cells[i + 15, 7]).Value2 = s[1];
                worksheet.get_Range(worksheet.Cells[i + 15, 9], worksheet.Cells[i + 15, 10]).Value2 = s[2];
                worksheet.get_Range(worksheet.Cells[i + 16, 3], worksheet.Cells[i + 16, 4]).Value2 = v[0];
                worksheet.get_Range(worksheet.Cells[i + 16, 6], worksheet.Cells[i + 16, 7]).Value2 = v[1];
                worksheet.get_Range(worksheet.Cells[i + 16, 9], worksheet.Cells[i + 16, 10]).Value2 = v[2];
                worksheet.get_Range(worksheet.Cells[i + 1, 16], worksheet.Cells[i + 1, 27]).Value2 = "鉴 定 结 果";
                worksheet.get_Range(worksheet.Cells[i + 1, 16], worksheet.Cells[i + 1, 27]).Font.Size = "22";

                worksheet.get_Range(worksheet.Cells[i + 4, 18], worksheet.Cells[i + 7, 25]).Value2 = "测试:报警仪显示全亮，铃响。                消音:由设置消音延时参数决定。";
                worksheet.get_Range(worksheet.Cells[i + 4, 18], worksheet.Cells[i + 7, 25]).Font.Size = "12";
                worksheet.get_Range(worksheet.Cells[i + 4, 18], worksheet.Cells[i + 7, 25]).WrapText = true;

                worksheet.get_Range(worksheet.Cells[i + 10, 20], worksheet.Cells[i + 11, 23]).Value2 = "合格";
                worksheet.get_Range(worksheet.Cells[i + 10, 20], worksheet.Cells[i + 11, 23]).Font.Size = "12";
            }
        }
        try
        {
            string ppap =context.Server.MapPath("");
            filename = System.Guid.NewGuid() + ".xls";
            workbook.SaveCopyAs(ppap +"/"+ filename);//保存EXCEL文件           
            //Response.Write("<script>alert('文件创建成功！');</script>");
            //System.Diagnostics.Process[] excelProcess = System.Diagnostics.Process.GetProcessesByName("EXCEL");//创建进程对象
            //foreach (System.Diagnostics.Process p in excelProcess)
            //{
            //    p.Kill();//关闭进程
            //}
        }
        catch (Exception ex)
        {
            throw ex;
        }
        context.Response.Write(filename);
        context.Response.End();
    }
    //public void downloadfile(string s_fileName)
    //{
    //    HttpContext.Current.Response.ContentType = "application/ms-download";
    //    System.IO.FileInfo file = new System.IO.FileInfo(s_fileName);
    //    HttpContext.Current.Response.Clear();
    //    HttpContext.Current.Response.AddHeader("Content-Type", "application/octet-stream");
    //    HttpContext.Current.Response.Charset = "utf-8";
    //    HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment;filename=" + System.Web.HttpUtility.UrlEncode(file.Name, System.Text.Encoding.UTF8));
    //    HttpContext.Current.Response.AddHeader("Content-Length", file.Length.ToString());
    //    HttpContext.Current.Response.WriteFile(file.FullName);
    //    HttpContext.Current.Response.Flush();
    //    HttpContext.Current.Response.Clear();
    //    HttpContext.Current.Response.End();
    //}
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}