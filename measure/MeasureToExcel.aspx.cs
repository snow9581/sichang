using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class measure_MeasureToExcel : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        var name = "队名,矿名,岗位,站别,站名,系统编码,软件开发厂家,投用时间,上位机软件平台名称,上位机模块厂家名称,上位机配置,系统类型,系统模块CPU型号,系统模块CPU数量,系统模块AI模块型号,系统模块AI模块数量,系统模块AO模块型号,系统模块AO模块数量,系统模块DI模块型号,系统模块DI模块数量,系统模块DO模块型号,系统模块DO模块数量,系统模块电源型号,系统模块电源数量,系统模块其他模块型号,系统模块其他模块数量,辅助模块安全栅型号,辅助模块安全栅数量,辅助模块配电器型号,辅助模块配电器数量,辅助模块继电器型号,辅助模块继电器数量,辅助模块其他型号,辅助模块其他数量,系统状况,上位机源程序存储路径,下位机源程序存储路径,通讯方式,备注";
        var field = "DM,KM,GW,ZB,ZM,XTBM,RJKFCJ,TYSJ,SWRJPTMC,XWJMKCJMC,SWJPZ,XTLX,CPUXH,CPUSL,AIXH,AISL,AOXH,AOSL,DIXH,DISL,DOXH,DOSL,DYXH,DYSL,QTMKXH,QTMKSL,AQSXH,AQSSL,PDQXH,PDQSL,JDQXH,JDQSL,QTXH,QTSL,XTZK,SWJYCXCCLJ,SWJYCXCCLJ,TXFS,BZ";
        var location = "T_MEASURE";
        var condition = Request.Params["condition"];
        var search = Request.Params["search"];
        string[] names = name.Split(new[] { ',' });
        string[] fields = field.Split(new[] { ',' });
        string sql = "select ";
        for (int a = 0; a < fields.Length; a++)
        {
            if (fields[a].ToString().Contains("TCRQ") == true)
            {
                fields[a] = "to_char(" + fields[a].ToString() + ",'yyyy-mm-dd') AS " + fields[a].ToString();
            }
            else if (fields[a].ToString().Contains("DATE") == true || fields[a].ToString().Contains("DATE_P") == true || fields[a].ToString().Contains("DATE_R") == true)
            {
                fields[a] = "to_char(" + fields[a].ToString() + ",'yyyy-mm-dd') AS " + fields[a].ToString();
            }
            sql = sql + fields[a] + ",";
        }
        sql = sql.Substring(0, sql.Length - 1);
         sql += " from " + location + " WHERE 1=1 ";
        sql += condition; 
        DataTable dt;
        System.IO.StringWriter sw = new System.IO.StringWriter();
        try
        {
            DB db = new DB();
            dt = db.GetDataTable(sql);
            string stage = Request.Params["search"];
            DataTable[] new_dt = new DataTable[5];
            string[] stages;
            if (stage != null && stage != "")
            {
                stages = stage.Split(new[] { ',' });

                for (int i = 0; i < have_length(stage); i++)
                {
                    new_dt[i] = have_data_bySearch(dt, stages[i]);
                }
                dt = AddTable(new_dt, have_length(stage));
            }
            int[,] lengths = new int[dt.Rows.Count, names.Length];
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                DataRow r = dt.Rows[i];
                for (int j = 0; j < names.Length; j++)
                {
                    lengths[i, j] = GetLength(r[j].ToString());
                }
            }
            int[] length = new int[names.Length];
            for (int i = 0; i < names.Length; i++)
            {
                int max = 0;
                for (int j = 0; j < dt.Rows.Count; j++)
                {
                    if (lengths[j, i] > max)
                        max = lengths[j, i];
                }
                length[i] = max;
            }
            for (int i = 0; i < names.Length; i++)
            {
                int l = GetLength(names[i]);
                length[i] = length[i] > l ? length[i] : l;
            }
            string x = "<?xml version=\"1.0\"?><?mso-application progid=\"Excel.Sheet\"?><Workbook xmlns=\"urn:schemas-microsoft-com:office:spreadsheet\" xmlns:o=\"urn:schemas-microsoft-com:office:office\" xmlns:x=\"urn:schemas-microsoft-com:office:excel\" xmlns:ss=\"urn:schemas-microsoft-com:office:spreadsheet\" xmlns:html=\"http://www.w3.org/TR/REC-html40\"> <DocumentProperties xmlns=\"urn:schemas-microsoft-com:office:office\">  <LastAuthor>User</LastAuthor>  <Created>2014-10-26T02:51:03Z</Created>  <Version>11.9999</Version> </DocumentProperties> <ExcelWorkbook xmlns=\"urn:schemas-microsoft-com:office:excel\">  <WindowHeight>10695</WindowHeight>  <WindowWidth>21435</WindowWidth>  <WindowTopX>0</WindowTopX> <WindowTopY>105</WindowTopY>  <ProtectStructure>False</ProtectStructure>  <ProtectWindows>False</ProtectWindows> </ExcelWorkbook> <Styles>" +
            "<Style ss:ID=\"Default\" ss:Name=\"Normal\"><Alignment ss:Vertical=\"Center\"/><Borders/><Font ss:FontName=\"宋体\" x:CharSet=\"134\" ss:Size=\"12\"/>   <Interior/>   <NumberFormat/>   <Protection/>  </Style>  <Style ss:ID=\"s22\">   <Alignment ss:Horizontal=\"Center\" ss:Vertical=\"Center\" ss:WrapText=\"1\"/>   <Font ss:FontName=\"宋体\" x:CharSet=\"134\" ss:Size=\"12\" ss:Bold=\"1\"/>  </Style> </Styles> <Worksheet ss:Name=\"test\"><Table ss:ExpandedColumnCount=\"" + names.Length + "\" ss:ExpandedRowCount=\"" + (dt.Rows.Count + 1) + "\" x:FullColumns=\"1\"   x:FullRows=\"1\" ss:DefaultColumnWidth=\"54\" ss:DefaultRowHeight=\"14.25\">";
            for (int i = 0; i < names.Length; i++)
            {
                x += "<Column ss:AutoFitWidth=\"0\" ss:Width=\"" + ((length[i] < 400 ? length[i] : 100) * 7).ToString() + "\"/>";//最大宽度小于400
            }
            x += "<Row>";
            for (int i = 0; i < names.Length; i++)
            {
                x += ("<Cell ss:StyleID=\"s22\"><Data ss:Type=\"String\">" + names[i] + "</Data></Cell>   ");
            }
            x += "</Row>";
            sw.WriteLine(x);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                DataRow r = dt.Rows[i];
                string m = "<Row>";
                for (int j = 0; j < names.Length; j++)
                {
                    m += ("<Cell ss:StyleID=\"s22\">" + "<Data ss:Type=\"String\">" + r[j] + "</Data></Cell>");
                }
                m += "</Row>";
                sw.WriteLine(m);
            }
        }
        catch (Exception ex)
        {
            //SClog.insert("error", ex.ToString());
            Console.WriteLine(ex.ToString());
        }
        sw.WriteLine(" </Table> <WorksheetOptions xmlns=\"urn:schemas-microsoft-com:office:excel\"> <Print> <ValidPrinterInfo/> <PaperSizeIndex>9</PaperSizeIndex> <HorizontalResolution>600</HorizontalResolution> <VerticalResolution>0</VerticalResolution>" +
            "</Print> <Selected/> <Panes> <Pane> <Number>3</Number> <ActiveCol>5</ActiveCol> </Pane> </Panes> <ProtectObjects>False</ProtectObjects> <ProtectScenarios>False</ProtectScenarios>" +
            " </WorksheetOptions> </Worksheet></Workbook>");
        sw.Close();
        Response.AddHeader("Content-Disposition", "attachment; filename=test.xls");
        Response.ContentType = "application/ms-excel";
        Response.ContentEncoding = System.Text.Encoding.GetEncoding("utf-8");
        Response.Write(sw);
        Response.End();
    }
    public static int GetLength(string str)
    {
        if (str.Length == 0) return 0;
        System.Text.ASCIIEncoding ascii = new System.Text.ASCIIEncoding();
        int tempLen = 0; byte[] s = ascii.GetBytes(str);
        for (int i = 0; i < s.Length; i++)
        {
            if ((int)s[i] == 63)
            {
                tempLen += 2;
            }
            else
            {
                tempLen += 1;
            }
        }
        return tempLen;
    }
    //判断数据行属于哪个阶段
    public string what_stage(DataRow dr)
    {
        if (dr["PLANINVESMENT"].ToString() == "")
            return "solution";
        else if (dr["PLANINVESMENT"].ToString() != "" && dr["WORKLOADSUBMITDATE_R"].ToString() == "")
            return "design";
        else if (dr["WORKLOADSUBMITDATE_R"].ToString() != "" && dr["DESIAPPROVALARRIVALDATE"].ToString() == "")
            return "budget";
        else if (dr["DESIAPPROVALARRIVALDATE"].ToString() != "" && dr["BLUEGRAPHDOCUMENT_R"].ToString() == "")
            return "graph";
        else
            return "finished";
    }
    //根据阶段筛选数据，返回DataTable对象
    public DataTable have_data_bySearch(DataTable dt, string search)
    {
        DataTable new_dt = dt.Copy();
        new_dt.Clear();
        for (int i = 0; i < dt.Rows.Count; i++)
            if (what_stage(dt.Rows[i]) == search)
            {
                new_dt.ImportRow(dt.Rows[i]);
            }
        return new_dt;
    }
    //判断是否需要根据阶段筛选数据
    public DataTable search_data(DataTable dt, string search)
    {
        if (search == "")
            return dt;
        else
            return have_data_bySearch(dt, search);
    }
    //合并表单
    public DataTable AddTable(DataTable[] dt, int num)
    {
        DataTable new_dt = dt[0].Copy();
        new_dt.Clear();
        for (int i = 0; i < num; i++)
            for (int j = 0; j < dt[i].Rows.Count; j++)
                new_dt.ImportRow(dt[i].Rows[j]);
        return new_dt;
    }

    public int have_length(string str)
    {
        int num = 0;
        for (int i = 0; i < str.Length; i++)
            if (str[i] == ',')
                num++;
        return num;
    }
}
