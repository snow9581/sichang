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

public partial class toExcel : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        var name = Request.Params["name"];
        var field = Request.Params["field"];
        var location = Request.Params["location"];
        var condition = Request.Params["condition"];
        var stage = Request.Params["search"];
        var flagCurStage = Request.Params["flagCurStage"];
        string[] names = name.Split(new[] { ',' });
        string[] fields = field.Split(new[] { ',' });
        string sql = "select ";
        if (flagCurStage == "1")
        {
            sql += "*";
        }
        else
        {
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
            
        }
        //计划运行中对阶段的查询
        if (stage != "" && stage != null)
        {
            condition += sql_stage(stage);
        }
        sql += " from " + location + " WHERE 1=1 ";
        sql += condition;
        
        DataTable dt;
        System.IO.StringWriter sw = new System.IO.StringWriter();
        try
        {
            DB db = new DB();
            dt = db.GetDataTable(sql);
            if (flagCurStage == "1")//为计划运行（所长）添加当前状态字段
            {
                DataTable dd=new DataTable();
                dt.Columns.Add("CURRENTPROGRESS");
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    dt.Rows[i]["CURRENTPROGRESS"] = what_stage(dt.Rows[i]);
                }

                DataView view = dt.DefaultView;
                dd = view.ToTable(true, fields);
                dt.Clear();
                dt = dd;
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
    //拼接按阶段查询的sql查询语句
    public string sql_stage(string stage)
    {
        Hashtable htStage = new Hashtable(); //创建一个Hashtable实例  
        htStage.Add("solution", "and ( PNUMBER is null or DESICONDITIONTABLE is null ) ");//添加key/value键值对  
        htStage.Add("design", " and PNUMBER is not null and DESICONDITIONTABLE is not null and WORKLOADSUBMITDATE_R is null ");
        htStage.Add("budget", " and WORKLOADSUBMITDATE_R is not null and PLANARRIVALDATE is null ");
        htStage.Add("graph", " and PLANARRIVALDATE is not null and BLUEGRAPHARRIVALDATE is null");
        htStage.Add("finished", " and BLUEGRAPHARRIVALDATE is not null and PNUMBER is not null and DESICONDITIONTABLE is not null ");

        return htStage[stage].ToString();
    }
    //判断数据行属于哪个阶段
    public string what_stage(DataRow dr)
    {
        if (dr["PNUMBER"].ToString() != "" && dr["DESICONDITIONTABLE"].ToString() != "" && dr["WORKLOADSUBMITDATE_R"].ToString() == "")
            return "初设阶段";
        else if (dr["WORKLOADSUBMITDATE_R"].ToString() != "" && dr["PLANARRIVALDATE"].ToString() == "")
            return "概算阶段";
        else if (dr["PLANARRIVALDATE"].ToString() != "" && dr["BLUEGRAPHARRIVALDATE"].ToString() == "")
            return "施工图阶段";
        else if (dr["DESICONDITIONTABLE"].ToString() == "" || dr["PNUMBER"].ToString() == "")
            return "方案阶段";
        else
            return "已完成";
    }
}
