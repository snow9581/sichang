using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.OleDb;
using System.Data;

/// <summary>
///Excel 的摘要说明
/// </summary>
public class ExcelToSql
{
    string Path;//excel物理路径
	public ExcelToSql(string path)//构造函数
	{
        Path = path;
	}
    private OleDbConnection GetConn() //根据对象构造函数参数获取连接对象
    {     
        string ConnStr = "Provider=Microsoft.Jet.OLEDB.4.0;" + "Data Source=" + Path + ";" + ";Extended Properties=\"Excel 8.0;HDR=YES;IMEX=1\"";
        OleDbConnection conn = new OleDbConnection(ConnStr);
        return conn;
    }
    public static OleDbConnection GetConn(string ConnStr)//根据给定连接字符串获取连接对象
    {
        OleDbConnection conn=new OleDbConnection(ConnStr);
        return conn;
    }
    public static DataSet GetDataSet(OleDbConnection conn)//根据给定连接对象获取DataSet
    {
        OleDbDataAdapter oa = null;
        DataTable dt = null;
        DataSet ds = new DataSet();
        string sql_F = "select * from [{0}]";

        try
        {
            conn.Open();

            string SheetName = "";//工作表的名字
            dt = conn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, new object[] { null, null, null, "TABLE" });

            oa = new OleDbDataAdapter();
            for (int i = 0; i < dt.Rows.Count; i++)//循环每一个工作表
            {
                SheetName = (string)dt.Rows[i]["TABLE_NAME"];
                if (SheetName.Contains("$") && !SheetName.Replace("'", "").EndsWith("$"))
                {
                    continue;
                }
                oa.SelectCommand = new OleDbCommand(String.Format(sql_F, SheetName), conn);
                DataSet dsItem = new DataSet();
                oa.Fill(dsItem, SheetName);
                ds.Tables.Add(dsItem.Tables[0].Copy());
            }
            conn.Close();
            oa.Dispose();
            conn.Dispose();
        }
        catch (Exception e)
        {
            SClog.insert("Upfile ", e.ToString());
        }
        return ds;
    }
    private DataSet GetDataSet()//根据对象构造函数参数获取DataSet
    {
        OleDbConnection conn = GetConn();
        OleDbDataAdapter oa = null;
        DataTable dt = null;
        DataSet ds = new DataSet();
        string sql_F = "select * from [{0}]";
        try
        {
            conn.Open();

            string SheetName = "";//工作表的名字
            dt = conn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, new object[] { null, null, null, "TABLE" });

            oa = new OleDbDataAdapter();
            for (int i = 0; i < dt.Rows.Count; i++)//循环每一个工作表
            {
                SheetName = (string)dt.Rows[i]["TABLE_NAME"];
                if (SheetName.Contains("$") && !SheetName.Replace("'", "").EndsWith("$"))
                {
                    continue;
                }
                oa.SelectCommand = new OleDbCommand(String.Format(sql_F, SheetName), conn);
                DataSet dsItem = new DataSet();
                oa.Fill(dsItem, SheetName);
                ds.Tables.Add(dsItem.Tables[0].Copy());
            }
            conn.Close();
            oa.Dispose();
            conn.Dispose();
        }
        catch (Exception e)
        {
            SClog.insert("Upfile ", e.ToString());
        }
        return ds;
    }
    public static bool Exist(string x, List<string> list)//某string类型是否存在于某List对象中，返回布尔值
    {
        for (int i = 0; i < list.Count; i++)
            if (x == list[i])
                return true;
        return false;
    }
    public static int Exist_int(string x, List<string> list)//某string类型是否存在于某List对象中，返回索引
    {
        for (int i = 0; i < list.Count; i++)
            if (x == list[i])
                return i;
        return -1;
    }
    private string[] GetSqls(DataSet ds)//根据指定DataTable获取SQL语句
    {
        List<string> sqls = new List<string>();
        //表名
        string table_name = "";
        //序列名
        string seq_name = "";
        //列字段
        List<string> table_columns = new List<string>();
        //数据段类型
        List<string> table_type = new List<string>();
        //需要从SESSION中获取的数据
        List<string> session_data = new List<string>();
        //需要当前时间的字段
        List<string> nowtime = new List<string>();
        //字段限制
        List<string> limit_columns = new List<string>();
        List<string>[] limit = new List<string>[10];

        //获取配置信息
        bool IsColumnsFinish = false;
        for (int m = 0; m < ds.Tables[0].Columns.Count; m++)
        {
            if (ds.Tables[0].Rows[0][m].ToString() == "0")
                IsColumnsFinish = true;
            if (!IsColumnsFinish)
            {
                //提取列字段
                table_columns.Add(ds.Tables[0].Rows[0][m].ToString());
                //提取数据段类型
                table_type.Add(ds.Tables[0].Rows[1][m].ToString());
            }
            else
            {
                //提取需要从SESSION中获取的数据
                if (ds.Tables[0].Rows[0][m].ToString() == "SESSION")
                    session_data.Add(ds.Tables[0].Rows[1][m].ToString());
                //提取表名
                if (ds.Tables[0].Rows[0][m].ToString() == "TABLE_NAME")
                    table_name = ds.Tables[0].Rows[1][m].ToString();
                //提取序列名
                if (ds.Tables[0].Rows[0][m].ToString() == "SEQ_NAME")
                    seq_name = ds.Tables[0].Rows[1][m].ToString();
                //提取需要获取当前时间的字段
                if (ds.Tables[0].Rows[0][m].ToString() == "NOW")
                    nowtime.Add(ds.Tables[0].Rows[1][m].ToString());
                //提取字段限制信息
                if (ds.Tables[0].Rows[0][m].ToString().Contains("LIMIT_"))
                {
                    limit_columns.Add(ds.Tables[0].Rows[0][m].ToString().Substring(6, ds.Tables[0].Rows[0][m].ToString().Length - 6));
                    limit[limit_columns.Count] = new List<string>(ds.Tables[0].Rows[1][m].ToString().Split(','));
                }
            }
        }
        //判断是否有足够的信息获得SQL语句
        if (table_name == "" || seq_name == "" || table_type.Count == 0 || table_columns.Count == 0)
        {
            return sqls.ToArray();
        }
        return sqls.ToArray();
    }
}